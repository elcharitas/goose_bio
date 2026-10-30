import hts from "..";
import bio from "..";
import os;

fn main() {
    assert(write_file(".tools/stream.fa", ">first comment\nACGT\nAC\n>protein\nMKG*\n"));
    let h = bio::fastx_open(".tools/stream.fa");
    assert(h > 0);
    var text: u8[>..] = [];
    assert(bio::fastx_field(h, 2, text) == -1);
    assert(bio::fastx_next(h) == 1);
    assert(bio::fastx_field(h, 0, text) == 0 && text == "first");
    var comment: u8[>..] = [];
    assert(bio::fastx_field(h, 1, comment) == 0 && comment == "comment");
    var sequence: u8[>..] = [];
    assert(bio::fastx_field(h, 2, sequence) == 0 && sequence == "ACGTAC");
    assert(bio::fastx_next(h) == 1);
    var protein: u8[>..] = [];
    assert(bio::fastx_field(h, 2, protein) == 0 && protein == "MKG*");
    assert(bio::fastx_next(h) == 0);
    assert(bio::fastx_field(h, 2, protein) == -1);
    assert(bio::fastx_close(h) == 0);
    assert(bio::fastx_close(h) == -1 && bio::fastx_next(h) == -1);
    assert(write_file(".tools/stream.fq", "@read\nAC\nGT\n+\nII\nII\n"));
    let q = bio::fastx_open(".tools/stream.fq");
    assert(q > 0 && bio::fastx_next(q) == 1);
    var quality: u8[>..] = [];
    assert(bio::fastx_field(q, 3, quality) == 0 && quality == "IIII");
    assert(bio::fastx_next(q) == 0 && bio::fastx_close(q) == 0);
    assert(write_file(".tools/bad-stream.fq", "@bad\nACGT\n+\nII\n"));
    let bad = bio::fastx_open(".tools/bad-stream.fq");
    assert(bad > 0 && bio::fastx_next(bad) == -1);
    assert(bio::fastx_next(bad) == -1 && bio::fastx_close(bad) == 0);
    let gzip = bio::fastx_open(".tools/stream.fq.gz");
    assert(gzip > 0 && bio::fastx_next(gzip) == 1);
    assert(bio::fastx_next(gzip) == 0 && bio::fastx_close(gzip) == 0);
    let corrupt = bio::fastx_open(".tools/corrupt-fastx.gz");
    assert(corrupt > 0);
    var status: i32 = 1;
    while status == 1 { status = bio::fastx_next(corrupt); }
    assert(status == -1);
    bio::fastx_close(corrupt);
    assert(bio::fastx_open(".tools/absent-fastx") == 0);
    for path in [
        ".tools/fastx-bad-crc",
        ".tools/fastx-over-limit",
        ".tools/fastx-reject-0",
        ".tools/fastx-reject-1",
        ".tools/fastx-reject-2",
        ".tools/fastx-reject-3",
        ".tools/fastx-reject-4",
        ".tools/fastx-reject-5",
        ".tools/fastx-reject-6",
        ".tools/fastx-reject-7",
        ".tools/fastx-reject-8",
        ".tools/fastx-reject-9",
        ".tools/fastx-reject-10",
        ".tools/fastx-reject-11",
        ".tools/fastx-reject-12",
        ".tools/fastx-reject-13",
        ".tools/fastx-reject-14",
        ".tools/fastx-reject-15",
        ".tools/fastx-reject-16",
        ".tools/fastx-reject-17",
        ".tools/fastx-reject-18",
        ".tools/fastx-reject-19",
        ".tools/fastx-reject-20",
        ".tools/fastx-reject-21",
        ".tools/fastx-reject-22",
        ".tools/fastx-reject-23",
        ".tools/fastx-reject-24",
        ".tools/fastx-reject-gz-0",
        ".tools/fastx-reject-gz-1",
        ".tools/fastx-reject-gz-2",
        ".tools/fastx-reject-gz-3",
        ".tools/fastx-reject-gz-4",
        ".tools/fastx-reject-gz-5",
        ".tools/fastx-reject-gz-6",
        ".tools/fastx-reject-gz-7",
        ".tools/fastx-reject-gz-8",
        ".tools/fastx-reject-gz-9",
        ".tools/fastx-reject-gz-10",
        ".tools/fastx-reject-gz-11",
        ".tools/fastx-reject-gz-12",
        ".tools/fastx-reject-gz-13",
        ".tools/fastx-reject-gz-14",
        ".tools/fastx-reject-gz-15",
        ".tools/fastx-reject-gz-16",
        ".tools/fastx-reject-gz-17",
        ".tools/fastx-reject-gz-18",
        ".tools/fastx-reject-gz-19",
        ".tools/fastx-reject-gz-20",
        ".tools/fastx-reject-gz-21",
        ".tools/fastx-reject-gz-22",
        ".tools/fastx-reject-gz-23",
        ".tools/fastx-reject-gz-24",
    ] {
        let rejected = bio::fastx_open(path);
        assert(rejected > 0);
        var result: i32 = 1;
        while result == 1 { result = bio::fastx_next(rejected); }
        assert(result == -1);
        var invalid: u8[>..] = [];
        assert(bio::fastx_field(rejected, 0, invalid) == -1);
        assert(bio::fastx_next(rejected) == -1);
        assert(bio::fastx_close(rejected) == 0);
    }
    for path in [".tools/fastx-crlf", ".tools/fastx-protein", ".tools/fastx-trailing-gzip"] {
        let accepted = bio::fastx_open(path);
        assert(accepted > 0 && bio::fastx_next(accepted) == 1);
        assert(bio::fastx_next(accepted) == 0);
        assert(bio::fastx_close(accepted) == 0);
        assert(bio::fastx_next(h) == -1);
    }
    let empty = bio::fastx_open(".tools/fastx-empty");
    assert(empty > 0 && bio::fastx_next(empty) == 0);
    assert(bio::fastx_next(empty) == 0 && bio::fastx_close(empty) == 0);
    let long = bio::fastx_open(".tools/fastx-long");
    assert(long > 0 && bio::fastx_next(long) == 1);
    var long_seq: u8[>..] = [];
    assert(bio::fastx_field(long, 2, long_seq) == 0 && long_seq.len == 100000);
    assert(bio::fastx_next(long) == 1 && bio::fastx_next(long) == 0);
    assert(bio::fastx_close(long) == 0);
    assert(bio::translate("ATG").value == "M");
    print("FASTX streaming assertions passed");
}
