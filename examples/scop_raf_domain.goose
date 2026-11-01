import bio from "..";
import bio.structure.scop;
import bio.structure.raf;
fn main() {
    let g = bio::parse_scop("d1abc_\t1abc\t-\ta\t2\tcl=1,px=2\n", "1\tcl\ta\t-\tclass\n2\tpx\ta\td1abc_\tdomain\n", "0\t-\t1\n1\t0\t2\n2\t1\t-\n");
    if g.error.len > 0 { print(g.error); } assert(g.error.len == 0);
    assert(bio::scop_sid(g, "d1abc_") == 0);
    assert(bio::scop_ancestors(g, 2).ids == [1, 0]);
    assert(bio::scop_descendant_domains(g, 0).ids == [2]);
    let again = bio::parse_scop(bio::scop_write(g, "cla"), bio::scop_write(g, "des"), bio::scop_write(g, "hie")); assert(again.error.len == 0);
    let m = bio::parse_raf("1abc_ 0.02    260101 111111              -2aA   -1.C    1Gg   1AtT    9Vv");
    if m.error.len > 0 { print(m.error); } assert(m.error.len == 0);
    assert(bio::parse_raf(bio::raf_write(m)).residues.len == 5);
    let maps = [copy(m)]; for d in g.domains { let s = bio::raf_select(d, maps); assert(s.error.len == 0 && s.atom == "AXGTV" && s.seqres == "ACGTV"); }
    assert(bio::scop_fragments("A:-2-1A,B:").items.len == 2);
    assert(bio::parse_raf("short").error.len > 0);
}
