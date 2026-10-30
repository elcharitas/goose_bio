import hts from "..";
import bio from "..";
import bio.hts;
import os;
fn text(h: i64) -> u8[..] {
    var out: u8[>..] = [];
    assert(bio::hts_text(h, out) == 0);
    return out[..];
}
fn record(i: i64) -> u8[..] {
    if i == 0 { return "c\t1\t.\tA\tC,G\t.\tPASS\tAC=1,2;AN=4;AF=0.25,0.5;X=old\tGT:PL\t2:0,1,2\t1|2:0,1,2,3,4,5"; }
    if i == 1 { return "c\t1\t.\tA\tC,G\t.\tPASS\tX=old\tGT:PL\t2:0,1\t1|2:0,1,2,3,4,5"; }
    if i == 2 { return "c\t1\t.\tA\t<DEL>,G\t.\tPASS\tX=old\tGT\t2\t1|2"; }
    if i == 3 { return "c\t1\t.\tA\tC,G\t.\tPASS\tX=old\tPL\t0,1,2\t0,1,2"; }
    if i == 4 { return "c\t1\t.\tA\tC,G\t.\tPASS\tX=old\tGT:PL\t.:.\t.|2:.,1,2,3,4,5"; }
    return "";
}
fn main() {
    let header = "##fileformat=VCFv4.3\n##contig=<ID=c,length=100>\n##INFO=<ID=AC,Number=A,Type=Integer,Description=\"a\">\n##INFO=<ID=AN,Number=1,Type=Integer,Description=\"a\">\n##INFO=<ID=AF,Number=A,Type=Float,Description=\"a\">\n##INFO=<ID=X,Number=1,Type=String,Description=\"x\">\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"g\">\n##FORMAT=<ID=PL,Number=G,Type=Integer,Description=\"g\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\ta\tb\n";
    let destination = "##fileformat=VCFv4.3\n##contig=<ID=unused>\n##contig=<ID=c,length=100>\n##FORMAT=<ID=PL,Number=G,Type=Integer,Description=\"g\">\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"g\">\n##INFO=<ID=X,Number=1,Type=String,Description=\"x\">\n##INFO=<ID=AF,Number=A,Type=Float,Description=\"a\">\n##INFO=<ID=AN,Number=1,Type=Integer,Description=\"a\">\n##INFO=<ID=AC,Number=A,Type=Integer,Description=\"a\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tb\ta\n";
    let keep: i32[..] = [0,2];
    let duplicate: i32[..] = [0,2,2];
    let refchange: i32[..] = [2,0];
    for i in 0 .. 5 {
        let w = bio::hts_open(".tools/allele-focused-source.bcf", "wb", true, header, "");
        assert(bio::hts_write(w, record(i)) == 0 && bio::hts_close(w) == 0);
        let r = bio::hts_open(".tools/allele-focused-source.bcf", "r", true, "", "");
        assert(bio::hts_next(r) == 1);
        let before = text(r);
        let out = bio::hts_open(".tools/allele-focused-out.bcf", "wb", true, destination, "");
        assert(bio::hts_copy_variant_alleles(r, out, duplicate, 1, 0, 0, false) == -1);
        assert(bio::hts_copy_variant_alleles(r, out, refchange, 1, 0, 0, false) == -1);
        assert(bio::hts_copy_variant_alleles(r, out, keep, 1, 2, 0, false) == -1);
        if i == 0 {
            assert(bio::hts_copy_variant_alleles(r, out, keep, 0, 0, 0, false) == -1);
            assert(bio::hts_copy_variant_alleles(r, out, keep, 1, 1, 0, true) == 0);
        } else if i == 4 {
            assert(bio::hts_copy_variant_alleles(r, out, keep, 1, 0, 0, false) == 0);
        } else {
            assert(bio::hts_copy_variant_alleles(r, out, keep, 1, 0, 0, false) == -1);
        }
        assert(text(r) == before);
        assert(bio::hts_close(out) == 0 && bio::hts_close(r) == 0);
        let rr = bio::hts_open(".tools/allele-focused-out.bcf", "r", true, "", "");
        if i == 0 {
            assert(bio::hts_next(rr) == 1);
            assert(bio::bcf_int(rr, "AC", false, 0) == 2);
            assert(bio::bcf_int(rr, "AN", false, 0) == 2);
            assert(bio::bcf_int(rr, "GT", true, 0) == 0);
            assert(bio::bcf_int(rr, "GT", true, 1) == 5);
            assert(bio::bcf_int(rr, "GT", true, 2) == 4);
            assert(bio::bcf_int(rr, "GT", true, 3) == -2147483647);
            assert(bio::bcf_int(rr, "PL", true, 0) == 0);
            assert(bio::bcf_int(rr, "PL", true, 1) == 3);
            assert(bio::bcf_int(rr, "PL", true, 2) == 5);
        } else if i == 4 { assert(bio::hts_next(rr) == 1); }
        assert(bio::hts_next(rr) == 0 && bio::hts_close(rr) == 0);
    }
    let selected_header = "##fileformat=VCFv4.3\n##contig=<ID=c,length=100>\n##INFO=<ID=AC,Number=A,Type=Integer,Description=\"a\">\n##INFO=<ID=AN,Number=1,Type=Integer,Description=\"a\">\n##INFO=<ID=AF,Number=A,Type=Float,Description=\"a\">\n##FORMAT=<ID=PL,Number=G,Type=Integer,Description=\"g\">\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"g\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tb\n";
    for mode in ["w", "wb"] {
        let source_writer = bio::hts_open(".tools/allele-subset-source.bcf", "wb", true, header, "");
        assert(bio::hts_write(source_writer, record(0)) == 0 && bio::hts_close(source_writer) == 0);
        let source = bio::hts_open(".tools/allele-subset-source.bcf", "r", true, "", "");
        assert(bio::hts_next(source) == 1); let original = text(source);
        let output = bio::hts_open(".tools/allele-subset-out", mode, true, selected_header, "");
        assert(bio::hts_copy_variant_alleles(source, output, keep, 1, 1, 0, true) == 0);
        assert(text(source) == original && bio::hts_close(source) == 0 && bio::hts_close(output) == 0);
        let reopened = bio::hts_open(".tools/allele-subset-out", "r", true, "", "");
        assert(bio::hts_next(reopened) == 1);
        assert(bio::bcf_int(reopened, "AC", false, 0) == 1 && bio::bcf_int(reopened, "AN", false, 0) == 1);
        assert(bio::bcf_float_bits(reopened, "AF", false, 0) == 1065353216);
        assert(bio::bcf_int(reopened, "GT", true, 0) == 0 && bio::bcf_int(reopened, "GT", true, 1) == 5);
        assert(bio::hts_next(reopened) == 0 && bio::hts_close(reopened) == 0);
    }
    let no_gt = "##fileformat=VCFv4.3\n##contig=<ID=c>\n##INFO=<ID=G,Number=G,Type=Integer,Description=\"g\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n";
    let nw = bio::hts_open(".tools/allele-nogt.bcf", "wb", true, no_gt, "");
    assert(bio::hts_write(nw, "c\t1\t.\tA\tC,G\t.\tPASS\tG=0,1,2,3,4,5") == 0);
    assert(bio::hts_close(nw) == 0);
    let nr = bio::hts_open(".tools/allele-nogt.bcf", "r", true, "", "");
    assert(bio::hts_next(nr) == 1);
    let no = bio::hts_open(".tools/allele-nogt-out.bcf", "wb", true, no_gt, "");
    assert(bio::hts_copy_variant_alleles(nr, no, keep, 1, 0, 0, false) == -1);
    assert(bio::hts_copy_variant_alleles(nr, no, keep, 1, 0, 2, false) == 0);
    assert(bio::hts_close(nr) == 0 && bio::hts_close(no) == 0);
}
