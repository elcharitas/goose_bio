// Copyright (c) 2026 Jonathan Irhodia. MIT license.
namespace bio;
import math;

/* Use log_probability only when error is empty. Impossible alignments succeed with negative infinity.
 * Both empty sequences give log zero globally and negative infinity with free ends; exactly one empty
 * gives negative infinity in every mode, regardless of starts. */
struct RustBioPairHMMResult { log_probability: f64, error: u8[] }

fn rbph_add(a: f64, b: f64) -> f64 {
    if is_inf(a) { return b; }
    if is_inf(b) { return a; }
    let hi = if a > b { a } else { b };
    let lo = if a > b { b } else { a };
    return hi + rbph_log1p(exp(lo-hi));
}

/* Log sums use log1p with standard exponentials. Rolling terminal sums have binary64 rounding
 * limits. */
fn rbph_log1p(v: f64) -> f64 {
    let rounded = 1.0+v;
    if rounded == 1.0 { return v; }
    return log(rounded)*v/(rounded-1.0);
}

// Two components retain cancellation bits at the gap-open boundary.
struct RbphWide { hi: f64, lo: f64 }
fn rbph_wadd(a: RbphWide, b: RbphWide) -> RbphWide {
    let s = a.hi+b.hi; let v = s-a.hi;
    let e = (a.hi-(s-v))+(b.hi-v)+a.lo+b.lo;
    let h = s+e;
    return RbphWide { h, e-(h-s) };
}
fn rbph_wmul(a: RbphWide, b: RbphWide) -> RbphWide {
    let p = a.hi*b.hi;
    let ca = 134217729.0*a.hi; let ah = ca-(ca-a.hi);
    let cb = 134217729.0*b.hi; let bh = cb-(cb-b.hi);
    let al = a.hi-ah; let bl = b.hi-bh;
    let e = ((ah*bh-p)+ah*bl+al*bh)+al*bl+a.hi*b.lo+a.lo*b.hi;
    let h = p+e;
    return RbphWide { h, e-(h-p) };
}
fn rbph_wdiv(a: RbphWide, d: f64) -> RbphWide {
    let q = a.hi/d;
    let p = rbph_wmul(RbphWide { q,0.0 },RbphWide { -d,0.0 });
    let r = rbph_wadd(a,p);
    return rbph_wadd(RbphWide { q,0.0 },RbphWide { (r.hi+r.lo)/d,0.0 });
}
fn rbph_wexpm1(v: f64) -> RbphWide {
    var term = RbphWide { v,0.0 }; var total = term;
    for k in 2..40 {
        term = rbph_wdiv(rbph_wmul(term,RbphWide { v,0.0 }),k);
        total = rbph_wadd(total,term);
    }
    return total;
}

/* Gap-open validation and subtraction share two-component arithmetic; sums above one reject without
 * epsilon clamping. Compensated small-argument series and exact power-of-two scaling preserve tiny
 * representable complements before logarithms. */
fn rbph_gap_complement(a: f64, b: f64) -> f64 {
    let hi = if a > b { a } else { b };
    let lo = if a > b { b } else { a };
    if is_inf(lo) { return rbph_complement(hi); }
    if hi == 0.0 { return 0.0/0.0; }
    if hi < -0.7 { return rbph_complement(rbph_add(hi,lo)); }
    let e = rbph_wexpm1(hi);
    let available = RbphWide { -e.hi,-e.lo };
    // Below this bound the term cannot affect a binary64 complement.
    if lo < -1490.0 { return log(available.hi); }
    var other = rbph_wadd(RbphWide { 1.0,0.0 },rbph_wexpm1(lo/1024.0));
    for k in 9 { other = rbph_wmul(other,other); }
    // Exact binary scaling avoids subnormal cancellation products.
    var scale = 1.0;
    if lo < -600.0 { scale = 6.696928794914171e299; }
    let root_scale = if scale > 1.0 { 8.183476519740355e149 } else { 1.0 };
    other = RbphWide { other.hi*root_scale,other.lo*root_scale };
    other = rbph_wmul(other,other);
    let capacity = RbphWide { available.hi*scale,available.lo*scale };
    let rest = rbph_wadd(capacity,RbphWide { -other.hi,-other.lo });
    if rest.hi < 0.0 { return 0.0/0.0; }
    if rest.hi == 0.0 { return log(0.0); }
    return log(rest.hi)+rbph_log1p(rest.lo/rest.hi)-log(scale);
}
fn rbph_complement(v: f64) -> f64 {
    if v == 0.0 { return log(0.0); }
    if v > -0.7 {
        let e = rbph_wexpm1(v);
        return log(-e.hi)+rbph_log1p(e.lo/e.hi);
    }
    return rbph_log1p(-exp(v));
}

/* Optional small-sum approximation requires strict top-minus-second > 10 at M transitions; otherwise
 * the full three-term sum is used. Approximation can change the result. */
fn rbph_three(a: f64, b: f64, c: f64, approximate: bool) -> f64 {
    var hi = a; var mid = b; var low = c;
    if mid < low { let t = mid; mid = low; low = t; }
    if mid > hi { let t = hi; hi = mid; mid = t; }
    if approximate && hi-mid > 10.0 { return hi; }
    if is_inf(hi) { return hi; }
    return rbph_add(rbph_add(hi,mid),low);
}

// Empty starts selects the global or semiglobal default.
// Explicit starts override free_start.
// gx/ex govern y-only emissions; gy/ey govern x-only emissions.

/* Pair emissions are row-major m*n, with separate x-only/y-only arrays. Logs are nonpositive or
 * negative infinity. Explicit m start weights override defaults: global starts have zero probability,
 * free starts unit probability. The origin already has unit probability, so the first free start
 * doubles it. Before each x row, its start enters the preceding row column-zero M. */
fn rustbio_pairhmm_checked(m: i64, n: i64, paired: const f64[:],
    x: const f64[:], y: const f64[:], gx: f64, gy: f64,
    ex: f64, ey: f64, starts: const f64[:], free_start: bool,
    free_end: bool, approximate: bool) -> RustBioPairHMMResult {
    let neg = log(0.0);
    /* Dimensions, lengths, NaN, positive logs, and gap-open sums above one reject. Padded cells cap
     * at 4,000,000 before allocation; finite logs below -1e300 reject to prevent overflow
     * masquerading as impossibility. Reachability is not controlled by probability-space products.
     * Work is O(m*n+m+n), rows O(n), caller emissions O(m*n). No homopolymer, quality/alphabet
     * model, training, posterior, traceback or biological calibration. */
    if m < 0 || n < 0 || m > 4000000 || n > 4000000 {
        return RustBioPairHMMResult { neg, "dimension limit" };
    }
    if (m+1) > 4000000/(n+1) {
        return RustBioPairHMMResult { neg, "work limit" };
    }
    if paired.len != m*n || x.len != m || y.len != n ||
        (starts.len != 0 && starts.len != m) {
        return RustBioPairHMMResult { neg, "dimension mismatch" };
    }
    var weights: f64[>..] = [gx,gy,ex,ey];
    for v in weights { if is_nan(v) || v > 0.0 {
        return RustBioPairHMMResult { neg, "invalid log probability" };
    } }
    for v in paired { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMResult { neg, "invalid log or arithmetic range" };
    } }
    for v in x { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMResult { neg, "invalid log or arithmetic range" };
    } }
    for v in y { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMResult { neg, "invalid log or arithmetic range" };
    } }
    for v in starts { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMResult { neg, "invalid log or arithmetic range" };
    } }
    for v in weights { if v < -1e300 && !is_inf(v) {
        return RustBioPairHMMResult { neg, "arithmetic range" };
    } }
    let mm = rbph_gap_complement(gx,gy);
    if is_nan(mm) {
        return RustBioPairHMMResult { neg, "gap opens exceed one" };
    }
    let rx = rbph_complement(ex); let ry = rbph_complement(ey);
    let w = n+1;
    /* Gap x consumes y, opens gx, extends ex, and returns 1-ex; gap y consumes x with gy, ey, and 1-ey. M
     * continues with 1-gx-gy. Opposite gaps have no direct transition. Every consumed position emits,
     * including extensions. Only interior cells compute gap states; leading gap boundaries stay zero.
     * Global termination sums three states at m,n; free ends sum column n after each x row. Scores above
     * zero clip to zero. */
    var prev: f64[>..] = []; var curr: f64[>..] = [];
    for k in w*3 { prev.push(neg); curr.push(neg); }
    prev[0] = 0.0;
    var total = neg;
    for i in m {
        let start = if starts.len > 0 { starts[i] }
            else if free_start { 0.0 } else { neg };
        prev[0] = rbph_add(prev[0], start);
        for k in w*3 { curr[k] = neg; }
        for j in 1..w {
            let p = (j-1)*3; let q = j*3;
            curr[q] = paired[i*n+j-1] + rbph_three(
                mm+prev[p], ry+prev[p+1], rx+prev[p+2], approximate);
            curr[q+1] = rbph_add(x[i]+gy+prev[q], x[i]+ey+prev[q+1]);
            curr[q+2] = rbph_add(y[j-1]+gx+curr[p], y[j-1]+ex+curr[p+2]);
        }
        if free_end { for s in 3 { total = rbph_add(total,curr[n*3+s]); } }
        for k in w*3 { prev[k] = curr[k]; }
    }
    if !free_end { for s in 3 { total = rbph_add(total,prev[n*3+s]); } }
    if is_nan(total) || is_nan(mm) {
        return RustBioPairHMMResult { neg, "arithmetic failure" };
    }
    return RustBioPairHMMResult { if total > 0.0 { 0.0 } else { total }, "" };
}

// Labels: zero is Match, one is Mismatch, independent of log weight.

/* scanned_cells counts visited interior cells; admitted_cells counts cells whose three probability
 * states enter the recurrence. Errors return zero counts. Even skipped columns are scanned: pruning
 * retains O(m*n+m+n) work and O(n) rows, with the 4,000,000 padded-cell limit. */
struct RustBioPairHMMPrunedResult {
    log_probability: f64, scanned_cells: i64, admitted_cells: i64,
    error: u8[]
}


fn rbph_distance_next(v: i64) -> i64 {
    if v == 9223372036854775807 { return v; }
    return v+1;
}

/* Labels are row-major i64: 0 Match, 1 Mismatch, independent of emissions. Disabled pruning still
 * requires valid labels and a nonnegative budget; it differs from enabled pruning with budget zero.
 * All dimension, label, log, complement, and budget checks precede row allocation. Check error before
 * score. Start/end modes, empties, complements, clipping, and approximation retain the unpruned
 * contract. */
fn rustbio_pairhmm_pruned_checked(m: i64, n: i64, paired: const f64[:],
    x: const f64[:], y: const f64[:], gx: f64, gy: f64,
    ex: f64, ey: f64, starts: const f64[:], free_start: bool,
    free_end: bool, approximate: bool, labels: const i64[:],
    pruning: bool, budget: i64) -> RustBioPairHMMPrunedResult {
    let neg = log(0.0);
    if m < 0 || n < 0 || m > 4000000 || n > 4000000 {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "dimension limit" };
    }
    if (m+1) > 4000000/(n+1) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "work limit" };
    }
    if paired.len != m*n || x.len != m || y.len != n ||
        (starts.len != 0 && starts.len != m) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "dimension mismatch" };
    }
    if budget < 0 || labels.len != m*n {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid labels or budget" };
    }
    for v in labels { if v != 0 && v != 1 {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid label" };
    } }
    var weights: f64[>..] = [gx,gy,ex,ey];
    for v in weights { if is_nan(v) || v > 0.0 {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid log probability" };
    } }
    for v in paired { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid log or arithmetic range" };
    } }
    for v in x { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid log or arithmetic range" };
    } }
    for v in y { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid log or arithmetic range" };
    } }
    for v in starts { if is_nan(v) || v > 0.0 || (v < -1e300 && !is_inf(v)) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "invalid log or arithmetic range" };
    } }
    for v in weights { if v < -1e300 && !is_inf(v) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "arithmetic range" };
    } }
    let mm = rbph_gap_complement(gx,gy);
    if is_nan(mm) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "gap opens exceed one" };
    }
    let rx = rbph_complement(ex); let ry = rbph_complement(ey);
    let w = n+1;
    var prev: f64[>..] = []; var curr: f64[>..] = [];
    for k in w*3 { prev.push(neg); curr.push(neg); }
    let unreachable = 9223372036854775807;
    /* Distances start unreachable except the origin; rows reset after each step.
     * Free starts refresh column zero independently of explicit start weights. */
    var dp: i64[>..] = []; var dc: i64[>..] = [];
    for k in w { dp.push(unreachable); dc.push(unreachable); }
    dp[0] = 0;
    var scanned: i64 = 0; var admitted: i64 = 0;
    prev[0] = 0.0;
    var total = neg;
    for i in m {
        let start = if starts.len > 0 { starts[i] }
            else if free_start { 0.0 } else { neg };
        prev[0] = rbph_add(prev[0], start);
        for k in w*3 { curr[k] = neg; }
        if free_start { dp[0] = 0; }
        for k in w { dc[k] = unreachable; }
        for j in 1..w {
            scanned += 1;
            /* Admission uses predecessor distance before the current label cost.
             * A first-cell mismatch therefore survives budget zero. */
            let best = min(dp[j-1], min(dp[j],dc[j-1]));
            if pruning && best > budget { continue; }
            /* All three probability states enter an admitted cell.
             * This is not a sum over paths restricted to a final edit budget. */
            admitted += 1;
            if pruning {
                let diagonal = if labels[i*n+j-1] == 0 {
                    dp[j-1]
                } else { rbph_distance_next(dp[j-1]) };
                dc[j] = min(diagonal, min(rbph_distance_next(dp[j]),
                    rbph_distance_next(dc[j-1])));
            }
            let p = (j-1)*3; let q = j*3;
            curr[q] = paired[i*n+j-1] + rbph_three(
                mm+prev[p], ry+prev[p+1], rx+prev[p+2], approximate);
            curr[q+1] = rbph_add(x[i]+gy+prev[q], x[i]+ey+prev[q+1]);
            curr[q+2] = rbph_add(y[j-1]+gx+curr[p], y[j-1]+ex+curr[p+2]);
        }
        if free_end { for s in 3 { total = rbph_add(total,curr[n*3+s]); } }
        for k in w*3 { prev[k] = curr[k]; }
        for k in w { dp[k] = dc[k]; }
    }
    if !free_end { for s in 3 { total = rbph_add(total,prev[n*3+s]); } }
    if is_nan(total) || is_nan(mm) {
        return RustBioPairHMMPrunedResult { neg, 0, 0, "arithmetic failure" };
    }
    return RustBioPairHMMPrunedResult { if total > 0.0 { 0.0 } else { total }, scanned, admitted, "" };
}
