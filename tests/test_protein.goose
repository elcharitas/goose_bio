import std;
import bio from "..";
import bio.sequence.protein;
fn main() {
    let p = bio::protein_properties("ACDEFGHIKLMNPQRSTVWY");
    assert(p.error.len == 0);
    assert(p.counts.len == 20 && p.counts[0] == 1);
    assert(bio::protein_properties("").error.len > 0);
    assert(bio::protein_properties("AX").error.len > 0);
    assert(bio::protein_properties("a c").error.len > 0);
    assert(bio::protein_properties("ac").sequence == "AC");
    for c in "BJOUXZ*- \n" {
        let bad: u8[] = [c];
        assert(bio::protein_properties(bad).error.len > 0);
    }
    assert(bio::protein_properties("A", -1.0).error.len > 0);
    assert(bio::protein_properties("A", 15.0).error.len > 0);
    print("protein validation passed");
}
