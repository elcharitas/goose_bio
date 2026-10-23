// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import .bayesian;
import math;

/* Raw cumulative rank means can differ for equal PEPs. Selection uses the final mean of each equal-PEP
 * group; indices return in input order. Equality is exact binary64 log equality; rounding can change
 * threshold-boundary selection or turn tiny weight contrasts into MAP ties. */
struct PosteriorFDR { log_fdr: f64[], selected: i64[], error: u8[] }
// Input is log PEP. Raw stable rank means retain unequal tied values.

/* Accepts log PEPs and a probability threshold in [0,1]; empty input is valid, and more than
 * 1,000,000 PEPs rejects. Uses stable ascending PEP order, cumulative mean, and input-order
 * restoration, for posterior-error FDR. No hypothesis-posterior conversion is implicit. Sorting uses
 * O(n log n) time and O(n) space. */
fn expected_fdr(peps: const f64[:], threshold: f64) -> PosteriorFDR {
    if peps.len > 1000000 || is_nan(threshold) || threshold < 0.0 || threshold > 1.0 { return PosteriorFDR { [], [], "invalid bound or threshold" }; }
    for p in peps { if is_nan(p) || p > 0.0 { return PosteriorFDR { [], [], "invalid log PEP" }; } }
    let order = bayes_order(peps,true);
    var values: f64[>..] = []; for p in peps { values.push(0.0); }
    var total = log(0.0);
    for j in peps.len {
        let i = order[j]; total = bayes_logadd(total,peps[i]);
        let v = total-log((j+1) as f64);
        values[i] = if v > 0.0 { 0.0 } else { v };
    }
    var selected: i64[>..] = []; var start = 0;
    while start < peps.len {
        var end = start+1;
        while end < peps.len && peps[order[end]] == peps[order[start]] { end += 1; }
        if values[order[end-1]] <= log(threshold) {
            for j in start..end { selected.push(order[j]); }
        }
        start = end;
    }
    let selected_copy = bayes_sort_ids(selected); selected = copy(selected_copy);
    return PosteriorFDR { copy(values), copy(selected), "" };
}
