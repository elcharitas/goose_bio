import bio from "..";
import bio.io.phd;
import bio.io.geo;
import bio.io.unigene;
fn main() {
    let text = "BEGIN_SEQUENCE trace one\nBEGIN_COMMENT\nTRIM: 1 3 0.05\nCHROMAT_FILE: trace.ab1\nFUTURE: a:b\nEND_COMMENT\nBEGIN_DNA\na 0 1\nC 93 12\nN 1000\nEND_DNA\nEND_SEQUENCE";
    let p = bio::read_phd(text);
    assert(p.error.len == 0 && p.record.sequence == "aCN" && p.record.seq_trimmed == "CN");
    assert(p.record.sites.len == 3 && p.record.comments.len == 3 && p.record.raw == joined(text,"\n",""));
    for s, i in p.record.sites { if i == 2 { assert(!s.has_peak && s.quality == 1000); } }
    for bad_name in ["x ", "x\t"] {
        let bad = bio::PhdRecord { joined(bad_name,"",""), copy(p.record.comments), copy(p.record.sites),
            copy(p.record.sequence), copy(p.record.seq_trimmed), "" };
        let bad_records = [copy(bad)];
        assert(bio::write_phd(bad_records).error.len > 0);
    }
    let bad_fields = [bio::SpecialistField { "FUTURE ", "value" },
        bio::SpecialistField { " FUTURE", "value" }, bio::SpecialistField { "FUTURE", " value " }];
    for field in bad_fields {
        let bad = bio::PhdRecord { "x", [copy(field)], copy(p.record.sites),
            copy(p.record.sequence), "", "" };
        let bad_records = [copy(bad)];
        assert(bio::write_phd(bad_records).error.len > 0);
    }
    let records = [copy(p.record)]; let w = bio::write_phd(records);
    assert(w.error.len == 0 && bio::read_phd(w.text).error.len == 0);
    assert(bio::parse_phd("").records.len == 0 && bio::read_phd("").error.len > 0);
    assert(bio::read_phd(joined(text,"\n",text)).error.len > 0);
    for bad in ["BEGIN_SEQUENCE x", "BEGIN_SEQUENCE x\nBEGIN_COMMENT\nTRIM: 2 1 0.1", "BEGIN_SEQUENCE x\nBEGIN_COMMENT\nEND_COMMENT\nBEGIN_DNA\na -1", "BEGIN_SEQUENCE x\nBEGIN_COMMENT\nEND_COMMENT\nBEGIN_DNA\na 9223372036854775808", "BEGIN_SEQUENCE x\nBEGIN_COMMENT\nEND_COMMENT\nBEGIN_DNA\na 2 -1", "BEGIN_SEQUENCE x\nBEGIN_COMMENT\nEND_COMMENT\nBEGIN_DNA\naa 2"] { assert(bio::parse_phd(bad).error.len > 0); }
    for site in ["a -1", "a 9223372036854775808", "a 1 -1", "a 1 2 3", "Z 3", "aa 3"] {
        let bad = joined("BEGIN_SEQUENCE x\nBEGIN_COMMENT\nEND_COMMENT\nBEGIN_DNA\n",site,"\nEND_DNA\nEND_SEQUENCE");
        assert(bio::parse_phd(bad).error.len > 0);
    }
    for bounds in ["0 5 0.1", "0 1 nan", "0 1 1.1", "0 1 1e-2"] {
        let bad = joined("BEGIN_SEQUENCE x\nBEGIN_COMMENT\nTRIM: ",bounds,"\nEND_COMMENT\nBEGIN_DNA\na 1\nEND_DNA\nEND_SEQUENCE");
        assert(bio::parse_phd(bad).error.len > 0);
    }
    for c in p.record.comments { if c.key == "FUTURE" { assert(c.value == "a:b"); } }
    assert(bio::read_phd("BEGIN_SEQUENCE empty\nBEGIN_COMMENT\nEND_COMMENT\nBEGIN_DNA\nEND_DNA\nEND_SEQUENCE").error.len == 0);
    let ug = "ID          Hs.1\nTITLE       cluster title\nGENE        ABC\nEXPRESS     brain | liver\nSCOUNT      1\nSEQUENCE    ACC=X1; NID=g1; CLONE=IMAGE:42; FUTURE=a=b\nFUTURE      raw extension\n//";
    let u = bio::parse_unigene(ug);
    assert(u.error.len == 0 && u.records.len == 1);
    for r in u.records { assert(r.id == "Hs.1" && r.species == "Hs" && r.sequences.len == 1 && r.metadata.len == 5); assert(r.raw == joined(ug,"\n","")); for s in r.sequences { assert(s.fields.len == 4); for f in s.fields { if f.key == "FUTURE" { assert(f.value == "a=b"); } } } }
    assert(bio::parse_unigene("").records.len == 0);
    for bad in ["ID          Hs.1", "ID          Hs.1\nSCOUNT      1\n//", "ID          Hs.1\nSCOUNT      -1\n//", "ID          Hs.1\n            continuation", "ID          Hs.1\nSCOUNT      0\nSCOUNT      0\n//", "ID          Hs.1\nSEQUENCE    bad\n//"] { assert(bio::parse_unigene(bad).error.len > 0); }
    let g = bio::parse_geo("^SAMPLE = GSM1\r\n!Sample_title = title\n!Sample_characteristics = one\n!Sample_characteristics = two\n#ID_REF = identifier\n#VALUE = value\n!Sample_table_begin\nID_REF\tVALUE\nx\t\n!Sample_table_end\n^SERIES = GSE1\n!Future = a=b");
    assert(g.error.len == 0 && g.records.len == 2);
    for r, i in g.records { if i == 0 { assert(r.attributes.len == 3 && r.columns.len == 2 && r.rows.len == 2); for row in r.rows { assert(row.fields.len == 2); } } }
    assert(bio::parse_geo("").records.len == 0);
    for bad in ["!orphan = x", "^SAMPLE = x\n!Sample_table_end", "^SAMPLE = x\n!Sample_table_begin", "^SAMPLE = x\n#A = one\n#A = two", "^SAMPLE = x\n!Sample_table_begin\n!Platform_table_end"] { assert(bio::parse_geo(bad).error.len > 0); }
    print("specialist parsers passed");
}

fn joined(a: u8[:], b: u8[:], c: u8[:]) -> u8[] { var out: u8[>..] = []; out.append(a); out.append(b); out.append(c); return copy(out); }
