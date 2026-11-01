import std;

import bio from "..";
import bio.alignment.pairwise;
import bio.search.matching;
import bio.collections.intervals;
import bio.stats.probability;
import math;
fn main() {
    assert(bio::hamming_distance("ACGT", "AGGA") == 2);
    assert(bio::edit_distance("kitten", "sitting") == 3);
    assert(bio::edit_distance("", "AC") == 2);
    assert(bio::edit_distance("AC", "") == 2);
    let g = bio::affine_alignment("ACGT", "AGT");
    assert(g.score == 3 && g.a_start == 0 && g.a_end == 4);
    assert(g.a_aligned == "ACGT" && g.b_aligned == "A-GT");
    let gap = bio::affine_alignment("AAAA", "A");
    assert(gap.score == -3);
    let empty = bio::affine_alignment("", "AAA");
    assert(empty.score == -5 && empty.a_aligned == "---");
    let zero = bio::affine_alignment("", "");
    assert(zero.score == 0 && zero.a_aligned.len == 0);
    let l = bio::affine_alignment("TTACGTAA", "GGACGTCC", 2, -1, 3, 1, true);
    assert(l.score == 8 && l.a_start == 2 && l.a_end == 6);
    assert(l.b_start == 2 && l.b_end == 6 && l.a_aligned == "ACGT");
    let none = bio::affine_alignment("A", "T", 2, -1, 3, 1, true);
    assert(none.score == 0 && none.a_aligned.len == 0);
    let hits = bio::exact_search("AAAA", "AA");
    assert(hits.len == 3 && hits[0] == 0 && hits[2] == 2);
    assert(bio::exact_search("A", "").len == 2);
    assert(bio::exact_search("A", "AA").len == 0);
    let approx = bio::approximate_search("ACGATG", "ACG", 1);
    assert(approx.len == 2 && approx[0] == 0 && approx[1] == 3);
    let sa = bio::suffix_array("banana");
    assert(sa.len == 6 && sa[0] == 5 && sa[1] == 3 && sa[2] == 1);
    assert(sa[3] == 0 && sa[4] == 4 && sa[5] == 2);
    assert(bio::suffix_array("").len == 0);
    let a = bio::Interval { 2, 5 }; let b = bio::Interval { 5, 7 };
    assert(!bio::interval_overlap(a, b));
    assert(!bio::interval_overlap(a, bio::Interval { 3, 3 }));
    assert(bio::interval_contains(a, 2) && !bio::interval_contains(a, 5));
    let intervals: bio::Interval[3] = [a, b, bio::Interval { 0, 3 }];
    let q = bio::interval_query(intervals, bio::Interval { 3, 6 });
    assert(q.len == 2 && q[0] == 0 && q[1] == 1);
    assert(abs(bio::phred_error_probability(20.0) - 0.01) < 1e-12);
    assert(abs(bio::probability_to_phred(0.01) - 20.0) < 1e-12);
    assert(abs(bio::log_add_probability(bio::log_probability(0.2), bio::log_probability(0.3)) - log(0.5)) < 1e-12);
    assert(is_inf(bio::log_probability(0.0)));
    assert(abs(bio::log_add_probability(bio::log_probability(0.0), log(0.5)) - log(0.5)) < 1e-12);
    assert(abs(bio::log_add_probability(0.0, -40.0) / exp(-40.0) - 1.0) < 1e-12);
    assert(bio::log_add_probability(-40.0, 0.0) > 0.0);
    assert(is_inf(bio::probability_to_phred(0.0)));
    assert(bio::probability_to_phred(1.0) == 0.0);
    let wide_gap = bio::affine_alignment("", "A", 2, -1, 100000000000000000, 1);
    assert(wide_gap.score == -100000000000000000 && wide_gap.a_aligned == "-");
    let free_gap = bio::affine_alignment("AAC", "AC", 2, -1, 0, 0);
    assert(free_gap.score == 4);
    let obs:        i64[2] = [0, 1];
    let initial:    f64[2] = [log(0.6), log(0.4)];
    let transition: f64[4] = [log(0.7), log(0.3), log(0.4), log(0.6)];
    let emission:   f64[4] = [log(0.5), log(0.5), log(0.1), log(0.9)];
    let likelihood = bio::hmm_forward_log(obs, initial, transition, emission, 2);
    assert(abs(exp(likelihood) - 0.2156) < 1e-12);
    let no_obs: i64[0] = [];
    assert(bio::hmm_forward_log(no_obs, initial, transition, emission, 2) == 0.0);
    let impossible: f64[4] = [log(0.0), log(0.0), log(0.0), log(0.0)];
    assert(is_inf(bio::hmm_forward_log(obs, initial, transition, impossible, 2)));
    for na in 4 { for nb in 4 {
        for av in (1 << na) { for bv in (1 << nb) {
            var a: u8[>..] = []; var b: u8[>..] = [];
            for i in na { a.push(if (av >> i) % 2 == 0 { 'A' } else { 'C' }); }
            for i in nb { b.push(if (bv >> i) % 2 == 0 { 'A' } else { 'C' }); }
            let result = bio::affine_alignment(a, b, 0, -1, 1, 1);
            assert(result.score == -bio::edit_distance(a, b));
            var ai: i64 = 0; var bj: i64 = 0; var score: i64 = 0;
            assert(result.a_aligned.len == result.b_aligned.len);
            for i in result.a_aligned.len {
                let x = result.a_aligned[i]; let y = result.b_aligned[i];
                assert(x != '-' || y != '-');
                if x != '-' { assert(x == a[ai]); ai += 1; }
                if y != '-' { assert(y == b[bj]); bj += 1; }
                if x != y { score -= 1; }
            }
            assert(ai == a.len && bj == b.len && score == result.score);
        } }
    } }
    print("algorithm assertions passed (225 exhaustive alignment pairs)");
}
