import hts from "..";
import bio from "..";
import bio.hts;
import os;
fn main() {
    assert(bio::hts_index(".tools/sync-large.vcf.gz", true) == 0);
    assert(bio::hts_index(".tools/sync-late.vcf.gz", true) == 0);
    let s = bio::hts_sync_open(64, "chr1:3000000001-3000000001", 0, 0);
    assert(bio::hts_sync_add(s, ".tools/sync-large.vcf.gz") == 0);
    assert(bio::hts_sync_next(s) == 1);
    assert(bio::hts_sync_position(s, 0) == 3000000000);
    assert(bio::hts_sync_next(s) == 0);
    assert(bio::hts_sync_close(s) == 0);
    let p = bio::hts_pool_open(4);
    let bad = bio::hts_sync_open(64, "", 0, p);
    assert(bio::hts_sync_add(bad, ".tools/sync-no-eof.vcf.gz") == -1);
    assert(bio::hts_sync_add(bad, "https://invalid.test/file.vcf.gz") == -1);
    assert(bio::hts_sync_add(bad, ".tools/missing.vcf.gz") == -1);
    // Replace after indexing; the preceding virtual starts stay fixed.
    var bytes: u8[>..] = [];
    assert(read_file(".tools/sync-late-bad.gz", bytes));
    assert(write_file(".tools/sync-late.vcf.gz", bytes[..]));
    assert(bio::hts_sync_add(bad, ".tools/sync-late.vcf.gz") == 0);
    var status = bio::hts_sync_next(bad);
    var seen = 0;
    while status == 1 {
        seen += 1;
        status = bio::hts_sync_next(bad);
    }
    assert(status == -1 && seen <= 1);
    assert(bio::hts_sync_next(bad) == -1);
    assert(bio::hts_sync_has_line(bad, 0) == -1);
    assert(bio::hts_pool_close(p) == -2);
    assert(bio::hts_sync_close(bad) == 0);
    assert(bio::hts_pool_close(p) == 0);
    assert(bio::hts_index(".tools/sync-corrupt.vcf.gz", true) == 0);
    var corrupt: u8[>..] = [];
    assert(read_file(".tools/sync-corrupt-bad.gz", corrupt));
    assert(write_file(".tools/sync-corrupt.vcf.gz", corrupt[..]));
    let c = bio::hts_sync_open(64, "", 0, 0);
    assert(bio::hts_sync_add(c, ".tools/sync-corrupt.vcf.gz") == 0);
    var result = bio::hts_sync_next(c);
    while result == 1 { result = bio::hts_sync_next(c); }
    assert(result == -1);
    assert(bio::hts_sync_close(c) == 0);
}
