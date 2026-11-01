import std;
import bio from "..";
import bio.search.fmd;
fn main() {
    let records: bio::FMDRecord[>..] = [bio::FMDRecord { "read1", "ATTCGGGG" }, bio::FMDRecord { "read2", "NNACGT" }];
    let index = bio::fmd_index(records, "example-collection");
    assert(index.error.len == 0);
    let state = bio::fmd_search(index, "GAAT");
    let locations = bio::fmd_locate(index, state);
    assert(locations.error.len == 0 && locations.hits.len == 1);
    for hit in locations.hits { assert(hit.record == 0 && hit.reverse && hit.start == 0 && hit.end == 4); }
    let matches = bio::fmd_smems(index, "ATTGGGG", 3);
    assert(matches.error.len == 0 && matches.matches.len == 2);
    for m in matches.matches { print(m.start); print(m.end); }
}
