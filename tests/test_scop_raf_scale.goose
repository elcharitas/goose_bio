// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.structure.scop;
import bio.structure.raf;
import std;
fn main() {
    for shape in 3 {
        let count = 100000;
        var des: u8[>..] = []; var hie: u8[>..] = []; var cla: u8[>..] = [];
        hie.append("0\t-\t1");
        if shape == 0 { for i in 2..count + 1 { hie.push(','); hie.append(str(i)); } }
        hie.push('\n');
        for id in 1..count + 1 {
            let leaf = shape == 0 || (shape == 1 && id * 2 > count) || (shape == 2 && id == count);
            des.append(str(id)); des.append(if leaf { "\tpx\ta\td" } else { "\tcl\ta\tn" }); des.append(str(id)); des.append("\tnode\n");
            hie.append(str(id)); hie.push('\t'); hie.append(str(if shape == 0 { 0 } else { if shape == 1 { id / 2 } else { id - 1 } })); hie.push('\t');
            if shape == 0 || leaf { hie.push('-'); } else { hie.append(str(if shape == 1 { id * 2 } else { id + 1 })); if shape == 1 && id * 2 + 1 <= count { hie.push(','); hie.append(str(id * 2 + 1)); } } hie.push('\n');
            if leaf {
                cla.push('d'); cla.append(str(id)); cla.append("\t1abc\t-\ta\t"); cla.append(str(id)); cla.push('\t');
                var path: i64[>..] = []; var cur = id;
                while cur > 0 { path.push(cur); cur = if shape == 0 { 0 } else { if shape == 1 { cur / 2 } else { cur - 1 } }; }
                var k = path.len; while k > 0 { k -= 1; cla.append(if k == 0 { "px=" } else { "cl=" }); cla.append(str(path[k])); if k > 0 { cla.push(','); } } cla.push('\n');
            }
        }
        let g = bio::parse_scop(cla, des, hie); if g.error.len > 0 { print(g.error); } assert(g.error.len == 0 && g.nodes.len == count + 1);
        for id in 1..count + 1 { assert(bio::scop_node(g, id) == id - 1); }
        assert(bio::scop_node(g, -1) == -1 && bio::scop_node(g, count + 1) == -1);
        for d, i in g.domains { assert(bio::scop_sid(g, d.sid) == i); }
        assert(bio::scop_sid(g, "d100000") >= 0 && bio::scop_sid(g, "missing") == -1);
        let ancestors = bio::scop_ancestors(g, count); assert(ancestors.error.len == 0 && ancestors.ids[ancestors.ids.len - 1] == 0);
        assert(ancestors.ids.len == (if shape == 0 { 1 } else { if shape == 1 { 17 } else { count } }));
        let bfs = bio::scop_descendant_domains(g, 0); assert(bfs.error.len == 0 && bfs.ids.len == g.domains.len);
        for id, i in bfs.ids { assert(id == (if shape == 0 { i + 1 } else { if shape == 1 { 50001 + i } else { count } })); }
        let again = bio::parse_scop(bio::scop_write(g, "cla"), bio::scop_write(g, "des"), bio::scop_write(g, "hie")); assert(again.error.len == 0 && again.nodes.len == g.nodes.len);
        print(shape);
    }
    var text: u8[>..] = []; text.append("1abc_ 0.02    260101 111111           ");
    for i in 1000000 { text.append("    1a."); }
    let m = bio::parse_raf(text); assert(m.error.len == 0 && m.residues.len == 1000000);
    let fragments = bio::scop_fragments("-"); let d = bio::ScopDomain { "d", "1abc", "-", "a", 1, [], copy(fragments.items) };
    let maps = [copy(m)]; let selected = bio::raf_select(d, maps); assert(selected.error.len == 0 && selected.atom.len == 1000000 && selected.seqres.len == 1000000);
    for c in selected.atom { assert(c == 'A'); } for c in selected.seqres { assert(c == 'X'); }
    assert(bio::parse_raf(bio::raf_write(m)).residues.len == 1000000);
    print("scale passed");
}
