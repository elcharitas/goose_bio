import std;
import bio from "..";
import bio.search.fmindex;
import bio.search.motifs;
import bio.search.matching;
import math;
fn compare(text: const u8[:], pattern: const u8[:], stride: i64) {
    let index = bio::fm_index(text, stride);
    assert(index.error.len == 0);
    let hits = bio::fm_locate(index, pattern);
    let expected = bio::exact_search(text, pattern);
    assert(hits.error.len == 0 && hits.positions.len == expected.len);
    for p in expected {
        var count: i64 = 0;
        for q in hits.positions { if p == q { count += 1; } }
        assert(count == 1);
    }
    for c in "ACN" { for end in index.bwt.len + 1 {
        var rank: i64 = 0;
        for i in end { if index.bwt[i] == c { rank += 1; } }
        assert(bio::fm_rank(index, c, end) == rank);
    } }
}
fn main() {
    compare("banana", "ana", 2); compare("NNN!NN", "N!", 3);
    for n in 6 { for bits in (1 << n) {
        var text: u8[>..] = [];
        for i in n { text.push(if (bits >> i) % 2 == 0 { 'A' } else { 'C' }); }
        for m in 4 { for pb in (1 << m) {
            var pattern: u8[>..] = [];
            for i in m { pattern.push(if (pb >> i) % 2 == 0 { 'A' } else { 'C' }); }
            compare(text, pattern, 1); compare(text, pattern, 4); compare(text, pattern, 128);
        } }
    } }
    let zero: u8[1] = [0];
    assert(bio::fm_index(zero).error.len > 0);
    assert(bio::fm_index("AC", 0).error.len > 0);
    let idx = bio::fm_index("AC");
    assert(bio::fm_locate(idx, zero).error.len > 0);
    let sites: u8[][>..] = ["AC", "AT"];
    let counts = bio::motif_counts(sites);
    assert(counts.error.len == 0 && counts.width == 2 && counts.values[0] == 2.0);
    let pwm = bio::motif_pwm(counts, 0.0);
    assert(pwm.values[0] == 1.0 && pwm.values[5] == 0.5);
    let bg: f64[4] = [0.25, 0.25, 0.25, 0.25];
    let pssm = bio::motif_pssm(pwm, bg);
    assert(pssm.error.len == 0 && abs(pssm.values[0] - 2.0) < 1e-12);
    assert(is_inf(pssm.values[1]) && pssm.values[1] < 0.0);
    let scan = bio::motif_scan("ACGT", pssm, 3.0);
    assert(scan.error.len == 0 && scan.hits.len == 2);
    assert(scan.hits[0].position == 0 && !scan.hits[0].reverse);
    assert(scan.hits[1].position == 2 && scan.hits[1].reverse);
    assert(bio::motif_scan("acgt", pssm, 3.0, false).hits.len == 1);
    assert(bio::motif_scan("A", pssm, 0.0).hits.len == 0);
    assert(bio::motif_scan("", pssm, 0.0).hits.len == 0);
    assert(bio::motif_scan("N", pssm, 0.0).error.len > 0);
    let bad: u8[][>..] = ["AN"];
    assert(bio::motif_counts(bad).error.len > 0);
    let uneven: u8[][>..] = ["A", "AC"];
    assert(bio::motif_counts(uneven).error.len > 0);
    let none: u8[][>..] = [];
    assert(bio::motif_counts(none).error.len > 0);
    assert(bio::motif_pwm(counts, -1.0).error.len > 0);
    assert(bio::motif_pwm(counts, log(0.0)).error.len > 0);
    let smooth = bio::motif_pwm(counts, 1.0);
    assert(abs(smooth.values[0] - 0.5) < 1e-12);
    let invalid_bg: f64[4] = [0.0, 0.5, 0.25, 0.25];
    assert(bio::motif_pssm(pwm, invalid_bg).error.len > 0);
    let wrong_bg: f64[4] = [0.5, 0.5, 0.5, 0.5];
    assert(bio::motif_pssm(pwm, wrong_bg).error.len > 0);
    let nan = log(-1.0);
    assert(bio::motif_pwm(counts, nan).error.len > 0);
    assert(bio::motif_scan("AC", pssm, nan).error.len > 0);
    let nan_bg: f64[4] = [nan, 0.25, 0.25, 0.25];
    assert(bio::motif_pssm(pwm, nan_bg).error.len > 0);
    let blank = bio::MotifMatrix { [0.0, 0.0, 0.0, 0.0], 1, "" };
    assert(bio::motif_pwm(blank, 0.0).error.len > 0);
    let dimensions = bio::MotifMatrix { [], 1, "" };
    assert(bio::motif_pwm(dimensions).error.len > 0);
    assert(bio::motif_scan("AC", dimensions, 0.0).error.len > 0);
    let empty_sites: u8[][>..] = [""];
    let empty_counts = bio::motif_counts(empty_sites);
    let empty_pwm = bio::motif_pwm(empty_counts);
    let empty_pssm = bio::motif_pssm(empty_pwm, bg);
    assert(bio::motif_scan("AC", empty_pssm, 0.0).hits.len == 6);
    let extreme_pwm = bio::MotifMatrix { [1.0, 0.0, 0.0, 0.0], 1, "" };
    let rare_bg: f64[4] = [1e-310, 0.5, 0.25, 0.25];
    let extreme_pssm = bio::motif_pssm(extreme_pwm, rare_bg);
    assert(extreme_pssm.error.len == 0 && !is_inf(extreme_pssm.values[0]));
    assert(abs(extreme_pssm.values[0] - (-log(1e-310) / log(2.0))) < 1e-9);
    assert(bio::motif_scan("A", extreme_pssm, 1000.0, false).hits.len == 1);
    print("FM/motif assertions passed: 2835 exhaustive FM comparisons");
}
