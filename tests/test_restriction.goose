// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.sequence.restriction;
fn main() {
    assert(bio::restriction_catalog().len == 1088);
    for e in bio::restriction_catalog() {
        if e.support != "single" { assert(bio::catalog_search("ACGT", e.name).error.len > 0); }
    }
    assert(bio::catalog_search("GAATTC", "missing").cuts.len == 0);
    assert(bio::catalog_search("GAANTC", "EcoRI").error.len > 0);
    let e = bio::catalog_enzyme("BsaI");
    assert(e.fst5 == 7 && e.fst3 == 5);
    let f = bio::catalog_search("AAAGGTCTCAAAAAAAAAAAAA", "BsaI");
    assert(f.cuts.len == 1);
    for h in f.cuts { assert(h.start == 3 && h.top == 10 && h.bottom == 14); }
    let r = bio::catalog_search("TTTTTTTTTTTTTGAGACCTTT", "BsaI");
    assert(r.cuts.len == 1);
    for h in r.cuts { assert(h.strand == -1 && h.top == h.start-5 && h.bottom == h.start-1); }
    let origin = bio::catalog_search("AATTCAAAAG", "EcoRI", true);
    assert(origin.cuts.len == 1);
    let d = bio::catalog_digest("AATTCAAAAG", "EcoRI", true);
    assert(d.fragments.len == 1);
    for fragment in d.fragments { assert(fragment == "AATTCAAAAG"); }
    var huge: u8[>..] = [];
    for i in 1048577 { huge.push('A'); }
    assert(bio::catalog_search(huge, "EcoRI").error.len > 0);
    var many: u8[][>..] = [];
    for i in 1025 { many.push(bio::restriction_copy("A")); }
    assert(bio::catalog_caps(copy(many), []).error.len > 0);
    let bad = bio::catalog_caps([bio::restriction_copy("ACGT"), bio::restriction_copy("ACG")], [bio::restriction_copy("EcoRI")]);
    assert(bad.error.len > 0 && bad.markers.len == 0);
    let unsupported = bio::catalog_caps([bio::restriction_copy("GAATTC")], [bio::restriction_copy("EcoRI"), bio::restriction_copy("missing")]);
    assert(unsupported.error.len > 0 && unsupported.markers.len == 0);
}
