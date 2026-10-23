// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import math;

/* Alpha and beta are time-major log grids; posterior contains probability marginals. Impossible
 * observations succeed with log_z=-infinity, defined=false, and no posterior. Numerical errors instead
 * return defined=false and empty arrays. Check error before using outputs. */
struct HMMPosterior {
    alpha: f64[], beta: f64[], posterior: f64[], log_z: f64,
    defined: bool, error: u8[]
}

/* Dense grids and transitions determine memory and time, and public arrays can be large within
 * limits. No training, position-dependent transitions, continuous emissions, or PairHMM extensions.
 * RustBio MIT notice remains in tests/reference/hmm_posterior/RUST_BIO_LICENSE.md. */
fn hmm_posterior_error(message: const u8[:]) -> HMMPosterior {
    var text: u8[>..] = [];
    for c in message { text.push(c); }
    return HMMPosterior { [], [], [], log(0.0), false, copy(text) };
}
// Keep the common offset separate from the log-sum correction.

/* Two binary64 components retain roughly 106 significant bits in sums; exp and log remain binary64.
 * Rounded-away input differences cannot be recovered. Extreme separated scores may underflow marginals
 * to zero; this is not arbitrary precision. */
struct HMMLog { hi: f64, lo: f64, bad: bool }
// TwoSum retains the exact residual of a finite binary64 addition.
fn hmm_two_sum(a: f64, b: f64) -> HMMLog {
    let hi = a+b;
    let v = hi-a;
    return HMMLog { hi, (a-(hi-v))+(b-v),
        is_inf(hi) || is_nan(hi) };
}

/* Centered additions reject omitted residuals above 1e-24 log units and nonfinite finite-input sums.
 * The sticky check covers factors, alpha, beta, likelihood, and row contrasts, including paths that do
 * not contribute to posterior. Mixed scales reject without clamping; this budget does not bound
 * exp/log errors or guarantee arbitrary accuracy. */
fn hmm_log_sum(a: HMMLog, b: HMMLog) -> HMMLog {
    let bad = a.bad || b.bad;
    if is_inf(a.hi) || is_inf(b.hi) {
        return HMMLog { log(0.0), 0.0, bad };
    }
    let top = hmm_two_sum(a.hi,b.hi);
    if top.bad { return top; }
    let low = hmm_two_sum(a.lo,b.lo);
    let tail = hmm_two_sum(top.lo,low.hi);
    let value = hmm_two_sum(top.hi,tail.hi);
    // Both omitted residuals must fit the absolute per-add budget.
    return HMMLog { value.hi, value.lo,
        bad || top.bad || low.bad || tail.bad || value.bad ||
        abs(low.lo) > 1e-24 || abs(tail.lo) > 1e-24 };
}

/* Each model factor is centered by its largest finite weight. Compensated scores retain small log-sum
 * corrections; separate common offsets reconstruct absolute grids and likelihood. Unrepresentable
 * absolute entries are numerical errors even if another complete path has a representable likelihood.
 * Negative infinity paths retain impossible-observation semantics. */
fn hmm_log_weight(a: HMMLog, b: f64) -> HMMLog {
    return hmm_log_sum(a,HMMLog { b, 0.0, false });
}
fn hmm_log_merge(a: HMMLog, b: HMMLog) -> HMMLog {
    if a.bad || b.bad { return HMMLog { 0.0, 0.0, true }; }
    if is_inf(a.hi) { return b; }
    if is_inf(b.hi) { return a; }
    let greater = a.hi > b.hi || (a.hi == b.hi && a.lo > b.lo);
    let hi = if greater { a } else { b };
    let lo = if greater { b } else { a };
    let delta = hmm_log_sum(lo,HMMLog { -hi.hi, -hi.lo, hi.bad });
    if delta.bad { return HMMLog { 0.0, 0.0, true }; }
    return hmm_log_weight(hi,log(1.0+exp(delta.hi+delta.lo)));
}


fn hmm_log_peak(values: const f64[:]) -> f64 {
    var peak = log(0.0);
    for v in values { if v > peak { peak = v; } }
    return if is_inf(peak) { 0.0 } else { peak };
}
// Empty terminal means zero exit log weights. All grids use time-major rows.

/* Transitions use [from*states+to], emissions [state*alphabet+symbol]. Logs may be finite nonpositive
 * values or negative infinity; weights are not normalized. Empty terminal means zero log weights.
 * Empty observations reject. Before allocation: at most 64 states, 4096 symbols, 1,000,000 state-time
 * cells per grid, and 50,000,000 evaluations, counted as 2*(T-1)*S*S. Dimension bounds precede
 * products. */
fn hmm_posterior_log(obs: const i64[:], initial: const f64[:],
    transition: const f64[:], emission: const f64[:], alphabet: i64,
    terminal: const f64[:]) -> HMMPosterior {
    let n = initial.len; let t = obs.len;
    if n < 1 || n > 64 || alphabet < 1 || alphabet > 4096 || t < 1 {
        return hmm_posterior_error("invalid dimensions or empty observations");
    }
    if t > 1000000/n || t-1 > 50000000/(2*n*n) {
        return hmm_posterior_error("work limit exceeded");
    }
    if transition.len != n*n || emission.len != n*alphabet ||
        (terminal.len != 0 && terminal.len != n) {
        return hmm_posterior_error("matrix dimensions do not match");
    }
    for v in initial { if is_nan(v) || v > 0.0 { return hmm_posterior_error("invalid log weight"); } }
    for v in transition { if is_nan(v) || v > 0.0 { return hmm_posterior_error("invalid log weight"); } }
    for v in emission { if is_nan(v) || v > 0.0 { return hmm_posterior_error("invalid log weight"); } }
    for v in terminal { if is_nan(v) || v > 0.0 { return hmm_posterior_error("invalid log weight"); } }
    for symbol in obs { if symbol < 0 || symbol >= alphabet { return hmm_posterior_error("invalid symbol"); } }
    let neg = log(0.0);
    let ip = hmm_log_peak(initial); let ep = hmm_log_peak(emission);
    let ap = hmm_log_peak(transition); let bp = hmm_log_peak(terminal);
    var ci: HMMLog[>..] = []; var ce: HMMLog[>..] = [];
    var ca: HMMLog[>..] = []; var cb: HMMLog[>..] = [];
    for v in initial { ci.push(hmm_log_weight(HMMLog { v, 0.0, false },-ip)); }
    for v in emission { ce.push(hmm_log_weight(HMMLog { v, 0.0, false },-ep)); }
    for v in transition { ca.push(hmm_log_weight(HMMLog { v, 0.0, false },-ap)); }
    for v in terminal { cb.push(hmm_log_weight(HMMLog { v, 0.0, false },-bp)); }
    var ao: HMMLog[>..] = []; var bo: HMMLog[>..] = [];
    var offset = hmm_log_weight(HMMLog { ip, 0.0, false },ep);
    // Absolute offsets never feed centered posterior arithmetic.
    for row in t {
        ao.push(HMMLog { offset.hi, offset.lo, false });
        offset = hmm_log_weight(hmm_log_weight(offset,ap),ep);
    }
    offset = HMMLog { bp, 0.0, false };
    for row in t {
        bo.push(HMMLog { offset.hi, offset.lo, false });
        offset = hmm_log_weight(hmm_log_weight(offset,ap),ep);
    }
    var a: HMMLog[>..] = []; var b: HMMLog[>..] = [];
    var reachable: bool[>..] = [];
    for i in t*n {
        a.push(HMMLog { neg, 0.0, false }); b.push(HMMLog { neg, 0.0, false });
        reachable.push(false);
    }
    for s in n {
        a[s] = hmm_log_sum(ci[s],ce[s*alphabet+obs[0]]);
        reachable[s] = !is_inf(ci[s].hi) && !is_inf(ce[s*alphabet+obs[0]].hi);
        b[(t-1)*n+s] = if cb.len == 0 { HMMLog { 0.0, 0.0, false } } else { cb[s] };
        if reachable[s] && is_inf(a[s].hi) {
            return hmm_posterior_error("numerical overflow in alpha");
        }
    }
    for k in 1..t { for s in n {
        var total = HMMLog { neg, 0.0, false };
        var possible = false;
        for p in n {
            let edge = ca[p*n+s];
            let term = hmm_log_sum(a[(k-1)*n+p],edge);
            if reachable[(k-1)*n+p] && !is_inf(edge.hi) {
                if is_inf(term.hi) { return hmm_posterior_error("numerical overflow in alpha"); }
                possible = true;
            }
            total = hmm_log_merge(total,term);
        }
        let emit = ce[s*alphabet+obs[k]];
        a[k*n+s] = hmm_log_sum(total,emit);
        reachable[k*n+s] = possible && !is_inf(emit.hi);
        if reachable[k*n+s] && is_inf(a[k*n+s].hi) {
            return hmm_posterior_error("numerical overflow in alpha");
        }
    } }
    /* Beta ends at the terminal factor. Earlier rows sum each transition,
     * the next emission, and the next beta value. */
    var k = t-1;
    while k > 0 {
        k -= 1;
        for s in n {
            var total = HMMLog { neg, 0.0, false };
            for next in n {
                let edge = ca[s*n+next];
                let emit = ce[next*alphabet+obs[k+1]];
                let tail = b[(k+1)*n+next];
                if !is_inf(edge.hi) && !is_inf(emit.hi) && !is_inf(tail.hi) {
                    let term = hmm_log_sum(hmm_log_sum(tail,edge),emit);
                    if is_inf(term.hi) { return hmm_posterior_error("numerical overflow in beta"); }
                    total = hmm_log_merge(total,term);
                }
            }
            b[k*n+s] = total;
        }
    }
    var z = HMMLog { neg, 0.0, false };
    for s in n {
        if !is_inf(a[(t-1)*n+s].hi) && !is_inf(b[(t-1)*n+s].hi) {
            let term = hmm_log_sum(a[(t-1)*n+s],b[(t-1)*n+s]);
            if is_inf(term.hi) { return hmm_posterior_error("numerical overflow in likelihood"); }
            z = hmm_log_merge(z,term);
        }
    }
    for v in ci { if v.bad { return hmm_posterior_error("numerical precision limit"); } }
    for v in ce { if v.bad { return hmm_posterior_error("numerical precision limit"); } }
    for v in ca { if v.bad { return hmm_posterior_error("numerical precision limit"); } }
    for v in cb { if v.bad { return hmm_posterior_error("numerical precision limit"); } }
    for v in a { if v.bad { return hmm_posterior_error("numerical precision limit"); } }
    for v in b { if v.bad { return hmm_posterior_error("numerical precision limit"); } }
    if z.bad { return hmm_posterior_error("numerical precision limit"); }
    /* Normalize centered row scores rather than rounded absolute outputs.
     * Maximum-subtracted softmax preserves representable common offsets. */
    var posterior: f64[>..] = [];
    if !is_inf(z.hi) { for row in t {
        var weights: HMMLog[>..] = [];
        var peak = HMMLog { neg, 0.0, false };
        for s in n {
            // Subtract the common offset before combining alpha and beta.
            let shifted = hmm_log_sum(a[row*n+s],HMMLog { -z.hi, -z.lo, z.bad });
            let w = hmm_log_sum(shifted,b[row*n+s]);
            if w.bad { return hmm_posterior_error("numerical precision limit in posterior"); }
            weights.push(w);
            if w.hi > peak.hi || (w.hi == peak.hi && w.lo > peak.lo) { peak = w; }
        }
        var total = 0.0;
        for w in weights {
            let delta = hmm_log_sum(w,HMMLog { -peak.hi, -peak.lo, peak.bad });
            if delta.bad { return hmm_posterior_error("numerical precision limit in posterior"); }
            total += exp(delta.hi+delta.lo);
        }
        for w in weights {
            let delta = hmm_log_sum(w,HMMLog { -peak.hi, -peak.lo, peak.bad });
            if delta.bad || is_nan(total) || is_inf(total) || total <= 0.0 {
                return hmm_posterior_error("numerical precision limit in posterior");
            }
            posterior.push(exp(delta.hi+delta.lo)/total);
        }
    } }
    var alpha: f64[>..] = []; var beta: f64[>..] = [];
    for row in t { for state in n {
        let av = a[row*n+state]; let bv = b[row*n+state];
        let absolute_a = hmm_log_sum(av,ao[row]);
        let absolute_b = hmm_log_sum(bv,bo[t-1-row]);
        if (!is_inf(av.hi) && (is_inf(absolute_a.hi) || is_nan(absolute_a.hi))) ||
            (!is_inf(bv.hi) && (is_inf(absolute_b.hi) || is_nan(absolute_b.hi))) {
            return hmm_posterior_error("numerical overflow in absolute grid");
        }
        alpha.push(absolute_a.hi+absolute_a.lo);
        beta.push(absolute_b.hi+absolute_b.lo);
    } }
    let absolute_z = hmm_log_sum(hmm_log_sum(z,ao[t-1]),bo[0]);
    if !is_inf(z.hi) && (is_inf(absolute_z.hi) || is_nan(absolute_z.hi)) {
        return hmm_posterior_error("numerical overflow in absolute likelihood");
    }
    return HMMPosterior { copy(alpha), copy(beta), copy(posterior),
        absolute_z.hi+absolute_z.lo, !is_inf(z.hi), "" };
}
