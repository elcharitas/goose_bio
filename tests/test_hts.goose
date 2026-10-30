import hts from "..";

import bio from "..";
import bio.hts;
fn alignment(path: const u8[..], mode: const u8[..], indexed: bool) {
    let h = bio::hts_open(path, mode, false, "@HD\tVN:1.6\tSO:coordinate\n@SQ\tSN:chr1\tLN:100\n", ".tools/reference.fa");
    assert(h > 0);
    assert(bio::hts_write(h, "r1\t0\tchr1\t5\t60\t4M\t*\t0\t0\tACGT\tIIII\tNM:i:0") == 0);
    assert(bio::hts_close(h) == 0);
    assert(bio::hts_close(h) == -1);
    if indexed { assert(bio::hts_index(path, false) == 0); }
    let r = bio::hts_open(path, "r", false, "", ".tools/reference.fa");
    assert(r > 0);
    if indexed { assert(bio::hts_query(r, "chr1:5-8") == 0); }
    assert(bio::hts_next(r) == 1);
    assert(bio::hts_position(r) == 4);
    assert(bio::hts_mapq(r) == 60);
    assert(bio::hts_flag(r) == 0);
    var text: u8[>..] = [];
    assert(bio::hts_text(r, text) == 0);
    assert(text.len > 0);
    if mode != "wc" {
        assert(text[..] == "r1\t0\tchr1\t5\t60\t4M\t*\t0\t0\tACGT\tIIII\tNM:i:0");
    }
    assert(bio::hts_next(r) == 0);
    assert(bio::hts_position(r) == -1);
    assert(bio::hts_close(r) == 0);
}

fn variant(path: const u8[..], mode: const u8[..], indexed: bool) {
    let header = "##fileformat=VCFv4.3\n##contig=<ID=chr1,length=100>\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tsample\n";
    let line = "chr1\t5\trs1\tA\tC\t42\tPASS\t.\tGT\t0/1";
    let h = bio::hts_open(path, mode, true, header, "");
    assert(h > 0);
    assert(bio::hts_write(h, line) == 0);
    assert(bio::hts_close(h) == 0);
    if indexed { assert(bio::hts_index(path, true) == 0); }
    let r = bio::hts_open(path, "r", true, "", "");
    assert(r > 0);
    if indexed { assert(bio::hts_query(r, "chr1:5-5") == 0); }
    assert(bio::hts_next(r) == 1);
    assert(bio::hts_position(r) == 4);
    var text: u8[>..] = [];
    assert(bio::hts_text(r, text) == 0);
    assert(text[..] == "chr1\t5\trs1\tA\tC\t42\tPASS\t.\tGT\t0/1\n");
    var head: u8[>..] = [];
    assert(bio::hts_header(r, head) == 0);
    assert(head.len > 21);
    assert(head[..21] == "##fileformat=VCFv4.3\n");
    var versions = 0;
    for i in 0..head.len - 12 {
        if head[i..i + 13] == "##fileformat=" { versions += 1; }
    }
    assert(versions == 1);
    assert(bio::hts_next(r) == 0);
    assert(bio::hts_close(r) == 0);
}
fn main() {
    assert(bio::phred_error_probability(0.0) == 1.0);
    assert(bio::hts_bgzf_copy(".tools/large.bgzf", ".tools/large.out", false) == 0);
    assert(bio::hts_bgzf_copy(".tools/empty.bgzf", ".tools/empty.out", false) == 0);
    for path in [".tools/boundary.bgzf", ".tools/partial.bgzf", ".tools/no-eof.bgzf", ".tools/corrupt.bgzf"] {
        assert(bio::hts_bgzf_copy(path, ".tools/rejected.out", false) == -1);
    }
    assert(bio::hts_open(".tools/rejected.cram", "wc", true, "##fileformat=VCFv4.3\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n", ".tools/reference.fa") == 0);
    alignment(".tools/test.sam", "w", false);
    alignment(".tools/test.sam.gz", "wz", false);
    alignment(".tools/test.bam", "wb", true);
    alignment(".tools/test.cram", "wc", true);
    variant(".tools/test.vcf", "w", false);
    variant(".tools/test.bcf", "wb", true);
    variant(".tools/test.vcf.gz", "wz", false);
    var seq: u8[>..] = [];
    assert(bio::hts_fasta_fetch(".tools/reference.fa", "chr1", 4, 8, seq) == 0);
    assert(seq[..] == "ACGT");
    assert(bio::hts_fasta_fetch(".tools/reference.fa", "absent", 0, 4, seq) == -1);
    assert(bio::hts_bgzf_copy("native/fixtures/input.vcf", ".tools/fixture.vcf.gz", true) == 0);
    assert(bio::hts_bgzf_copy(".tools/fixture.vcf.gz", ".tools/inflated.vcf", false) == 0);
    assert(bio::hts_tabix_index(".tools/fixture.vcf.gz") == 0);
    var rows: u8[>..] = [];
    assert(bio::hts_tabix_query(".tools/fixture.vcf.gz", "chr1:5-5", rows) == 0);
    assert(rows[..] == "chr1\t5\trs1\tA\tC\t42\tPASS\t.\tGT\t0/1\n");
    assert(bio::hts_open(".tools/missing.bam", "r", false, "", "") == 0);
    assert(bio::hts_next(0) == -1);
    assert(bio::hts_open(".tools/test.bam", "r", true, "", "") == 0);
    assert(bio::hts_open(".tools/test.bcf", "r", false, "", "") == 0);
    assert(bio::hts_open("https://example.invalid/x", "r", false, "", "") == 0);
    let bad = bio::hts_open(".tools/bad.sam", "w", false, "@SQ\tSN:chr1\tLN:100\n", "");
    assert(bad > 0);
    assert(bio::hts_write(bad, "invalid") == -1);
    assert(bio::hts_close(bad) == 0);
}
