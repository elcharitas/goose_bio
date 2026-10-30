// Copyright Jonathan Irhodia.
import hts from "..";
import bio from "..";
import bio.hts;
fn main() {
    let source_header = "@HD\tSO:unsorted\n@SQ\tSN:a\tLN:100\n@SQ\tSN:b\tLN:200\n";
    let destination_header = "@HD\tSO:unsorted\n@SQ\tSN:b\tLN:200\n@SQ\tSN:a\tLN:100\n";
    let seed = bio::hts_open(".tools/alignment-seed.bam", "wb", false, source_header, "");
    assert(seed > 0);
    assert(bio::hts_write(seed, "x\t1\ta\t5\t23\t2M\tb\t8\t0\tAC\t*\tZZ:B:i,-1,2") == 0);
    assert(bio::hts_close(seed) == 0);
    let r = bio::hts_open(".tools/alignment-seed.bam", "r", false, "", "");
    let w = bio::hts_open(".tools/alignment-mapped.bam", "wb", false, destination_header, "");
    assert(bio::hts_copy_alignment_mapped(r, w) == -1);
    assert(bio::hts_next(r) == 1);
    var before: u8[>..] = [];
    assert(bio::hts_text(r, before) == 0);
    assert(bio::hts_copy_record(r, w) == -1);
    assert(bio::hts_copy_alignment_mapped(r, w) == 0);
    var after: u8[>..] = [];
    assert(bio::hts_text(r, after) == 0);
    assert(before[..] == after[..]);
    assert(bio::hts_close(w) == 0);
    assert(bio::hts_next(r) == 0);
    assert(bio::hts_copy_alignment_mapped(r, w) == -1);
    assert(bio::hts_close(r) == 0);
    let reopened = bio::hts_open(".tools/alignment-mapped.bam", "r", false, "", "");
    assert(bio::hts_next(reopened) == 1);
    var actual: u8[>..] = [];
    assert(bio::hts_text(reopened, actual) == 0);
    assert(actual[..] == before[..]);
    assert(bio::hts_next(reopened) == 0);
    assert(bio::hts_close(reopened) == 0);
}
