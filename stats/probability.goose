namespace bio;
import math;

fn log_probability(p: f64) -> f64 {
    assert(p >= 0.0 && p <= 1.0);
    return log(p);
}
fn phred_error_probability(q: f64) -> f64 {
    assert(q >= 0.0);
    return pow(10.0, -q / 10.0);
}
fn probability_to_phred(p: f64) -> f64 {
    assert(p >= 0.0 && p <= 1.0);
    return -10.0 * log10(p);
}
fn log_add_probability(a: f64, b: f64) -> f64 {
    if is_inf(a) && a < 0.0 { return b; }
    if is_inf(b) && b < 0.0 { return a; }
    if is_inf(a) && a > 0.0 { return a; }
    if is_inf(b) && b > 0.0 { return b; }
    let hi = if a > b { a } else { b };
    let lo = if a > b { b } else { a };
    let small = exp(lo - hi);
    let rounded = 1.0 + small;
    let correction = if rounded == 1.0 { small }
        else { log(rounded) * small / (rounded - 1.0) };
    return hi + correction;
}

// Row-major log matrices: transition[from * states + to],
// emission[state * alphabet + symbol]. Empty observations have log P = 0.
fn hmm_forward_log(observations: const i64[:], initial: const f64[:],
    transition: const f64[:], emission: const f64[:], alphabet: i64) -> f64 {
    let n = initial.len;
    assert(n > 0 && alphabet > 0);
    assert(transition.len == n * n && emission.len == n * alphabet);
    if observations.len == 0 { return 0.0; }
    for symbol in observations { assert(symbol >= 0 && symbol < alphabet); }
    let neg = log(0.0);
    var row: f64[>..] = [];
    var next: f64[>..] = [];
    for s in n {
        row.push(initial[s] + emission[s * alphabet + observations[0]]);
        next.push(neg);
    }
    for t in 1..observations.len {
        for s in n {
            var total = neg;
            for p in n { total = log_add_probability(total, row[p] + transition[p * n + s]); }
            next[s] = total + emission[s * alphabet + observations[t]];
        }
        for s in n { row[s] = next[s]; }
    }
    var result = neg;
    for value in row { result = log_add_probability(result, value); }
    return result;
}
