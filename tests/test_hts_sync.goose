import hts from "..";
import bio from "..";

import bio.hts;
import os;
fn run(threads: i32) {
    let pool = bio::hts_pool_open(threads);
    assert(pool != 0);
    let a = "##fileformat=VCFv4.3\n##contig=<ID=chr1,length=5000000000>\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"GT\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tA\n";
    let b = "##fileformat=VCFv4.3\n##contig=<ID=unused,length=10>\n##contig=<ID=chr1,length=5000000000>\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"GT\">\n#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tB\n";
    let w = bio::hts_open(".tools/sync-a.bcf", "wb", true, a, "");
    let x = bio::hts_open(".tools/sync-b.vcf.gz", "wz", true, b, "");
    assert(w > 0 && x > 0);
    assert(bio::hts_pool_attach(w, pool) == 0);
    assert(bio::hts_pool_attach(x, pool) == 0);
    assert(bio::hts_pool_attach(w, pool) == -1);
    assert(bio::hts_pool_close(pool) == -2);
    assert(bio::hts_write(w, "chr1\t10\t.\tA\tC\t.\tPASS\t.\tGT\t0|1") == 0);
    assert(bio::hts_write(w, "chr1\t10\t.\tA\tG\t.\tPASS\t.\tGT\t1/1") == 0);
    assert(bio::hts_write(w, "chr1\t20\t.\tA\tT\t.\tPASS\t.\tGT\t0/1") == 0);
    assert(bio::hts_write(x, "chr1\t10\t.\tA\tG\t.\tPASS\t.\tGT\t1") == 0);
    assert(bio::hts_write(x, "chr1\t30\t.\tA\tC\t.\tPASS\t.\tGT\t.") == 0);
    assert(bio::hts_close(w) == 0 && bio::hts_close(x) == 0);
    assert(bio::hts_index(".tools/sync-a.bcf", true) == 0);
    assert(bio::hts_tabix_index(".tools/sync-b.vcf.gz") == 0);
    let s = bio::hts_sync_open(64, "", 0, pool);
    assert(s != 0);
    assert(bio::hts_sync_add(s, ".tools/sync-a.bcf") == 0);
    assert(bio::hts_sync_add(s, ".tools/sync-b.vcf.gz") == 1);
    var h: u8[>..] = [];
    assert(bio::hts_sync_text(s, 1, true, h) == 0);
    let own = bio::hts_open(".tools/sync-b.vcf.gz", "r", true, "", "");
    assert(bio::hts_pool_attach(own, pool) == 0);
    var expected: u8[>..] = [];
    assert(bio::hts_header(own, expected) == 0);
    assert(h[..] == expected[..]);
    assert(bio::hts_next(own) == 1);
    assert(bio::hts_pool_attach(own, pool) == -1);
    assert(bio::hts_close(own) == 0);
    var count = 0; var both = 0;
    while bio::hts_sync_next(s) == 1 {
        count += 1;
        if bio::hts_sync_has_line(s, 0) == 1 && bio::hts_sync_has_line(s, 1) == 1 {
            both += 1;
            assert(bio::hts_sync_position(s, 0) == 9);
            var t: u8[>..] = [];
            assert(bio::hts_sync_text(s, 1, false, t) == 0);
            assert(t[..] == "chr1\t10\t.\tA\tG\t.\tPASS\t.\tGT\t1\n");
        }
    }
    assert(count == 4 && both == 1);
    assert(bio::hts_sync_next(s) == 0);
    assert(bio::hts_sync_has_line(s, 0) == 0);
    assert(bio::hts_sync_position(s, 0) == -1);
    assert(bio::hts_sync_add(s, ".tools/sync-a.bcf") == -1);
    assert(bio::hts_pool_close(pool) == -2);
    assert(bio::hts_sync_close(s) == 0);
    assert(bio::hts_sync_next(s) == -1);
    let r = bio::hts_sync_open(4, "chr1:10-10", 0, pool);
    assert(bio::hts_sync_add(r, ".tools/sync-a.bcf") == 0);
    assert(bio::hts_sync_add(r, ".tools/sync-b.vcf.gz") == 1);
    assert(bio::hts_sync_next(r) == 1);
    assert(bio::hts_sync_has_line(r, 0) == 1 && bio::hts_sync_has_line(r, 1) == 1);
    assert(bio::hts_sync_close(r) == 0);
    let bw = bio::bgzf_open(".tools/pool.bgzf", true);
    assert(bio::bgzf_pool_attach(bw, pool) == 0);
    var raw: u8[>..] = [];
    assert(read_file(".tools/large.raw", raw));
    assert(bio::bgzf_write(bw, raw[..]) == 0);
    assert(bio::hts_pool_close(pool) == -2);
    assert(bio::bgzf_close(bw) == 0);
    let br = bio::bgzf_open(".tools/pool.bgzf", false);
    assert(bio::bgzf_pool_attach(br, pool) == 0);
    var out: u8[>..] = [];
    assert(bio::bgzf_read(br, 300000, out) == 200000);
    assert(out[..] == raw[..]);
    assert(bio::bgzf_read(br, 1, out) == 0);
    assert(bio::bgzf_close(br) == 0);
    assert(bio::hts_pool_attach(s, pool) == -1);
    assert(bio::hts_sync_close(pool) == -1);
    assert(bio::hts_pool_close(pool) == 0);
    assert(bio::hts_pool_close(pool) == -1);
}
fn main() {
    run(1); run(2); run(4);
    assert(bio::hts_pool_open(0) == 0);
    assert(bio::hts_sync_open(0, "", 0, 0) == 0);
    assert(bio::hts_sync_open(64, "", 3, 0) == 0);
    var i = 0;
    while i < 100 {
        i += 1;
        let p = bio::hts_pool_open(2);
        let s = bio::hts_sync_open(64, "chr1:20-20", 0, p);
        assert(bio::hts_sync_add(s, ".tools/sync-a.bcf") == 0);
        assert(bio::hts_sync_next(s) == 1);
        assert(bio::hts_sync_position(s, 0) == 19);
        assert(bio::hts_sync_close(s) == 0);
        assert(bio::hts_pool_close(p) == 0);
    }
}
