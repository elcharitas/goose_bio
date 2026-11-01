import bio from "..";
import bio.io.ace;
fn main() {
    let result = bio::parse_ace("AS 1 1\nCO c 4 1 0 U\nA*CG\n\nBQ\n10 20 30\n\nAF r U 1\nRD r 4 0 0\nA*CG\n\nQA 1 4 1 4");
    assert(result.error.len == 0);
    for c in result.assembly.contigs {
        let exported = bio::ace_unpadded_consensus(copy(c));
        print(exported.sequence);
        assert(exported.qualities == [10, 20, 30]);
        let maps = bio::ace_coordinate_maps(c.consensus);
        assert(maps.padded_to_unpadded == [1, 0, 2, 3]);
    }
}
