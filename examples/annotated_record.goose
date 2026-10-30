import bio from "..";

fn main() {
    let source = "LOCUS demo 8 bp DNA circular UNK 01-JAN-1980\nDEFINITION  circular feature example\nFEATURES             Location/Qualifiers\n     gene            join(7..8,1..2)\n                     /note=\"origin-spanning feature\"\nORIGIN\nacgtagtc\n//\n";
    let parsed = bio::rich_parse_genbank(source);
    assert(parsed.error.len == 0);
    for record in parsed.records {
        for feature in record.features {
            let extracted = bio::extract_rich_feature(copy(record), copy(feature));
            assert(extracted.error.len == 0 && extracted.value == "TCAC");
            print("feature: ", extracted.value);
        }
        let reversed = bio::reverse_complement_rich_record(copy(record));
        assert(reversed.error.len == 0);
        let records = [copy(reversed.record)];
        let encoded = bio::rich_write_genbank(records);
        assert(encoded.error.len == 0);
        print(encoded.text);
    }
}
