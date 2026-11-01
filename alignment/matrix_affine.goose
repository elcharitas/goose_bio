namespace bio;
import std;

/* A free flag names the sequence containing the gap: a_left_free frees gaps before the first byte of
 * a. Four flags cover all 16 global end policies. local=true ignores all end flags and omits clipped
 * bytes. */
struct MatrixAffineOptions {
    open: f64, extend: f64, local: bool,
    /* Exact predecessor and global endpoint ties prefer paired bytes, gap in b, then gap in a. Local
     * endpoints use the first positive maximum by row, column, state; zero states terminate
     * traceback. No comparison tolerance changes ties, using exact computed scores. */
    a_left_free: bool, a_right_free: bool,
    b_left_free: bool, b_right_free: bool,
}

/* Penalizes all ends. Global traces consume all bytes, including free terminal gaps, with zero-based
 * half-open coordinates. */
fn matrix_affine_global(open: f64 = 5.0, extend: f64 = 1.0) -> MatrixAffineOptions {
    return MatrixAffineOptions { open, extend, false, false, false, false, false };
}

/* Frees all ends. Overlap may contain only opposite terminal gaps and no paired bytes.
 */
fn matrix_affine_overlap(open: f64 = 5.0, extend: f64 = 1.0) -> MatrixAffineOptions {
    return MatrixAffineOptions { open, extend, false, true, true, true, true };
}

/* Consumes all of b and frees flanking gaps in b. Other flag combinations can be supplied directly.
 */
fn matrix_affine_fit_b(open: f64 = 5.0, extend: f64 = 1.0) -> MatrixAffineOptions {
    return MatrixAffineOptions { open, extend, false, false, false, true, true };
}

/* Fractional scores are retained. Length-n gaps cost open+(n-1)*extend; costs are nonnegative and
 * <1e100, and extend may exceed open. Adjacent opposite gaps each open a new run. Global empty inputs
 * produce terminal gaps, free if either end of the empty sequence is free; two empties score zero. A
 * local result without a positive path has zero score, empty bytes, and four zero coordinates,
 * including empty inputs. */
fn matrix_affine(a: const u8[:], b: const u8[:], m: const SubstitutionMatrix&,
    o: MatrixAffineOptions) -> MatrixAlignment {
    /* Invalid inputs return error with zero/empty fields. Matrix alphabet must be nonempty, unique,
     * single-byte, and exclude hyphen; every input byte must occur in it and dimensions must match.
     * Scores are strictly between -1e100 and 1e100, excluding NaN/infinity. Inputs cap at 1,000,000
     * bytes each and 4,000,000 padded cells, keeping sums finite. Unreachable states use trace tags.
     * Three full score/trace grids take O(mn) time/memory; no POA, sparse, SIMD, token-alphabet, or
     * linear-space alignment. */
    let invalid = MatrixAlignment { 0.0, 0, 0, 0, 0, "", "", "invalid affine input or resource bound" };
    if m.error.len > 0 || m.alphabet.len == 0 || m.alphabet.len > 256
        || m.scores.len != m.alphabet.len * m.alphabet.len
        || !(o.open >= 0.0 && o.open < 1.0e100)
        || !(o.extend >= 0.0 && o.extend < 1.0e100)
        || a.len > 1000000 || b.len > 1000000 { return invalid; }
    for token, k in m.alphabet {
        if token.len != 1 || token[0] == '-' { return invalid; }
        for prior, t in m.alphabet { if t < k && prior == token { return invalid; } }
    }
    for v in m.scores { if !(v > -1.0e100 && v < 1.0e100) { return invalid; } }
    var ai: i64[>..] = []; var bj: i64[>..] = [];
    for c in a {
        var index: i64 = -1;
        for token, k in m.alphabet { if token[0] == c { index = k; } }
        if index < 0 { return invalid; } ai.push(index);
    }
    for c in b {
        var index: i64 = -1;
        for token, k in m.alphabet { if token[0] == c { index = k; } }
        if index < 0 { return invalid; } bj.push(index);
    }
    let w = b.len + 1; let cells = (a.len + 1) * w;
    if cells > 4000000 { return invalid; }
    var score: f64[>..] = []; var trace: i64[>..] = [];
    for k in cells * 3 { score.push(0.0); trace.push(-1); }
    trace[0] = 3;
    var best = 0.0; var ei: i64 = 0; var ej: i64 = 0; var es: i64 = 0;
    for i in 0..a.len + 1 { for j in 0..w {
        if i == 0 && j == 0 { continue; }
        let cell = (i * w + j) * 3;
        for state in 0..3 {
            if state == 0 && (i == 0 || j == 0) { continue; }
            if state == 1 && i == 0 { continue; }
            if state == 2 && j == 0 { continue; }
            let prev = if state == 0 { cell - (w + 1) * 3 } else if state == 1 { cell - w * 3 } else { cell - 3 };
            var value = 0.0; var from: i64 = -1;
            for s in 0..3 {
                if trace[prev + s] < 0 { continue; }
                var delta = 0.0;
                if state == 0 { delta = m.scores[ai[i - 1] * m.alphabet.len + bj[j - 1]]; }
                else {
                    let free = !o.local && (if state == 1 {
                        (j == 0 && o.b_left_free) || (j == b.len && o.b_right_free)
                    } else { (i == 0 && o.a_left_free) || (i == a.len && o.a_right_free) });
                    if !free { delta = if s == state { -o.extend } else { -o.open }; }
                }
                let candidate = score[prev + s] + delta;
                if from < 0 || candidate > value { value = candidate; from = s; }
            }
            if o.local && (from < 0 || value <= 0.0) { value = 0.0; from = 3; }
            score[cell + state] = value; trace[cell + state] = from;
            if o.local && value > best { best = value; ei = i; ej = j; es = state; }
        }
    } }
    if !o.local {
        ei = a.len; ej = b.len; es = 0;
        let end = (ei * w + ej) * 3;
        for s in 0..3 {
            if trace[end + s] >= 0 && (trace[end + es] < 0 || score[end + s] > score[end + es]) { es = s; }
        }
        best = score[end + es];
    }
    var i = ei; var j = ej; var state = es;
    var ar: u8[>..] = []; var br: u8[>..] = [];
    while i > 0 || j > 0 {
        let from = trace[(i * w + j) * 3 + state];
        if from == 3 { break; }
        if state == 0 { ar.push(a[i - 1]); br.push(b[j - 1]); i -= 1; j -= 1; }
        else if state == 1 { ar.push(a[i - 1]); br.push('-'); i -= 1; }
        else { ar.push('-'); br.push(b[j - 1]); j -= 1; }
        state = from;
    }
    var aa: u8[>..] = []; var bb: u8[>..] = [];
    for k in ar.len { aa.push(ar[ar.len - 1 - k]); bb.push(br[br.len - 1 - k]); }
    return MatrixAlignment { best, i, ei, j, ej, copy(aa), copy(bb), "" };
}
