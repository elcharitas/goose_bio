import std;
import bio from "..";
import bio.sequence.analysis;
fn main() {
    let orfs = bio::find_orfs("ATGATGAAATAA",1,false);
    assert(orfs.error.len == 0 && orfs.values.len == 2);
    for o, i in orfs.values {
        assert(o.start == i*3 && o.end == 12);
        assert(o.protein == (if i == 0 { "MMK" } else { "MK" }));
    }
    let rev = bio::find_orfs("TTATTTCAT",1,true);
    assert(rev.error.len == 0 && rev.values.len == 1);
    for o in rev.values {
        assert(o.start == 0 && o.end == 9 && o.strand == -1);
        assert(o.frame == 0 && o.protein == "MK");
    }
    let shifted = bio::find_orfs("AATGAAATAAC",1,false);
    assert(shifted.values.len == 1);
    for o in shifted.values { assert(o.start == 1 && o.end == 10 && o.frame == 1); }
    assert(bio::find_orfs("ATGAAA",1,false).values.len == 0);
    assert(bio::find_orfs("ATGNNNTAA").error.len > 0);
    assert(bio::find_orfs("",28).error.len > 0);
    assert(bio::find_orfs("").values.len == 0);
    let alt = bio::find_orfs("GTGAAATAA",11,false);
    assert(alt.values.len == 1);
    for o in alt.values { assert(o.protein == "MK"); }
    let sites = bio::restriction_sites("AAGAATTCTTGAATTC", "GAATTC",1,5);
    assert(sites.error.len == 0 && sites.sites.len == 2);
    assert(sites.sites[0].start == 2 && sites.sites[0].top_cut == 3);
    assert(sites.sites[0].bottom_cut == 7 && sites.sites[1].top_cut == 11);
    let digest = bio::restriction_digest("AAGAATTCTTGAATTC", "GAATTC",1,5);
    assert(digest.error.len == 0 && digest.fragments.len == 3);
    for fragment, i in digest.fragments {
        assert(fragment == (if i == 0 { "AAG" } else if i == 1 { "AATTCTTG" } else { "AATTC" }));
    }
    let degenerate = bio::restriction_sites("AACAGTT", "ACN",1,2);
    assert(degenerate.error.len == 0 && degenerate.sites.len == 2);
    assert(degenerate.sites[0].start == 1 && degenerate.sites[0].strand == 1);
    assert(degenerate.sites[1].start == 3 && degenerate.sites[1].strand == -1);
    assert(degenerate.sites[1].top_cut == 4 && degenerate.sites[1].bottom_cut == 5);
    assert(bio::restriction_sites("AAAA", "AA",0,0).sites.len == 3);
    assert(bio::restriction_sites("A", "AAA",0,0).sites.len == 0);
    assert(bio::restriction_sites("A", "",0,0).error.len > 0);
    assert(bio::restriction_sites("N", "N",0,0).error.len > 0);
    assert(bio::restriction_sites("AC", "AC",-1,0).error.len > 0);
    let uncut = bio::restriction_digest("AC", "GG",0,0);
    assert(uncut.fragments.len == 1);
    for f in uncut.fragments { assert(f == "AC"); }
    assert(bio::restriction_digest("", "AC",0,0).fragments.len == 0);
    print("analysis assertions passed");
}
