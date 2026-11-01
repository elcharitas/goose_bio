// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import math;

/* Posterior arrays retain input order; rank holds descending-weight input indexes. Equal computed
 * weights and MAP retain input order. MAP requires defined=true. Zero evidence yields negative
 * infinity, empty arrays, and defined=false without NaN. Check error before use. */
struct FiniteBayes {
    posterior: f64[], log_posterior: f64[], rank: i64[],
    map_id:    i64, log_evidence: f64, defined: bool, error: u8[],
}
fn bayes_error(s: const u8[:]) -> FiniteBayes {
    var text: u8[>..] = []; for c in s { text.push(c); }
    return FiniteBayes { [], [], [], 0, log(0.0), false, copy(text) };
}

/* Likelihoods lose their common maximum before adding priors. Posterior uses centered weights, not
 * rounded absolute evidence. Absolute evidence has binary64 limits; finite differences beyond range
 * can yield negative infinite log posterior. Underflowed probabilities retain finite log posteriors
 * when representable. */
fn bayes_logadd(a: f64, b: f64) -> f64 {
    if is_inf(a) { return b; }
    if is_inf(b) { return a; }
    let hi = if a > b { a } else { b };
    let lo = if a > b { b } else { a };
    return hi + log(1.0 + exp(lo - hi));
}
// Stable bottom-up merge orders keys, retaining input order on ties.
fn bayes_order(keys: const f64[:], ascending: bool) -> i64[] {
    var idx: i64[>..] = []; var tmp: i64[>..] = [];
    for i in keys.len { idx.push(i); tmp.push(0); }
    var width = 1;
    while width < keys.len {
        var start = 0;
        while start < keys.len {
            let mid = if start + width < keys.len { start + width } else { keys.len };
            let end = if mid + width < keys.len { mid + width } else { keys.len };
            var a = start; var b = mid;
            for k in start..end {
                if a < mid && (b >= end || (if ascending { keys[idx[a]] <= keys[idx[b]] } else { keys[idx[a]] >= keys[idx[b]] })) {
                    tmp[k] = idx[a]; a += 1;
                } else { tmp[k] = idx[b]; b += 1; }
            }
            start = end;
        }
        for i in keys.len { idx[i] = tmp[i]; }
        width *= 2;
    }
    return copy(idx);
}
// Priors must sum to one within absolute tolerance 1e-12.

/* Unique signed IDs align with log priors/likelihoods, which must be nonpositive or negative infinity.
 * NaN, positive infinity, missing arrays, duplicates, empty hypotheses, and >1,000,000 hypotheses
 * reject. A compensated sum requires prior probability within 1e-12 of one. Accepted prior weights
 * remain unchanged for evidence; posterior normalizes. IDs sort for duplicate checks; stable ranking
 * takes O(n log n) time and O(n) memory. */
fn finite_bayes(ids: const i64[:], prior: const f64[:], likelihood: const f64[:]) -> FiniteBayes {
    let n = ids.len;
    if n == 0 || n > 1000000 || prior.len != n || likelihood.len != n { return bayes_error("invalid or missing dimensions"); }
    // Sort integer IDs separately to avoid f64 identifier collisions.
    var sorted: i64[>..] = []; for id in ids { sorted.push(id); }
    let sorted_copy = bayes_sort_ids(sorted); sorted = copy(sorted_copy);
    for i in 1..n { if sorted[i] == sorted[i - 1] { return bayes_error("duplicate ID"); } }
    var ps = 0.0; var correction = 0.0; var offset = log(0.0);
    for i in n {
        if is_nan(prior[i]) || prior[i] > 0.0 || is_nan(likelihood[i]) || likelihood[i] > 0.0 { return bayes_error("invalid log probability"); }
        let term = exp(prior[i]) - correction;
        let next = ps + term; correction = (next - ps) - term; ps = next;
        if !is_inf(prior[i]) && likelihood[i] > offset { offset = likelihood[i]; }
    }
    if abs(ps - 1.0) > 1e-12 { return bayes_error("priors do not sum to one"); }
    if is_inf(offset) { return FiniteBayes { [], [], [], 0, offset, false, "" }; }
    var weights: f64[>..] = []; var z = log(0.0);
    for i in n {
        let w = prior[i] + (likelihood[i] - offset);
        weights.push(w); z = bayes_logadd(z, w);
    }
    var p: f64[>..] = []; var lp: f64[>..] = [];
    for w in weights { lp.push(w - z); p.push(exp(w - z)); }
    let order = bayes_order(weights, false);
    return FiniteBayes { copy(p), copy(lp), order, ids[order[0]], offset + z, true, "" };
}

/* Strength codes: 0 none (factor<=1), 1 barely (<=3), 2 positive (<=20), 3 strong (<=150), 4 very
 * strong. Classification uses the computed binary64 factor, including rounded boundaries. */
struct BayesEvidence { factor: f64, log_factor: f64, strength: i64, defined: bool, error: u8[] }
// Strength: 0 none, 1 barely, 2 positive, 3 strong, 4 very strong.

/* Takes unchanged log evidences of either sign without prior odds, including small positive evidence
 * from tolerated prior sums. Negative infinity means zero; NaN and positive infinity reject. Both
 * zero is undefined; one zero gives defined zero/infinity. Log factor survives factor
 * overflow/underflow. Finite exclusive hypotheses only: no continuous integration, marginal
 * exploration, CDFs, event aggregation, or model fitting. MIT notice remains in
 * tests/reference/bayesian/RUST_BIO_LICENSE.md. */
fn bayes_factor(a: f64, b: f64) -> BayesEvidence {
    if is_nan(a) || is_nan(b) || (is_inf(a) && a > 0.0) || (is_inf(b) && b > 0.0) { return BayesEvidence { 0.0, 0.0, 0, false, "invalid log evidence" }; }
    if is_inf(a) && is_inf(b) { return BayesEvidence { 0.0, 0.0, 0, false, "" }; }
    let lf = a - b; let f = exp(lf);
    let s = if f <= 1.0 { 0 } else { if f <= 3.0 { 1 } else { if f <= 20.0 { 2 } else { if f <= 150.0 { 3 } else { 4 } } } };
    return BayesEvidence { f, lf, s, true, "" };
}

fn bayes_sort_ids(input: const i64[:]) -> i64[>..] {
    var a: i64[>..] = []; var b: i64[>..] = [];
    for v in input { a.push(v); b.push(v); }
    var w = 1;
    while w < a.len {
        var lo = 0;
        while lo < a.len {
            let mid = if lo + w < a.len { lo + w } else { a.len };
            let hi = if mid + w < a.len { mid + w } else { a.len };
            var x = lo; var y = mid;
            for k in lo..hi {
                if x < mid && (y >= hi || a[x] <= a[y]) { b[k] = a[x]; x += 1; }
                else { b[k] = a[y]; y += 1; }
            }
            lo = hi;
        }
        for k in a.len { a[k] = b[k]; }
        w *= 2;
    }
    return a;
}
