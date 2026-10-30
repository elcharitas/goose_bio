// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import std;
import bio from "../../..";
import bio.search.fmd;
fn main() {
 var s: u8[>..] = []; for i in 1000000 { s.push('A'); }
 let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "million",copy(s) }];
 let idx = bio::fmd_index(rs,"benchmark");
 assert(idx.error.len == 0 && idx.fm.sa.len == 2000002);
 let q = bio::fmd_search(idx,"AAAA"); assert(q.error.len == 0 && q.size == 999997);
 print("million-base construction pass");
}
