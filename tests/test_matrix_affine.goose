import std;
import bio from "..";
import bio.alignment.substitution;
import bio.alignment.matrix_affine;
fn main() {
    let m = bio::SubstitutionMatrix { "fractional", ["A","B"], [1.5,-2.25,-0.75,0.5], "" };
    let seqs: u8[][] = ["","A","B","AA","AB","BA","BB","AAA","AAB","ABA","ABB","BAA","BAB","BBA","BBB"];
    for mode in 0..2 { for mask in 0..16 { for cost in 0..3 {
        let open = if cost == 0 { 2.5 } else if cost == 1 { 0.0 } else { 0.5 };
        let extend = if cost == 0 { 0.25 } else if cost == 1 { 0.0 } else { 1.25 };
        let o = bio::MatrixAffineOptions { open, extend, mode == 1,
            mask%2 == 1, (mask/2)%2 == 1, (mask/4)%2 == 1, (mask/8)%2 == 1 };
        for a, x in seqs { for b, y in seqs {
            let r = bio::matrix_affine(a,b,m,o);
            assert(r.error.len == 0);
            print(mode," ",mask," ",cost," ",x," ",y," ",r.score," ",r.a_start," ",r.a_end," ",r.b_start," ",r.b_end," ",r.a_aligned,"|",r.b_aligned);
        } }
    } } }
    assert(bio::matrix_affine("?","A",m,bio::matrix_affine_global()).error.len > 0);
    assert(bio::matrix_affine("A","A",m,bio::matrix_affine_global(-1.0)).error.len > 0);
    let bad = bio::SubstitutionMatrix { "bad", ["A","A"], [1.0,1.0,1.0,1.0], "" };
    assert(bio::matrix_affine("A","A",bad,bio::matrix_affine_global()).error.len > 0);
    let shape = bio::SubstitutionMatrix { "bad", ["A"], [], "" };
    assert(bio::matrix_affine("A","A",shape,bio::matrix_affine_global()).error.len > 0);
    let token = bio::SubstitutionMatrix { "bad", ["AA"], [1.0], "" };
    assert(bio::matrix_affine("A","A",token,bio::matrix_affine_global()).error.len > 0);
    let bound = bio::SubstitutionMatrix { "bad", ["A"], [1.0e100], "" };
    assert(bio::matrix_affine("A","A",bound,bio::matrix_affine_global()).error.len > 0);
    assert(bio::matrix_affine("A","A",m,bio::matrix_affine_global(1.0e100)).error.len > 0);
    let clipped = bio::matrix_affine("A","B",m,bio::MatrixAffineOptions { 2.5,0.25,true,false,false,false,false });
    assert(clipped.score == 0.0 && clipped.a_aligned.len == 0 && clipped.a_end == 0 && clipped.b_end == 0);
    assert(bio::matrix_affine("BAAB","AA",m,bio::matrix_affine_fit_b()).score == 3.0);
    assert(bio::matrix_affine("A","B",m,bio::matrix_affine_overlap()).score == 0.0);
    var large: u8[>..] = [];
    for k in 2000 { large.push('A'); }
    assert(bio::matrix_affine(large,large,m,bio::matrix_affine_global()).error.len > 0);
    let huge = bio::SubstitutionMatrix { "huge", ["A"], [-9.0e99], "" };
    assert(bio::matrix_affine("AA","AA",huge,bio::matrix_affine_global(9.0e99,9.0e99)).score == -1.8e100);
}
