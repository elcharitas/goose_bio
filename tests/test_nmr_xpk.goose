// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.io.nmr_xpk;
import math;
fn main() {
    let header = "first \nH N\ndataset\nsw\nsf\nH.L H.P N.L N.P extras\n";
    var text: u8[>..] = []; text.append(header); text.append("  0007\t-1.hn 2 -1.n 10 KEEP  \n8 -1.hn 4 -1.n 14 SECOND\n9 4.hn 8 4.n 30 FINAL\n");
    let r = bio::parse_xpk(text); assert(r.error.len == 0); let p = copy(r.peaklist);
    let pred = bio::predict_xpk_noe(p,"N","H",-1,4,false); assert(pred.found && pred.error.len == 0);
    let expected = "9 4.hn 8 -1.n 12.0 FINAL"; assert(pred.row.raw == expected);
    let back = bio::predict_xpk_noe(p,"N","H",4,-1,false); assert(back.row.raw == "  0007\t-1.hn 2 4.n 30.0 KEEP  ");
    let changed = bio::Xpk { copy(p.headers),copy(p.labels),[copy(pred.row)] };
    let reparsed = bio::parse_xpk(bio::write_xpk(changed)); assert(reparsed.error.len == 0);
    let group = bio::xpk_group(reparsed.peaklist,"H"); assert(group.minimum == 4 && group.maximum == 4);
    assert(bio::xpk_replace(" \t1 AA BB FINAL  ",3,"X") == " \t1 AA BB X  ");
    for number in ["nan","inf","1e309","1e","1x","0x10",".","--1"] { let v,ok = bio::xpk_number(number); assert(!ok); }
    for assignment in ["1","x.hn","1.hn,2.hn","{1.hn}","+.hn"] { let v,ok = bio::xpk_residue(assignment); assert(!ok); }
    let missing = bio::xpk_group(p,"missing"); assert(missing.error.len > 0);
    let one: bio::Xpk[] = [copy(p)]; assert(bio::xpk_table(one,"extras","H",100,2).error.len > 0);
    for row in ["1 1.h 2 1.n nan X", "1 1.h 2 1.n 3 X EXTRA", "1 {1.h 2.h} 1.n 3 X"] {
        var bad: u8[>..] = []; bad.append(header); bad.append(row); assert(bio::parse_xpk(bad).error.len > 0);
    }
    let tiny_values: f64[2] = [5e-324,5e-324];
    let tiny_mean, tiny_ok = bio::xpk_mean(tiny_values); assert(tiny_ok && tiny_mean == 5e-324);
    let large_values: f64[2] = [1e308,1e308];
    let large_mean, large_ok = bio::xpk_mean(large_values); assert(large_ok && large_mean == 1e308);
    let cancelling: f64[3] = [1e308,1.0,-1e308];
    let cancelled, cancel_ok = bio::xpk_mean(cancelling); assert(cancel_ok && abs(cancelled-1.0/3.0) < 1e-15);
    let underflow: f64[2] = [5e-324,0.0];
    let lost, loss_ok = bio::xpk_mean(underflow); assert(!loss_ok);
    var tiny_text: u8[>..] = []; tiny_text.append(header);
    tiny_text.append("1 1.h 0 1.n 5e-324 X\n2 1.h 0 1.n 5e-324 X\n3 2.h 0 2.n 1 X\n");
    let tiny = bio::parse_xpk(tiny_text); assert(tiny.error.len == 0);
    let tiny_prediction = bio::predict_xpk_noe(tiny.peaklist,"N","H",1,2,false);
    assert(tiny_prediction.found && tiny_prediction.error.len == 0);
    for value, i in tiny_prediction.row.fields { if i == 4 { let v, ok = bio::xpk_number(value); assert(ok && v == 5e-324); } }
    let huge = bio::parse_xpk("a\nb\nc\nd\ne\nH.L H.P\n1 -9223372036854775808.h 0\n2 9223372036854775807.h 0\n");
    assert(huge.error.len == 0); let extremes: bio::Xpk[] = [copy(huge.peaklist)]; assert(bio::xpk_table(extremes,"H.P","H",100,100).error.len > 0);
}
