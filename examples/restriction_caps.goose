import bio from "..";
import bio.sequence.restriction;
fn main() {
    let result = bio::catalog_digest("AAAGAATTCTTT", "EcoRI");
    assert(result.error.len == 0);
    for fragment in result.fragments { print(fragment); }
    let caps = bio::catalog_caps([bio::restriction_copy("AAAGAATTCTTT"), bio::restriction_copy("AAAGACTTCTTT")], [bio::restriction_copy("EcoRI")]);
    assert(caps.error.len == 0 && caps.markers.len == 1);
}
