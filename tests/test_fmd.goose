// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import std;
import bio from "..";
import bio.search.fmd;
fn main() {
    let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "a", "ACGTN" }, bio::FMDRecord { "b", "AAA" }, bio::FMDRecord { "c", "ACGTN" }];
    let idx = bio::fmd_index(rs, "one", 3);
    assert(idx.error.len == 0);
    let acg = bio::fmd_search(idx, "ACG"); assert(bio::fmd_locate(idx, acg).hits.len == 4);
    let empty = bio::fmd_empty(idx); assert(bio::fmd_locate(idx, empty).boundaries.len == 32);
    assert(bio::fmd_search(idx, "NAAA").size == 0);
    let absent = bio::fmd_search(idx, "CCCCCC");
    assert(absent.size == 0 && bio::fmd_extend(idx, absent, 'A').error.len == 0);
    assert(bio::fmd_search(idx, "$").error.len > 0);
    let other = bio::fmd_index(rs, "two");
    assert(bio::fmd_extend(other, empty, 'A').error.len > 0);
    assert(bio::fmd_index(rs, "x", 0).error.len > 0);
    let bad: bio::FMDRecord[>..] = [bio::FMDRecord { "x", "a" }];
    assert(bio::fmd_index(bad, "x").error.len > 0);
    assert(bio::fmd_smems(idx, "ACGTNAAA").error.len == 0);
    assert(bio::fmd_smems(idx, "ACGTN", 5).matches.len == 1);
    assert(bio::fmd_smems(idx, "ACGTN", 6).matches.len == 0);
    let invalid = bio::FMDState { -1, 0, 1, 1, copy(idx.owner), "" };
    assert(bio::fmd_locate(idx, invalid).error.len > 0);
    let over = bio::FMDState { 0, 0, idx.fm.bwt.len + 1, 1, copy(idx.owner), "" };
    assert(bio::fmd_extend(idx, over, 'A').error.len > 0);
    assert(bio::fmd_smems(idx, "AC", 1, 2).error.len > 0);
    assert(bio::fmd_smems(idx, "AC", 0).error.len > 0);
    assert(bio::fmd_smems(idx, "AN", 2).matches.len == 0);
    let forbidden: bio::FMDRecord[>..] = [bio::FMDRecord { "x", "A$" }];
    let reject = bio::fmd_index(forbidden, "x");
    assert(reject.error.len > 0 && reject.fm.sa.len == 0 && reject.names.len == 0);
    var large: u8[>..] = []; for i in 1000001 { large.push('A'); }
    let too_big: bio::FMDRecord[>..] = [bio::FMDRecord { "large", copy(large) }];
    assert(bio::fmd_index(too_big, "x").error.len > 0);
    var checkpoint: u8[>..] = []; for i in 17000 { checkpoint.push('A'); }
    let many: bio::FMDRecord[>..] = [bio::FMDRecord { "many", copy(checkpoint) }];
    assert(bio::fmd_index(many, "x", 1).error.len > 0);
    var records: bio::FMDRecord[>..] = [];
    for i in 1025 { records.push(bio::FMDRecord { str(i), "A" }); }
    assert(bio::fmd_index(records, "x").error.len > 0);
    var long_query: u8[>..] = []; for i in 129 { long_query.push('A'); }
    let fail = bio::fmd_smems(idx, long_query);
    assert(fail.error.len > 0 && fail.matches.len == 0);
    assert(bio::fmd_search(idx, large).error.len > 0);
    print("FMD focused checks pass");
}
