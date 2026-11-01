// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import std;
import bio from "..";
import bio.alignment.frameshift;
fn main() {
    let r = bio::frameshift_alignment("MSR", "ATGTCTCGT");
    assert(r.complete && r.score == 3.0 && r.nt_start == 0 && r.nt_end == 9);
    let f = bio::frameshift_alignment("M", "CCATGAA");
    assert(f.score == 1.0 && f.nt_start == 2 && f.nt_end == 5);
    let l = bio::frameshift_alignment("MLGSNESRVCPKLSPS", "ATGCTGGGCTCGAACGAGTCCGTGTATGCCCTAAGCTGAGCCCGTCG");
    assert(l.score == 13.0 && l.protein_coordinates == [0, 7, 7, 16] && l.nucleotide_coordinates == [0, 21, 20, 47]);
    assert(bio::frameshift_alignment("M", "AT").error == "no complete alignment");
    assert(bio::frameshift_alignment("", "AT").complete);
    assert(bio::frameshift_alignment("?", "ATG").error.len > 0);
    assert(bio::frameshift_alignment("M", "ANT").error.len > 0);
    let a = bio::frameshift_alignment("MM", "ATGAT");
    assert(a.complete && a.score == -2.0);
    var big: u8[>..] = [];
    for k in 2000 { big.push('A'); }
    assert(bio::frameshift_alignment(big, big).error.len > 0);
    var invalid = bio::frameshift_defaults(); invalid.code = 99;
    assert(bio::frameshift_alignment("M", "ATG", invalid).error.len > 0);
    let infinity, parsed = parse_flt("1e309");
    assert(parsed && is_inf(infinity));
    if parsed {
        invalid = bio::frameshift_defaults(); invalid.match_score = infinity;
        assert(bio::frameshift_alignment("M", "ATG", invalid).error.len > 0);
    }
    invalid = bio::frameshift_defaults(); invalid.minus_two = infinity - infinity;
    assert(bio::frameshift_alignment("M", "ATG", invalid).error.len > 0);
    invalid = bio::frameshift_defaults(); invalid.match_score = 1.0e308;
    assert(bio::frameshift_alignment("MM", "ATGATG", invalid).error.len > 0);
    assert(!bio::frameshift_alignment("M", "").complete);
    let tie = bio::frameshift_alignment("M", "ATGATG");
    assert(tie.nt_start == 0 && tie.nt_end == 3);
    let b = bio::frameshift_alignment("MM", "ATGGATG");
    assert(b.complete && b.score == 1.0);
}
