namespace bio;
import math;
import .probability;

struct ViterbiResult { states: i64[], log_probability: f64 }

// Log weights must be finite nonpositive values or negative infinity.
// Rows need not sum to one: callers own normalization.
fn validate_log_weights(values: const f64[:]) {
    for v in values { assert(!is_nan(v) && v <= 0.0); }
}

// Same matrices as hmm_forward_log; no terminal transition.
// Empty input scores zero. Impossible input returns an empty path.
// Equal scores choose the lowest predecessor and final state.
fn hmm_viterbi_log(observations: const i64[:], initial: const f64[:],
    transition: const f64[:], emission: const f64[:], alphabet: i64) -> ViterbiResult {
    let n = initial.len;
    assert(n > 0 && alphabet > 0);
    assert(transition.len == n * n && emission.len == n * alphabet);
    validate_log_weights(initial); validate_log_weights(transition);
    validate_log_weights(emission);
    let neg = log(0.0);
    var path: i64[>..] = [];
    if observations.len == 0 { return ViterbiResult { copy(path), 0.0 }; }
    for s in observations { assert(s >= 0 && s < alphabet); }
    var scores: f64[>..] = []; var prev: i64[>..] = [];
    for t in observations.len { for s in n { scores.push(neg); prev.push(0); } }
    for s in n { scores[s] = initial[s] + emission[s * alphabet + observations[0]]; }
    for t in 1..observations.len { for s in n {
        var best = neg; var source: i64 = 0;
        for p in n {
            let v = scores[(t - 1) * n + p] + transition[p * n + s];
            if v > best { best = v; source = p; }
        }
        scores[t * n + s] = best + emission[s * alphabet + observations[t]];
        prev[t * n + s] = source;
    } }
    var best = neg; var state: i64 = 0;
    for s in n { if scores[(observations.len - 1) * n + s] > best {
        best = scores[(observations.len - 1) * n + s]; state = s;
    } }
    if is_inf(best) { return ViterbiResult { copy(path), neg }; }
    for t in observations.len { path.push(0); }
    var t = observations.len;
    while t > 0 { t -= 1; path[t] = state; state = prev[t * n + state]; }
    return ViterbiResult { copy(path), best };
}

// States M=0 consumes x,y; X=1 consumes x; Y=2 consumes y.
// initial enters the first emitting state without a transition.
// transition[from*3+to]; terminal[state] exits after all symbols.
// match[x*alphabet+y], insert_x[x], insert_y[y] are log emissions.
// All nine transitions are supported. Empty/empty scores zero.
// Global alignment only; O(x.len*y.len) memory and time.
fn pairhmm_forward_log(x: const i64[:], y: const i64[:],
    initial: const f64[:], transition: const f64[:], terminal: const f64[:],
    paired:  const f64[:], insert_x: const f64[:], insert_y: const f64[:],
    alphabet: i64) -> f64 {
    assert(alphabet > 0 && initial.len == 3 && terminal.len == 3);
    assert(transition.len == 9 && paired.len == alphabet * alphabet);
    assert(insert_x.len == alphabet && insert_y.len == alphabet);
    validate_log_weights(initial); validate_log_weights(transition);
    validate_log_weights(terminal); validate_log_weights(paired);
    validate_log_weights(insert_x); validate_log_weights(insert_y);
    for s in x { assert(s >= 0 && s < alphabet); }
    for s in y { assert(s >= 0 && s < alphabet); }
    if x.len == 0 && y.len == 0 { return 0.0; }
    let neg = log(0.0); let width = y.len + 1;
    var dp: f64[>..] = [];
    for i in (x.len + 1) * width * 3 { dp.push(neg); }
    for i in 0..(x.len + 1) { for j in 0..width { for s in 3 {
        let dx = if s == 2 { 0 } else { 1 };
        let dy = if s == 1 { 0 } else { 1 };
        if i < dx || j < dy { continue; }
        let pi = i - dx; let pj = j - dy;
        var total = if pi == 0 && pj == 0 { initial[s] } else { neg };
        for p in 3 {
            total = log_add_probability(total, dp[(pi * width + pj) * 3 + p] + transition[p * 3 + s]);
        }
        let e = if s == 0 { paired[x[i - 1] * alphabet + y[j - 1]] }
            else if s == 1 { insert_x[x[i - 1]] } else { insert_y[y[j - 1]] };
        dp[(i * width + j) * 3 + s] = total + e;
    } } }
    var result = neg;
    for s in 3 { result = log_add_probability(result, dp[(x.len * width + y.len) * 3 + s] + terminal[s]); }
    return result;
}
