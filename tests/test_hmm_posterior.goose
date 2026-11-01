// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.stats.hmm_posterior;
import math;
fn main() {
    let obs: i64[1] = [0]; let empty: i64[0] = [];
    let one: f64[1] = [0.0]; let none: f64[0] = [];
    let bad: f64[1] = [1.0]; let inf: f64[1] = [-log(0.0)];
    let nan: f64[1] = [log(-1.0)]; let neg: f64[1] = [log(0.0)];
    assert(bio::hmm_posterior_log(obs, one, one, one, 1, none).posterior[0] == 1.0);
    assert(bio::hmm_posterior_log(empty, one, one, one, 1, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, none, one, one, 1, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, one, none, one, 1, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, one, one, one, 0, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, one, one, one, 4097, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, bad, one, one, 1, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, one, inf, one, 1, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, one, one, nan, 1, none).error.len > 0);
    assert(bio::hmm_posterior_log(obs, one, one, one, 1, bad).error.len > 0);
    let symbols: i64[2] = [-1, 1];
    for symbol in symbols {
        let o: i64[1] = [symbol];
        assert(bio::hmm_posterior_log(o, one, one, one, 1, none).error.len > 0);
    }
    let no = bio::hmm_posterior_log(obs, one, one, neg, 1, none);
    assert(!no.defined && no.posterior.len == 0 && no.log_z == log(0.0));
    var states: f64[>..] = []; for s in 65 { states.push(0.0); }
    assert(bio::hmm_posterior_log(obs, states, one, one, 1, none).error.len > 0);
    var long: i64[>..] = []; for k in 1000001 { long.push(0); }
    assert(bio::hmm_posterior_log(long, one, one, one, 1, none).error.len > 0);
    var init: f64[>..] = []; for s in 64 { init.push(0.0); }
    assert(bio::hmm_posterior_log(long[0..6105], init, one, one, 1, none).error.len > 0);
    let huge: f64[1] = [-1e308];
    let overflow = bio::hmm_posterior_log(obs, huge, one, huge, 1, none);
    assert(overflow.error.len > 0 && !overflow.defined);
    assert(overflow.error[0] == 'n');
    let terminal_overflow = bio::hmm_posterior_log(obs, huge, one, one, 1, huge);
    assert(terminal_overflow.error.len > 0 && !terminal_overflow.defined);
    let two: i64[2] = [0, 0];
    let beta_overflow = bio::hmm_posterior_log(two, one, huge, one, 1, huge);
    assert(beta_overflow.error.len > 0 && !beta_overflow.defined);
    let impossible = bio::hmm_posterior_log(obs, neg, one, huge, 1, none);
    assert(impossible.error.len == 0 && !impossible.defined);
    print("checked posterior failures and bounds passed");
}
