import bio from "..";
import bio.stats.bayesian;
import bio.stats.fdr;
import math;
fn main() {
    let ids:        i64[3] = [10, 20, 30];
    let priors:     f64[3] = [log(0.2), log(0.3), log(0.5)];
    let likelihood: f64[3] = [log(0.8), log(0.1), log(0.4)];
    let result = bio::finite_bayes(ids, priors, likelihood);
    assert(result.defined && result.error.len == 0);
    print(result.map_id);
    // PEPs describe separate tests, not this hypothesis universe.
    let peps: f64[3] = [log(0.01), log(0.1), log(0.1)];
    let fdr = bio::expected_fdr(peps, 0.08);
    assert(fdr.error.len == 0 && fdr.selected.len == 3);
    print(fdr.selected.len);
}
