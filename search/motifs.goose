namespace bio;
import math;

// Position-major matrices use A,C,G,T columns.
struct MotifMatrix { values: f64[], width: i64, error: u8[] }
struct MotifHit { position: i64, reverse: bool, score: f64 }
struct MotifScan { hits: MotifHit[], error: u8[] }
fn motif_base(c: u8) -> i64 {
    return match c { 'A', 'a' => 0, 'C', 'c' => 1, 'G', 'g' => 2, 'T', 't' => 3, _ => -1 };
}
fn motif_counts(sites: const u8[][:]) -> MotifMatrix {
    if sites.len == 0 { return MotifMatrix { [], 0, "no sites" }; }
    var width: i64 = 0;
    for site in sites { width = site.len; break; }
    var values: f64[>..] = [];
    for i in width * 4 { values.push(0.0); }
    for site in sites {
        if site.len != width { return MotifMatrix { [], 0, "unequal site lengths" }; }
        for c, i in site {
            let b = motif_base(c);
            if b < 0 { return MotifMatrix { [], 0, "expected unambiguous DNA" }; }
            values[i * 4 + b] += 1.0;
        }
    }
    return MotifMatrix { copy(values), width, "" };
}
fn motif_pwm(counts: const MotifMatrix&, pseudocount: f64 = 1.0) -> MotifMatrix {
    if counts.error.len > 0 { return copy(counts); }
    if counts.width < 0 || counts.values.len != counts.width * 4 || !(pseudocount >= 0.0) || is_inf(pseudocount) {
        return MotifMatrix { [], 0, "invalid counts or pseudocount" };
    }
    var values: f64[>..] = [];
    for i in counts.width {
        var total = 4.0 * pseudocount;
        for b in 4 {
            let v = counts.values[i * 4 + b];
            if !(v >= 0.0) || is_inf(v) { return MotifMatrix { [], 0, "invalid count" }; }
            total += v;
        }
        if !(total > 0.0) || is_inf(total) { return MotifMatrix { [], 0, "invalid column total" }; }
        for b in 4 { values.push((counts.values[i * 4 + b] + pseudocount) / total); }
    }
    return MotifMatrix { copy(values), counts.width, "" };
}
// Scores are log2 odds; zero probabilities give negative infinity.
fn motif_pssm(pwm: const MotifMatrix&, background: const f64[:]) -> MotifMatrix {
    if pwm.error.len > 0 { return copy(pwm); }
    if background.len != 4 || pwm.width < 0 || pwm.values.len != pwm.width * 4 { return MotifMatrix { [], 0, "invalid dimensions" }; }
    var total = 0.0;
    for p in background {
        if !(p > 0.0) || is_inf(p) { return MotifMatrix { [], 0, "invalid background" }; }
        total += p;
    }
    if abs(total - 1.0) > 1e-9 { return MotifMatrix { [], 0, "background must sum to one" }; }
    var values: f64[>..] = [];
    for i in pwm.width {
        total = 0.0;
        for b in 4 {
            let p = pwm.values[i * 4 + b];
            if !(p >= 0.0 && p <= 1.0) { return MotifMatrix { [], 0, "invalid PWM" }; }
            total += p;
            values.push((log(p) - log(background[b])) / log(2.0));
        }
        if abs(total - 1.0) > 1e-9 { return MotifMatrix { [], 0, "PWM column must sum to one" }; }
    }
    return MotifMatrix { copy(values), pwm.width, "" };
}
// Reverse hits use forward-reference, zero-based window coordinates.
fn motif_scan(text: const u8[:], pssm: const MotifMatrix&, threshold: f64, both_strands: bool = true) -> MotifScan {
    if pssm.error.len > 0 { return MotifScan { [], copy(pssm.error) }; }
    if pssm.width < 0 || pssm.values.len != pssm.width * 4 || threshold != threshold { return MotifScan { [], "invalid scan parameters" }; }
    for v in pssm.values { if v != v || (is_inf(v) && v > 0.0) { return MotifScan { [], "invalid score" }; } }
    for c in text { if motif_base(c) < 0 { return MotifScan { [], "expected unambiguous DNA" }; } }
    var hits: MotifHit[>..] = [];
    if pssm.width > text.len { return MotifScan { [], "" }; }
    for pos in text.len - pssm.width + 1 {
        var forward = 0.0; var reverse = 0.0;
        for j in pssm.width {
            forward += pssm.values[j * 4 + motif_base(text[pos + j])];
            reverse += pssm.values[j * 4 + 3 - motif_base(text[pos + pssm.width - j - 1])];
        }
        if forward >= threshold { hits.push(MotifHit { pos, false, forward }); }
        if both_strands && reverse >= threshold { hits.push(MotifHit { pos, true, reverse }); }
    }
    return MotifScan { copy(hits), "" };
}
