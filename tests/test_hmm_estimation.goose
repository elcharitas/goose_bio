// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.stats.hmm_estimation;
import math;
fn main() {
    let o:   i64[4] = [0, 1, 1, 0]; let offsets: i64[3] = [0, 2, 4];
    let pi:  f64[2] = [log(0.6), log(0.4)];
    let a:   f64[4] = [log(0.7), log(0.3), log(0.4), log(0.6)];
    let e:   f64[6] = [log(0.5), log(0.4), log(0.1), log(0.1), log(0.8), log(0.1)];
    let end: f64[2] = [log(0.8), log(0.3)];
    let c = bio::hmm_expected_counts(o, pi, a, e, 3, end);
    assert(c.error.len == 0 && c.emission[2] == 0.0 && c.emission[5] == 0.0);
    var sum = 0.0; for v in c.transition { sum += v; } assert(abs(sum - 3.0) < 1e-10);
    let fit = bio::hmm_train_batch(o, offsets, pi, a, e, 3, end, 3, 1e-12);
    assert(fit.error.len == 0 && fit.updates > 0 && fit.likelihood.len == fit.updates + 1);
    for k in 1..fit.likelihood.len { assert(fit.likelihood[k] >= fit.likelihood[k - 1]); }
    let singleton: i64[2] = [0, 1];
    let bad = bio::hmm_train_batch(singleton, offsets, pi, a, e, 3, end, 1, 1e-6);
    assert(bad.error.len > 0 && bad.initial.len == 0 && bad.updates == 0);
    assert(bio::hmm_train_batch(o, offsets, pi, a, e, 3, end, 0, 1e-6).error.len > 0);
    let singles: i64[3] = [0, 1, 2];
    let unident = bio::hmm_train_batch(singleton, singles, pi, a, e, 3, end, 1, 1e-6);
    assert(unident.error.len > 0 && unident.likelihood.len == 0);
    let z: f64[2] = [log(0.0), log(0.0)];
    let no = bio::hmm_expected_counts(o, pi, a, e, 3, z);
    assert(no.error.len > 0 && no.end.len == 0);
    let badpi: f64[2] = [0.0, 0.0];
    assert(bio::hmm_expected_counts(o, badpi, a, e, 3, end).error.len > 0);
    let empty: i64[0] = [];
    assert(bio::hmm_expected_counts(empty, pi, a, e, 3, end).error.len > 0);
    assert(bio::hmm_train_batch(o, offsets, pi, a, e, 3, end, 1, log(-1.0)).error.len > 0);
    var long: i64[>..] = []; for k in 1000001 { long.push(0); }
    assert(bio::hmm_expected_counts(long, pi, a, e, 3, end).error.len > 0);
    let huge: f64[2] = [-1e308, -1e308];
    assert(bio::hmm_expected_counts(o, pi, a, e, 3, huge).error.len > 0);
    print("checked counts and batch training passed");
}
