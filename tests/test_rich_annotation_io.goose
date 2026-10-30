import bio from "..";
import bio.io.rich_annotation_io;
fn main() {
    let text = "LOCUS       TEST 8 bp DNA circular UNK 01-JAN-1980\nDEFINITION  two\n            lines\nFEATURES             Location/Qualifiers\n     gene            join(7..8,1..2)\n                     /note=\"say \"\"yes\"\"\n                     again\"\n                     /note=\"second\"\nORIGIN\n acgtagtc\n//\n";
    let parsed = bio::rich_parse_genbank(text);
    assert(parsed.error.len == 0);
    for r in parsed.records {
        assert(r.description == "two lines" && r.topology == 1);
        for f in r.features {
            assert(f.qualifiers.len == 2);
            assert(bio::extract_rich_feature(copy(r), copy(f)).value == "TCAC");
        }
        assert(bio::slice_rich_record(copy(r), 0, 7).error.len > 0);
        let full = bio::slice_rich_record(copy(r), 0, 8);
        let batch = [copy(full.record)];
        assert(bio::rich_write_genbank(batch).error.len == 0);
    }
    let named = bio::rich_parse_genbank("LOCUS circular 8 bp DNA linear UNK 01-JAN-1980\nORIGIN\nacgtacgt\n//\n");
    assert(named.error.len == 0);
    for r in named.records { assert(r.topology == 0); let batch = [copy(r)];
        let encoded = bio::rich_write_genbank(batch); assert(encoded.error.len == 0);
        for rr in bio::rich_parse_genbank(encoded.text).records { assert(rr.topology == 0); }
    }
    let translation = bio::rich_parse_genbank("LOCUS x 8 bp DNA linear UNK 01-JAN-1980\nFEATURES             Location/Qualifiers\n     CDS             1..8\n                     /translation=\"M A\n                     A G\"\nORIGIN\nacgtacgt\n//\n");
    assert(translation.error.len == 0);
    for r in translation.records { for f in r.features { for q in f.qualifiers { for v in q.values { assert(v == "MAAG"); } } } }
    assert(bio::rich_parse_genbank("LOCUS x 8 bp DNA linear UNK 01-JAN-1980\nORIGIN      origin metadata\nacgtacgt\n//\n").error.len > 0);
    for whitespace in [11, 12] {
        var input: u8[>..] = [];
        input.append("LOCUS x 8 bp DNA linear UNK 01-JAN-1980\nFEATURES             Location/Qualifiers\n     CDS             1..8\n                     /translation=\"M");
        input.push(whitespace as u8); input.append("A\"\nORIGIN\nacgtacgt\n//\n");
        let checked = bio::rich_parse_genbank(input); assert(checked.error.len == 0);
        for r in checked.records { for f in r.features { for q in f.qualifiers { for v in q.values { assert(v == "MA"); } } } }
    }
    let remote = bio::RichRecord { "x", "", 8, [], [], [bio::RecordFeature { "gene", [bio::RecordLocationPart { bio::RecordPosition { 0, 0 }, bio::RecordPosition { 0, 2 }, 1, "X" }], [] }], [], false, 0 };
    let batch = [copy(remote)];
    let failed = bio::rich_write_genbank(batch);
    assert(failed.error.len > 0 && failed.text.len == 0);
    assert(bio::rich_parse_genbank("LOCUS x 8 bp DNA circular UNK 01-JAN-1980\nORIGIN\na\n//\n").error.len > 0);
    assert(bio::rich_parse_genbank("LOCUS x 8 bp DNA circular UNK 01-JAN-1980\nFEATURES             Location/Qualifiers\n     gene            1..2\n                     /note=\"unfinished\n").error.len > 0);
}
