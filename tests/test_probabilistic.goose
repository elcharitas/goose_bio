import std;
import bio from "..";
import bio.stats.probabilistic;
import math;

// Enumerate emitted-state paths without using the DP recurrence.
recursive fn enumerate_pair(x: const i64[:], y: const i64[:], i: i64, j: i64,
    previous: i64, weight: f64, init: const f64[:], tr: const f64[:],
    end: const f64[:], pair: const f64[:], ins: const f64[:]) -> f64 {
    if i == x.len && j == y.len { return weight * end[previous]; }
    var total = 0.0;
    for s in 3 {
        let dx = if s == 2 { 0 } else { 1 };
        let dy = if s == 1 { 0 } else { 1 };
        if i + dx > x.len || j + dy > y.len { continue; }
        let t = if previous < 0 { init[s] } else { tr[previous * 3 + s] };
        let e = if s == 0 { pair[x[i] * 2 + y[j]] }
            else if s == 1 { ins[x[i]] } else { ins[y[j]] };
        total += enumerate_pair(x, y, i + dx, j + dy, s, weight * t * e, init, tr, end, pair, ins);
    }
    return total;
}
fn main() {
    let init: f64[2] = [log(0.6), log(0.4)];
    let tr:   f64[4] = [log(0.7), log(0.3), log(0.4), log(0.6)];
    let em:   f64[4] = [log(0.5), log(0.5), log(0.1), log(0.9)];
    for length in 1..6 { for bits in (1 << length) {
        var obs: i64[>..] = [];
        for k in length { obs.push((bits >> k) % 2); }
        var best = -1.0;
        for states in (1 << length) {
            var probability = exp(init[states % 2] + em[(states % 2) * 2 + obs[0]]);
            for k in 1..length {
                let a = (states >> (k - 1)) % 2; let b = (states >> k) % 2;
                probability *= exp(tr[a * 2 + b] + em[b * 2 + obs[k]]);
            }
            if probability > best { best = probability; }
        }
        let got = bio::hmm_viterbi_log(obs, init, tr, em, 2);
        assert(got.states.len == length && abs(exp(got.log_probability) - best) < 1e-12);
        var score = init[got.states[0]] + em[got.states[0] * 2 + obs[0]];
        for k in 1..length { score += tr[got.states[k - 1] * 2 + got.states[k]] + em[got.states[k] * 2 + obs[k]]; }
        assert(abs(score - got.log_probability) < 1e-12);
    } }
    let empty: i64[0] = [];
    assert(bio::hmm_viterbi_log(empty, init, tr, em, 2).log_probability == 0.0);
    let impossible: f64[4] = [log(0.0), log(0.0), log(0.0), log(0.0)];
    let obs:        i64[1] = [0];
    let no = bio::hmm_viterbi_log(obs, init, tr, impossible, 2);
    assert(no.states.len == 0 && is_inf(no.log_probability));
    let equal_init:    f64[2] = [0.0, 0.0];
    let equal_weights: f64[4] = [0.0, 0.0, 0.0, 0.0];
    let tie_obs:       i64[3] = [0, 1, 0];
    let tie = bio::hmm_viterbi_log(tie_obs, equal_init, equal_weights, equal_weights, 2);
    for state in tie.states { assert(state == 0); }
    let pi:   f64[3] = [0.5, 0.3, 0.2];
    let pt:   f64[9] = [0.4, 0.2, 0.1, 0.3, 0.4, 0.1, 0.2, 0.2, 0.5];
    let pe:   f64[3] = [0.3, 0.2, 0.1];
    let pair: f64[4] = [0.4, 0.1, 0.2, 0.3]; let ins: f64[2] = [0.6, 0.4];
    var li: f64[>..] = []; var lt: f64[>..] = []; var le: f64[>..] = [];
    var lp: f64[>..] = []; var ls: f64[>..] = [];
    for v in pi { li.push(log(v)); } for v in pt { lt.push(log(v)); }
    for v in pe { le.push(log(v)); } for v in pair { lp.push(log(v)); }
    for v in ins { ls.push(log(v)); }
    for nx in 4 { for ny in 4 { for xb in (1 << nx) { for yb in (1 << ny) {
        var x: i64[>..] = []; var y: i64[>..] = [];
        for k in nx { x.push((xb >> k) % 2); } for k in ny { y.push((yb >> k) % 2); }
        let expected = if nx + ny == 0 { 1.0 } else { enumerate_pair(x, y, 0, 0, -1, 1.0, pi, pt, pe, pair, ins) };
        let got = bio::pairhmm_forward_log(x, y, li, lt, le, lp, ls, ls, 2);
        assert(abs(exp(got) - expected) < 1e-12);
    } } } }
    let neg = log(0.0);
    let only_match: f64[3] = [0.0, neg, neg];
    let zero_tr:    f64[9] = [neg, neg, neg, neg, neg, neg, neg, neg, neg];
    let final:      f64[3] = [0.0, 0.0, 0.0];
    let tiny:       f64[4] = [-1000.0, -1000.0, -1000.0, -1000.0];
    assert(bio::pairhmm_forward_log(obs, obs, only_match, zero_tr, final, tiny, ls, ls, 2) == -1000.0);
    assert(is_inf(bio::pairhmm_forward_log(obs, empty, only_match, zero_tr, final, tiny, ls, ls, 2)));
    print("probabilistic assertions passed: 62 HMM, 225 PairHMM cases");
}
