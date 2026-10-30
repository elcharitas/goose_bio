import std;
import bio from "..";
import bio.alignment.frameshift;
fn main() {
    let r = bio::frameshift_alignment("MLGSNESRVCPKLSPS",
        "ATGCTGGGCTCGAACGAGTCCGTGTATGCCCTAAGCTGAGCCCGTCG");
    assert(r.complete && r.score == 13.0);
    print("score: ",r.score," interval: ",r.nt_start,"..",r.nt_end);
    for p,k in r.protein_coordinates { print(p," ",r.nucleotide_coordinates[k]); }
}
