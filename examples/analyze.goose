import bio from "..";

fn main() {
    let input = bio::parse_fasta(">coding_sequence\nATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG\n");
    assert(input.error.len == 0);
    for record in input.records {
        let protein = bio::translate(record.sequence);
        let gc = bio::gc_content(record.sequence);
        assert(protein.error.len == 0 && gc.error.len == 0);
        print(record.header, ": protein=", protein.value, " GC=", gc.fraction);
        let index = bio::fm_index(record.sequence);
        let sites = bio::fm_locate(index, "ATG");
        assert(sites.error.len == 0);
        print("ATG positions in suffix-array order: ", sites.positions);
    }
    let alignment = bio::affine_alignment("ACGTTGCA", "ACGTGCA");
    print(alignment.a_aligned, "\n", alignment.b_aligned, "\nscore=", alignment.score);
}
