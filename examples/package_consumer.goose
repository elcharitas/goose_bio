import bio from "../goose_bio";
import math;
fn main() {
    assert(bio::reverse_complement("ACGTAA").value == "TTACGT");
    assert(bio::translate("ATGTTTTAA").value == "MF*");
    let feature = bio::AnnotatedFeature { "CDS", [
        bio::LocationPart { 0, 2, 1, false },
        bio::LocationPart { 4, 6, -1, false }
    ], [] };
    assert(bio::extract_feature("ACGTAGTC",copy(feature)).value == "ACCT");
    let matrix = bio::SubstitutionMatrix { "tiny", ["A","B"], [2.0,-1.0,-1.0,2.0], "" };
    let aligned = bio::matrix_affine("AB","AB",matrix,bio::matrix_affine_global());
    assert(aligned.error.len == 0 && aligned.score == 4.0);
    assert(aligned.a_aligned == "AB" && aligned.b_aligned == "AB");
    let fm = bio::fm_index("banana");
    let hits = bio::fm_locate(fm,"ana");
    assert(hits.error.len == 0 && hits.positions.len == 2);
    assert(hits.positions[0] == 3 && hits.positions[1] == 1);
    let records: bio::FMDRecord[>..] = [bio::FMDRecord { "read1","ATTCGGGG" }];
    let index = bio::fmd_index(records,"relocated");
    let state = bio::fmd_search(index,"GAAT");
    let locations = bio::fmd_locate(index,state);
    assert(locations.error.len == 0 && locations.hits.len == 1);
    for hit in locations.hits { assert(hit.record == 0 && hit.reverse && hit.start == 0 && hit.end == 4); }
    let obs: i64[1] = [0];
    let initial: f64[2] = [log(0.6),log(0.4)];
    let transition: f64[4] = [0.0,0.0,0.0,0.0];
    let emission: f64[4] = [log(0.5),log(0.5),log(0.1),log(0.9)];
    let result = bio::hmm_viterbi_log(obs,initial,transition,emission,2);
    assert(result.states.len == 1 && result.states[0] == 0);
    assert(abs(exp(result.log_probability)-0.3) < 1e-12);
    print("relocated consumer semantics passed");
}
