// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import math;
import .hmm_posterior;

fn hmm_text_copy(v: const u8[:]) -> u8[] {
    var out: u8[>..] = []; for x in v { out.push(x); } return copy(out);
}
fn hmm_values_copy(v: const f64[:]) -> f64[] {
    var out: f64[>..] = []; for x in v { out.push(x); } return copy(out);
}

/* Linear expected counts cover initial occupancy, transitions, symbols, and final occupancy.
 * Singleton sequences have no transitions; absent symbols retain zero columns. Zero occupancy rows are
 * valid counts; unvisited cells contain 0.0. Errors contain no partial estimates. */
struct HMMCounts {
    initial: f64[], transition: f64[], emission: f64[], end: f64[],
    log_z: f64, error: u8[]
}
fn hmm_counts_error(message: const u8[:]) -> HMMCounts {
    return HMMCounts { [], [], [], [], log(0.0), hmm_text_copy(message) };
}

/* Input probability rows must normalize within 1e-12.
 * Inputs use log weights: negative infinity represents zero probability. */
fn hmm_normalized(values: const f64[:]) -> bool {
    var total = 0.0;
    for v in values {
        if is_nan(v) || v > 0.0 { return false; }
        total += exp(v);
    }
    return abs(total-1.0) <= 1e-12;
}

/* Accepts log probabilities with a fixed alphabet and fixed terminal factors in [0,1]. Terminal
 * factors do not compete with transitions; likelihood includes the final factor at the supplied
 * sequence length. Limits are 32 states, 256 symbols, one million state-time entries, and 50 million
 * conservative transition evaluations. Posterior and independent backward grids are buffered. */
fn hmm_expected_counts(obs: const i64[:], initial: const f64[:],
    transition: const f64[:], emission: const f64[:], alphabet: i64,
    terminal: const f64[:]) -> HMMCounts {
    let n = initial.len; let t = obs.len;
    if n < 1 || n > 32 || alphabet < 1 || alphabet > 256 || t < 1 {
        return hmm_counts_error("invalid dimensions or empty observations");
    }
    if t > 1000000/n || t-1 > 50000000/(4*n*n) {
        return hmm_counts_error("estimation work limit exceeded");
    }
    if transition.len != n*n || emission.len != n*alphabet || terminal.len != n {
        return hmm_counts_error("matrix dimensions do not match");
    }
    if !hmm_normalized(initial) { return hmm_counts_error("initial is not normalized"); }
    for s in n {
        if !hmm_normalized(transition[s*n..(s+1)*n]) ||
            !hmm_normalized(emission[s*alphabet..(s+1)*alphabet]) {
            return hmm_counts_error("row is not normalized");
        }
    }
    /* Checked posterior numerical refusals remain errors. Conditional transitions use two-component log
     * arithmetic without subtracting absolute alpha grids. Extreme numerical cases can fail. Underflowed
     * posterior mass becomes binary64 zero; there are no arbitrary pseudocounts or replacement rows. */
    let p = hmm_posterior_log(obs,initial,transition,emission,alphabet,terminal);
    if p.error.len > 0 { return hmm_counts_error(p.error); }
    if !p.defined { return hmm_counts_error("impossible observations"); }
    var pi: f64[>..] = []; var a: f64[>..] = [];
    var e: f64[>..] = []; var end: f64[>..] = [];
    for s in n { pi.push(p.posterior[s]); end.push(p.posterior[(t-1)*n+s]); }
    for k in n*n { a.push(0.0); }
    for k in n*alphabet { e.push(0.0); }
    for k in t { for s in n { e[s*alphabet+obs[k]] += p.posterior[k*n+s]; } }
    // Independent conditional arcs avoid subtracting absolute alpha grids.
    var beta: HMMLog[>..] = [];
    for k in t*n { beta.push(HMMLog { log(0.0), 0.0, false }); }
    for s in n { beta[(t-1)*n+s] = HMMLog { terminal[s], 0.0, false }; }
    var k = t-1;
    while k > 0 {
        k -= 1;
        for s in n {
            var terms: HMMLog[>..] = [];
            var total = HMMLog { log(0.0), 0.0, false };
            for d in n {
                let w = hmm_log_weight(hmm_log_weight(beta[(k+1)*n+d],
                    transition[s*n+d]),emission[d*alphabet+obs[k+1]]);
                if w.bad { return hmm_counts_error("numerical precision limit in arcs"); }
                terms.push(w); total = hmm_log_merge(total,w);
            }
            if total.bad { return hmm_counts_error("numerical precision limit in arcs"); }
            beta[k*n+s] = total;
            if p.posterior[k*n+s] > 0.0 {
                if is_inf(total.hi) { return hmm_counts_error("unrepresentable conditional arcs"); }
                var sum = 0.0;
                for d in n {
                    let delta = hmm_log_sum(terms[d],HMMLog { -total.hi, -total.lo, false });
                    if delta.bad { return hmm_counts_error("numerical precision limit in arcs"); }
                    let v = exp(delta.hi+delta.lo);
                    sum += v; a[s*n+d] += p.posterior[k*n+s]*v;
                }
                if abs(sum-1.0) > 1e-10 { return hmm_counts_error("conditional arc normalization failed"); }
            }
        }
    }
    return HMMCounts { copy(pi), copy(a), copy(e), copy(end), p.log_z, "" };
}

/* History contains the input corpus likelihood and each applied update likelihood. updates counts
 * applied updates. converged requires a nonnegative gain <= tolerance*(1+abs(previous likelihood));
 * hitting the iteration limit leaves it false. */
struct HMMTraining {
    initial: f64[], transition: f64[], emission: f64[], terminal: f64[],
    likelihood: f64[], updates: i64, converged: bool, error: u8[]
}

/* Any likelihood decline, including negative roundoff, returns an atomic error. This can reject a
 * stationary solution; a decline never counts as convergence. Zero transition or emission denominators
 * also reject training. */
fn hmm_training_error(message: const u8[:]) -> HMMTraining {
    return HMMTraining { [], [], [], [], [], 0, false, hmm_text_copy(message) };
}
// Offsets delimit nonempty sequences in one flat corpus.

/* Flat observations use strictly increasing offsets, including zero and final length. Each update
 * aggregates one frozen model, normalizes initial/transition/emission counts, and keeps terminal
 * weights fixed. Tolerance is finite and positive; iterations are 1..10000. Preflight caps all passes,
 * including candidate evaluation, at 100 million transition evaluations and bounds corpus state-time
 * size. */
fn hmm_train_batch(obs: const i64[:], offsets: const i64[:],
    initial: const f64[:], transition: const f64[:], emission: const f64[:],
    alphabet: i64, terminal: const f64[:], iterations: i64,
    tolerance: f64) -> HMMTraining {
    /* Training maximizes expected complete path log weight for a fixed-length weighted model. It
     * does not estimate length distributions, exit hazards, or end states. Training uses fixed-
     * alphabet frozen batches. */
    let n = initial.len;
    if n < 1 || n > 32 || alphabet < 1 || alphabet > 256 ||
        iterations < 1 || iterations > 10000 || is_nan(tolerance) ||
        is_inf(tolerance) || tolerance <= 0.0 || offsets.len < 2 {
        return hmm_training_error("invalid training options");
    }
    if offsets[0] != 0 || offsets[offsets.len-1] != obs.len {
        return hmm_training_error("invalid corpus offsets");
    }
    for k in 1..offsets.len {
        if offsets[k] <= offsets[k-1] || offsets[k] > obs.len {
            return hmm_training_error("empty sequence or invalid offsets");
        }
    }
    // Preflight bounds all passes, including candidate evaluations.
    if obs.len > 1000000/n || obs.len > 100000000/(4*n*n)/(iterations+1) {
        return hmm_training_error("total training work limit exceeded");
    }
    var pi = hmm_values_copy(initial); var a = hmm_values_copy(transition); var e = hmm_values_copy(emission);
    var history: f64[>..] = [];
    var updates: i64 = 0;
    for pass in iterations+1 {
        var cp: f64[>..] = []; var ca: f64[>..] = []; var ce: f64[>..] = [];
        for s in n { cp.push(0.0); }
        for s in n*n { ca.push(0.0); }
        for s in n*alphabet { ce.push(0.0); }
        var ll = 0.0;
        for k in 1..offsets.len {
            let c = hmm_expected_counts(obs[offsets[k-1]..offsets[k]],pi,a,e,alphabet,terminal);
            if c.error.len > 0 { return hmm_training_error(c.error); }
            ll += c.log_z;
            for s in n { cp[s] += c.initial[s]; }
            for s in n*n { ca[s] += c.transition[s]; }
            for s in n*alphabet { ce[s] += c.emission[s]; }
        }
        if is_nan(ll) || is_inf(ll) { return hmm_training_error("nonfinite corpus likelihood"); }
        history.push(ll);
        if pass > 0 {
            let old = history[pass-1]; let gain = ll-old;
            // Negative roundoff is never reported as convergence.
            if gain < 0.0 { return hmm_training_error("corpus likelihood decreased"); }
            if gain <= tolerance*(1.0+abs(old)) {
                return HMMTraining { pi, a, e, hmm_values_copy(terminal), copy(history), updates, true, "" };
            }
        }
        if pass == iterations { break; }
        for s in n {
            var at = 0.0; var et = 0.0;
            for d in n { at += ca[s*n+d]; }
            for d in alphabet { et += ce[s*alphabet+d]; }
            if at <= 0.0 || et <= 0.0 {
                return hmm_training_error("unidentifiable transition or emission row");
            }
            pi[s] = log(cp[s]/(offsets.len-1));
            for d in n { a[s*n+d] = log(ca[s*n+d]/at); }
            for d in alphabet { e[s*alphabet+d] = log(ce[s*alphabet+d]/et); }
        }
        updates += 1;
    }
    return HMMTraining { pi, a, e, hmm_values_copy(terminal), copy(history), updates, false, "" };
}
