import std;
import bio from "..";
import bio.alignment.substitution;
fn main() {
    let m = bio::substitution_matrix("BLOSUM62");
    assert(m.error.len == 0);
    assert(bio::substitution_score(m, "W", "W").value == 11.0);
    assert(bio::matrix_alignment("AW", "AW", m).score == 15.0);
    assert(bio::matrix_alignment("?", "A", m).error.len > 0);
    assert(bio::substitution_matrix("missing").error.len > 0);
    assert(bio::matrix_alignment("", "AA", m, 3.25).score == -6.5);
    assert(bio::matrix_alignment("", "", m).score == 0.0);
    assert(bio::matrix_alignment("A", "W", m, 5.0, true).score == 0.0);
    assert(bio::matrix_alignment("a", "A", m).error.len > 0);
    assert(bio::matrix_alignment("A-", "AA", m).error.len > 0);
    assert(bio::matrix_alignment("A", "A", m, -1.0).error.len > 0);
    let codon = bio::substitution_matrix("SCHNEIDER");
    assert(bio::substitution_score(codon, "AAA", "AAA").error.len == 0);
    assert(bio::matrix_alignment("AAA", "AAA", codon).error.len > 0);
    assert(bio::substitution_score(m, "?", "A").error.len > 0);
    print("substitution validation passed");
}
