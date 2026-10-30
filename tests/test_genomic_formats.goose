import bio from "..";
import bio.io.genomic_formats;
fn main() {
    let b = bio::parse_typed_bed("chr22\t1000\t5000\tcloneA\t960\t+\t1000\t5000\t0\t2\t567,488,\t0,3512,\textra\n");
    assert(b.error.len == 0 && b.records.len == 1);
    let w = bio::write_typed_bed(b.records); assert(w.error.len == 0);
    for r in bio::parse_typed_bed(w.text).records { for e in r.extras { assert(e == "extra"); } }
    for n in 3..13 {
        let fields: const u8[:][] = ["chr1","0","10","name","1000",".","0","10","255,0,2","1","10","0"];
        var text: u8[>..] = [];
        for i in 0..n { if i > 0 { text.push('\t'); } text.append(fields[i]); }
        let r = bio::parse_typed_bed(text); assert(r.error.len == 0 && r.records.len == 1);
        assert(bio::write_typed_bed(r.records).error.len == 0);
    }
    assert(bio::parse_typed_bed("c\t0\t0").error.len == 0);
    for s in ["c\t-1\t0","c\t1\t0","c\t0\t1\tn\t1001","c\t0\t1\tn\t0\t?","c\t0\t10\tn\t0\t+\t0\t10\t0\t2\t6,6\t0,4","c\t0\t10\tn\t0\t+\t0\t10\t0\t2\t2,2\t8,0","c\t0\t10\tn\t0\t+\t0\t10\t0\t2\t10\t0,0"] { assert(bio::parse_typed_bed(s).error.len > 0); }
    let pe = bio::parse_typed_bedpe(".\t-1\t-1\tchr1\t0\t0\tn\t1e-5\t.\t-\tx\n");
    assert(pe.error.len == 0 && pe.records.len == 1);
    assert(bio::write_typed_bedpe(pe.records).error.len == 0);
    assert(bio::parse_typed_bedpe("c\t-2\t0\tc\t0\t1").error.len > 0);
    let g = bio::parse_gff3("##gff-version 3\n##custom keep=this\n# comment\nctg123\t.\tgene\t1\t9\t.\t?\t.\tID=g%3B1;Parent=p1,p%2C2;Note=a%3Db%3Bc%25\n");
    assert(g.error.len == 0 && bio::genomic_feature_at(g.features,0).start == 0 && bio::genomic_feature_at(g.features,0).end == 9);
    assert(!bio::genomic_feature_at(g.features,0).score_known && bio::genomic_feature_at(g.features,0).phase == -1);
    for v, i in bio::gff3_values(bio::genomic_feature_at(g.features,0),"Parent") { if i == 1 { assert(v == "p,2"); } }
    for v in bio::gff3_values(bio::genomic_feature_at(g.features,0),"ID") { assert(v == "g;1"); }
    for seqid in ["%23chr", "%3Echr"] {
        var input: u8[>..] = []; input.append("##gff-version 3\n"); input.append(seqid);
        input.append("\t.\tgene\t1\t2\t.\t+\t.\t.\n");
        let parsed = bio::parse_gff3(input); assert(parsed.error.len == 0 && parsed.features.len == 1);
        let written = bio::write_gff3(copy(parsed)); assert(written.error.len == 0);
        let reread = bio::parse_gff3(written.text); assert(reread.error.len == 0 && reread.features.len == 1);
        for feature in reread.features { assert(bio::gff3_encode(feature.seqid) == seqid); }
    }
    assert(bio::parse_gff3("##gff-version 3\nc\t.\t%43DS\t1\t2\t.\t+\t.\t.").error.len > 0);
    assert(bio::parse_gff3("##gff-version 3\nc\t.\t%43DS\t1\t2\t.\t+\t0\t.").error.len == 0);
    assert(bio::parse_gff3("##gff-version 3\n##sequence-region  1 10").error.len > 0);
    let gw = bio::write_gff3(copy(g)); assert(gw.error.len == 0);
    let again = bio::parse_gff3(gw.text); assert(again.error.len == 0 && again.entries.len == 4);
    assert(bio::write_gff3(copy(again)).text == gw.text);
    for attrs in ["ID=x%","ID=x%GG","ID=a,b","ID=a;ID=b","Parent=a=b"] {
        var t: u8[>..] = []; t.append("##gff-version 3\nc\t.\tgene\t1\t1\t.\t.\t.\t"); t.append(attrs);
        assert(bio::parse_gff3(t).error.len > 0);
    }
    for s in ["##gff-version 2","##gff-version 3 extra","##gff-version 3\n##FASTA\n>c\nA","##gff-version 3\nc\t.\tCDS\t1\t1\t.\t+\t.\t.","##gff-version 3\nc\t.\tgene\t0\t1\t.\t+\t0\t.","##gff-version 3\nc\t.\tgene\t1\t1\tnan\t+\t0\t.","##gff-version 3\nc\t.\tgene\t1\t1\t0\t+\t3\t."] { assert(bio::parse_gff3(s).error.len > 0); }
    assert(bio::parse_gff3("##gff-version 3\nc\t.\tgene\t1\t1\t0\t.\t.\tNote=plain space").error.len == 0);
    assert(bio::parse_gff3("##gff-version 3\n##sequence-region c 1").error.len > 0);
    assert(bio::parse_gff3("##gff-version 3\n##gff-version 3").error.len > 0);
    print("typed genomic format assertions passed");
}
