import bio from "../..";
import bio.io.alignment_io;
import bio.io.genbank;
fn main() {
    let records = [bio::SequenceRecord { "long_identifier", "AC-Gt-", "" }, bio::SequenceRecord { "b", "ACTGt-", "" }];
    let c = bio::write_clustal(records); assert(c.error.len == 0); print(c.text);
    print("===PHYLIP===");
    let p = bio::write_phylip(records); assert(p.error.len == 0); print(p.text);
    print("===GENBANK===");
    let input = "LOCUS       LOCUS_NAME 6 bp DNA\nDEFINITION  distinct identifiers\nACCESSION   ABC123\nVERSION     ABC123.2\nFEATURES             Location/Qualifiers\n     gene            complement(2..4)\n                     /gene=\"example\"\nORIGIN\nacgtac\n//\n";
    let parsed = bio::parse_genbank(input); assert(parsed.error.len == 0);
    for r in parsed.records { assert(r.id == "LOCUS_NAME"); }
    let g = bio::write_genbank(parsed.records); assert(g.error.len == 0); print(g.text);
}
