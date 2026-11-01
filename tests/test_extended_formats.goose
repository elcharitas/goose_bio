import bio from "..";
import bio.io.embl;
import bio.io.stockholm;
import bio.io.searchio;
fn main() {
    let embl = "ID   TEST; SV 1; linear; genomic DNA; STD; UNC; 6 BP.\nAC   X123;\nDE   sample\nFT   CDS             complement(join(1..2,5..6))\nFT                   /gene=\"abc\"\nFT                   /pseudo\nSQ   Sequence 6 BP;\n     acgtac 6\n//\n";
    let e = bio::parse_embl(embl); assert(e.error.len == 0 && e.records.len == 1);
    for r in e.records { assert(r.id == "TEST" && r.sequence == "ACGTAC" && r.description == "sample"); for f in r.features { assert(f.parts.len == 2 && f.parts[0].start == 4 && f.parts[0].strand == -1); assert(f.qualifiers.len == 2); } }
    let ew = bio::write_embl(e.records); assert(ew.error.len == 0);
    assert(bio::write_embl(bio::parse_embl(ew.text).records).text == ew.text);
    print(ew.text);
    print("===STOCKHOLM===");
    let sto = "# STOCKHOLM 1.0\n#=GF ID example\n#=GF XX first\n#=GF XX second\n#=GS a DE first  sequence\na AC-\nb ACG\n#=GR a SS HH.\n#=GC SS_cons HH.\n\na GT\nb -T\n#=GR a SS EE\n#=GC SS_cons EE\n//\n";
    let s = bio::parse_stockholm(sto); assert(s.error.len == 0);
    assert(s.alignment.fields.len == 6); for r, i in s.alignment.records { if i == 0 { assert(r.sequence == "AC-GT"); } }
    let sw = bio::write_stockholm(copy(s.alignment)); assert(sw.error.len == 0);
    assert(bio::write_stockholm(copy(bio::parse_stockholm(sw.text).alignment)).text == sw.text);
    print(sw.text);
    print("===BLAST===");
    let blast = "q1\th1\t90.0\t10\t1\t0\t10\t1\t4\t13\t1e-20\t42.5\nq1\th1\t100\t3\t0\t0\t1\t3\t9\t7\t0\t12\nq1\th2\t100\t1\t0\t0\t1\t1\t2\t2\t1\t1\nq2\th1\t100\t2\t0\t0\t2\t3\t5\t6\t0.01\t8\nq2\th1\t100.000\t10\t0\t0\t1\t30\t1\t10\t0\t20\nq2\th1\t100.000\t1000000\t1\t0\t1\t3000000\t1\t1000000\t0\t20\nq2\th1\t100.000\t1000000\t0\t1\t1\t2999997\t1\t1000000\t0\t20\n";
    let b = bio::parse_blast_tab(blast); assert(b.error.len == 0 && b.queries.len == 2);
    for q in b.queries { if q.id == "q1" { assert(q.hits.len == 2); for h in q.hits { if h.id == "h1" { assert(h.hsps.len == 2); for v, i in h.hsps { if i == 0 { assert(v.query_start == 0 && v.query_end == 10 && v.query_strand == -1 && v.hit_start == 3 && v.hit_end == 13 && v.hit_strand == 1 && v.bitscore == 42.5 && v.evalue == 1e-20); } } } } } }
    print(blast);
    for bad in [
        "q\th\t100\t10\t10\t10\t1\t10\t1\t10\t0\t1",
        "q\th\t100.000\t10\t1\t0\t1\t30\t1\t10\t0\t1",
        "q\th\t90.000\t10\t0\t0\t1\t30\t1\t10\t0\t1",
        "q\th\t100.000\t10\t0\t1\t1\t30\t1\t10\t0\t1",
    ] { assert(bio::parse_blast_tab(bad).error.len > 0); }
    for sq in ["SQ   Sequence 999 BP;", "SQ   Sequence two BP;", "SQ   Sequence 2 BP", "SQ   broken", "SQ   Sequence BP;", "SQ   Sequence  BP;", "SQ   Sequence 2 BP;\nSQ   Sequence 2 BP;", ""] {
        var bad: u8[>..] = []; bad.append("ID   X; SV 1; linear; genomic DNA; STD; UNC; 2 BP.\n"); bad.append(sq); bad.append("\nac\n//\n");
        assert(bio::parse_embl(bad).error.len > 0);
    }
    for annotation in ["#=GF DE padded ", "#=GS a DE padded\t", "#=GF DE bad\tvalue"] {
        var bad: u8[>..] = []; bad.append("# STOCKHOLM 1.0\n"); bad.append(annotation); bad.append("\na AC\n//\n");
        assert(bio::parse_stockholm(bad).error.len > 0);
    }
    for good in [
        "q\th\t66.7\t3\t1\t0\t1\t9\t1\t3\t0\t1",
        "q\th\t100\t1000000\t1\t0\t1\t3000000\t1\t1000000\t0\t1",
        "q\th\t80.000\t10\t1\t1\t1\t27\t1\t9\t0\t1",
    ] { assert(bio::parse_blast_tab(good).error.len == 0); }
    for f in s.alignment.fields { if f.scope == "GS" { assert(f.value == "first  sequence"); } }
    let empty = bio::parse_blast_tab(""); assert(empty.error.len == 0 && empty.queries.len == 0);
    let stale = [bio::AnnotatedRecord { "other", "", "AC", [bio::FeatureQualifier { "embl_header", ["ID   old; SV 1; linear; genomic DNA; STD; UNC; 2 BP."] }], [], false }];
    assert(bio::write_embl(stale).error.len > 0);
    let injected = [bio::AnnotatedRecord { "x", "", "AC", [bio::FeatureQualifier { "embl_header", ["ID   x; SV 1; linear; genomic DNA; STD; UNC; 2 BP.", "FT   gene            1..2"] }], [], false }];
    assert(bio::write_embl(injected).error.len > 0);
    for f in s.alignment.fields { if f.scope == "GC" || f.scope == "GR" { assert(f.value == "HH.EE"); } }
    let bad_annotations = bio::StockholmAlignment { copy(s.alignment.records), [bio::StockholmField { "GC", "", "SS_cons", "HH.EE" }, bio::StockholmField { "GC", "", "SS_cons", "HH.EE" }] };
    assert(bio::write_stockholm(copy(bad_annotations)).error.len > 0);
    for bad in ["# STOCKHOLM 1.0\na AC\n#=GR a SS H\n//\n", "# STOCKHOLM 1.0\na AC\n#=GS z DE absent\n//\n", "# STOCKHOLM 1.0\na AC\n", "# STOCKHOLM 1.0\na AC\nb A\n//\n"] { assert(bio::parse_stockholm(bad).error.len > 0); }
    for bad in ["ID   x\n//\n", "ID   X; SV 1; linear; genomic DNA; STD; UNC; 2 BP.\nSQ   Sequence 2 BP;\na\n//\n", "ID   X; SV 1; linear; genomic DNA; STD; UNC; 2 BP.\nFT   gene            <1..2\nSQ   Sequence 2 BP;\nac\n//\n"] { assert(bio::parse_embl(bad).error.len > 0); }
    for bad in ["# comment\n", "a\tb\n", "q\th\t101\t1\t0\t0\t1\t1\t1\t1\t0\t1", "q\th\t1\t1\t0\t0\t0\t1\t1\t1\t0\t1", "q\th\t1\t1\t0\t0\t1\t1\t1\t1\tnan\t1"] { assert(bio::parse_blast_tab(bad).error.len > 0); }
}
