// Copyright (c) 2026 Jonathan Irhodia. MIT License.

/* Frameshift alignment has no evolutionary analysis, codon substitution model, codon alignment
 * object, . */
namespace bio;
import sequence.genetic_codes;

/* Uses existing NCBI codes; stops are *, and dual assignments use the forward amino acid. The wildcard
 * is a literal byte scoring zero on either side, without ambiguity expansion. Scores must be finite. */
struct FrameshiftOptions {
    code:      i64, match_score: f64, mismatch_score: f64, wildcard: u8,
    minus_two: f64, minus_one: f64, plus_one: f64, plus_two: f64,
}

/* Equal-sized boundary arrays describe the path. Positive protein advance consumes three bases per
 * residue; zero advance is a scored nucleotide jump. Negative jumps must remain for replay.
 * nt_start/nt_end alone cannot describe the path. Score zero alone does not imply success: short
 * nucleotide inputs can lack a complete alignment without being invalid. */
struct FrameshiftAlignment {
    score:               f64, nt_start: i64, nt_end: i64,
    protein_coordinates: i64[], nucleotide_coordinates: i64[],
    /* Padded grids cap at 4,000,000 cells before allocation. Time and memory are O(protein
     * length*nucleotide length), with five predecessors per cell; peak storage includes scores, trace,
     * digits, and coordinates. Finite arithmetic overflow rejects; allocation failure is not recovered.
     * Exact ties prefer advance 1..5 then earliest final boundary; only one path returns, without
     * epsilon-tie enumeration. */
    complete: bool, error: u8[],
}

/* Defaults: code 1, match 1, mismatch 0, wildcard X, and all four signed shift scores -3.
 */
fn frameshift_defaults() -> FrameshiftOptions {
    return FrameshiftOptions { 1, 1.0, 0.0, 'X', -3.0, -3.0, -3.0, -3.0 };
}

/* Requires uppercase protein and concrete DNA/RNA, allowing mixed T/U. Lowercase, ambiguity,
 * whitespace, and gaps reject. Each residue consumes a full codon; successive ends advance 1..5 bases
 * with -2/-1/none/+1/+2 penalties. First residue has no shift penalty or free-flank reward; both
 * nucleotide flanks are free. All protein residues must be consumed. Empty protein succeeds at
 * boundary zero with zero score. No amino acid insertions/deletions or affine gaps. */
fn frameshift_alignment(protein: const u8[:], nt: const u8[:],
    o: FrameshiftOptions = frameshift_defaults()) -> FrameshiftAlignment {
    let bad = FrameshiftAlignment { 0.0, 0, 0, [], [], false, "invalid input or allocation limit" };
    if protein.len > 3999999 || nt.len > 3999999 { return bad; }
    let w = nt.len + 1;
    if protein.len + 1 > 4000000 / w { return bad; }
    let code = genetic_code(o.code);
    if code.id == 0 { return bad; }
    let values: f64[] = [o.match_score, o.mismatch_score, o.minus_two, o.minus_one, o.plus_one, o.plus_two];
    for v in values { if !(v - v == 0.0) { return bad; } }
    for c in protein {
        var ok = c == o.wildcard;
        for a in "ACDEFGHIKLMNPQRSTVWYBXZJUO*" { if a == c { ok = true; } }
        if !ok { return bad; }
    }
    var digits: i64[>..] = [];
    for c in nt {
        let d: i64 = match c { 'T', 'U' => 0, 'C' => 1, 'A' => 2, 'G' => 3, _ => -1 };
        if d < 0 { return bad; } digits.push(d);
    }
    if protein.len == 0 { return FrameshiftAlignment { 0.0, 0, 0, [0], [0], true, "" }; }
    let cells = (protein.len + 1) * w;
    var scores: f64[>..] = []; var trace: i64[>..] = [];
    for k in cells { scores.push(0.0); trace.push(-1); }
    for j in w { trace[j] = 0; }
    for i in 1..protein.len + 1 { for j in 3..w {
        let aa = code.amino[digits[j - 3] * 16 + digits[j - 2] * 4 + digits[j - 1]];
        let delta = if protein[i - 1] == o.wildcard || aa == o.wildcard { 0.0 }
            else if protein[i - 1] == aa { o.match_score } else { o.mismatch_score };
        for step in 1..6 {
            if step > j { continue; }
            let p = (i - 1) * w + j - step;
            if trace[p] < 0 { continue; }
            // The first residue starts with a complete unshifted codon.
            if i == 1 && step != 3 { continue; }
            let penalty = if step == 1 { o.minus_two } else if step == 2 { o.minus_one }
                else if step == 4 { o.plus_one } else if step == 5 { o.plus_two } else { 0.0 };
            let v = scores[p] + delta + penalty;
            if !(v - v == 0.0) { return bad; }
            let k = i * w + j;
            if trace[k] < 0 || v > scores[k] { scores[k] = v; trace[k] = step; }
        }
    } }
    var end: i64 = -1; var best = 0.0;
    for j in w {
        let k = protein.len * w + j;
        if trace[k] >= 0 && (end < 0 || scores[k] > best) { end = j; best = scores[k]; }
    }
    if end < 0 { return FrameshiftAlignment { 0.0, 0, 0, [], [], false, "no complete alignment" }; }
    var ends: i64[>..] = []; var j = end;
    for z in protein.len {
        let i = protein.len - z; ends.push(j); j -= trace[i * w + j];
    }
    let start = ends[ends.len - 1] - 3;
    var pc: i64[>..] = []; var nc: i64[>..] = [];
    pc.push(0); nc.push(start);
    var previous = start;
    for i in protein.len {
        let e = ends[ends.len - 1 - i]; let s = e - 3;
        if s != previous { pc.push(i); nc.push(previous); pc.push(i); nc.push(s); }
        previous = e;
    }
    pc.push(protein.len); nc.push(end);
    return FrameshiftAlignment { best, start, end, copy(pc), copy(nc), true, "" };
}
