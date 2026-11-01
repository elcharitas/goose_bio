import bio from "..";
import bio.io.genbank;
fn main() {
    let text = "LOCUS       TEST 12 bp DNA circular\nDEFINITION  example record\nACCESSION   X123\nVERSION     X123.2\nCOMMENT     preserved\nFEATURES             Location/Qualifiers\n     CDS             complement(join(1..3,7..9))\n                     /gene=\"a\"\n                     /note=\"two \"\"quotes\"\"\"\n                     /pseudo\nORIGIN\n        1 acgtacgtacgt\n//\n";
    let parsed = bio::parse_genbank(text);
    assert(parsed.error.len == 0 && parsed.records.len == 1);
    for r in parsed.records {
        assert(r.id == "TEST" && r.sequence == "ACGTACGTACGT");
        assert(r.description == "example record");
        for f in r.features {
            assert(f.parts.len == 2 && f.parts[0].start == 6 && f.parts[1].start == 0);
            assert(f.parts[0].strand == -1 && f.qualifiers.len == 3);
            assert(bio::extract_feature(r.sequence, copy(f)).value == "TACCGT");
        }
    }
    let written = bio::write_genbank(parsed.records);
    assert(written.error.len == 0);
    let again = bio::parse_genbank(written.text);
    assert(again.error.len == 0);
    assert(bio::write_genbank(again.records).text == written.text);
    assert(bio::parse_genbank("LOCUS X 1 bp DNA\nORIGIN\na\n").error.len > 0);
    assert(bio::parse_genbank("LOCUS X 2 bp DNA\nORIGIN\na\n//\n").error.len > 0);
    for loc in ["<1..3", "X:1..3", "1^2", "order(1,2)", "1...3", "join(1,)", "0", "3..1"] {
        assert(bio::genbank_location(loc).error.len > 0);
    }
    let mixed = bio::genbank_location("join(1,complement(3..4),join(7,9))");
    assert(mixed.error.len == 0 && mixed.parts.len == 4 && mixed.parts[1].strand == -1);
    assert(bio::genbank_location("complement(complement(1..2))").parts[0].strand == 1);
    let bad = bio::AnnotatedRecord { "x", "", "AC", [bio::FeatureQualifier { "unknown", ["v"] }], [], false };
    let bad_records = [copy(bad)];
    assert(bio::write_genbank(bad_records).error.len > 0);
    let simple = bio::AnnotatedRecord { "rna", "example", "ACGU", [], [], true };
    let simple_records = [copy(simple)];
    let rna = bio::write_genbank(simple_records);
    assert(rna.error.len == 0 && bio::parse_genbank(rna.text).error.len == 0);
    var double_text: u8[>..] = []; double_text.append(text); double_text.append(text);
    assert(bio::parse_genbank(double_text).records.len == 2);
    let multiple = bio::parse_genbank(double_text);
    assert(bio::write_genbank(multiple.records).error.len == 0);
    for r in again.records {
        for h in r.metadata {
            assert(h.key == "genbank_header" && h.values.len == 4);
            var accession = false;
            for v in h.values { if v == "ACCESSION   X123" { accession = true; } }
            assert(accession);
        }
        for f in r.features {
            var quoted = false;
            for q in f.qualifiers { if q.key == "note" { for v in q.values { assert(v == "two \"quotes\""); quoted = true; } } }
            assert(quoted);
        }
    }
    for t in [
        "LOCUS x 2 bp DNA\nFEATURES             Location/Qualifiers\n     gene            <1..2\nORIGIN\nac\n//\n",
        "LOCUS x 2 bp DNA\nFEATURES             Location/Qualifiers\n     gene            1..3\nORIGIN\nac\n//\n",
        "LOCUS x 2 bp DNA\nFEATURES             Location/Qualifiers\n     gene            1..2\n                     /note=\"unfinished\nORIGIN\nac\n//\n",
        "LOCUS x 2 bp DNA\nDEFINITION  first\n            continuation\nORIGIN\nac\n//\n",
    ] { assert(bio::parse_genbank(t).error.len > 0); }
    assert(bio::parse_genbank("LOCUS x 1 bp DNA\nDEFINITION \nORIGIN\na\n//\n").error.len > 0);
    assert(bio::parse_genbank("LOCUS x 1 bp DNA\nDEFINITION  \nDEFINITION  again\nORIGIN\na\n//\n").error.len > 0);
    let empty = bio::parse_genbank("LOCUS x 1 bp DNA\nDEFINITION  \nORIGIN\na\n//\n");
    assert(empty.error.len == 0 && empty.records.len == 1);
    for r in empty.records { assert(r.description.len == 0); }
    for r in again.records { for h in r.metadata { var version = false; for v in h.values { if v == "VERSION     X123.2" { version = true; } } assert(version); } }
    let stale = [bio::AnnotatedRecord { "new_id", "", "AC", [bio::FeatureQualifier { "genbank_header", ["LOCUS old_id 2 bp DNA"] }], [], false }];
    assert(bio::write_genbank(stale).error.len > 0);
    let injection = [bio::AnnotatedRecord { "x", "", "AC", [bio::FeatureQualifier { "genbank_header", ["LOCUS x 2 bp DNA\nORIGIN"] }], [], false }];
    assert(bio::write_genbank(injection).error.len > 0);
    print("GenBank assertions passed");
}
