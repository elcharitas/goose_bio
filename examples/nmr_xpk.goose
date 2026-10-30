import std;
import bio from "..";
import bio.io.nmr_xpk;
fn main() {
    let parsed = bio::parse_xpk("label dataset sw sf\nH N\nexample\n10 20\n600 60\nH.L H.P N.L N.P vol\n1 1.hn 7 1.n 110 0\n2 2.hn 8 2.n 120 4\n");
    assert(parsed.error.len == 0);
    let predicted = bio::predict_xpk_noe(parsed.peaklist,"N","H",1,2,false);
    assert(predicted.error.len == 0 && predicted.found);
    assert(predicted.row.raw == "2 2.hn 8 1.n 110.0 4");
}
