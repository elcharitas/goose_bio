// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.structure.structural_hierarchy;
import bio.structure.structural_mutation;
import bio.structure.structural_model;
import bio.structure.mmcif;
fn main() {
    let header = "data_x\n_other.x ?\n_other.y .\nloop_\n_atom_site.group_PDB\n_atom_site.label_asym_id\n_atom_site.auth_asym_id\n_atom_site.label_seq_id\n_atom_site.auth_seq_id\n_atom_site.label_comp_id\n_atom_site.label_atom_id\n_atom_site.label_alt_id\n_atom_site.Cartn_x\n_atom_site.Cartn_y\n_atom_site.Cartn_z\n_atom_site.occupancy\n";
    let rows = "ATOM L A 1 42 ALA CA A 1 2 3 0.5\nATOM L A 1 42 ALA CA B 4 5 6 0.5\nATOM L A 2 43 SER CA A 7 8 9 0.9\nATOM L A 2 43 CYS CA B 10 11 12 0.1\n";
    let p = bio::parse_mmcif_structure(str(header, rows));
    assert(p.error.len == 0);
    let r = bio::structural_hierarchy(p.structure, true, false, 0.0);
    assert(r.error.len == 0);
    let h = r.hierarchy;
    assert(bio::structural_rows(h, 0, false) == [0, 3]);
    var atom = -1; var residue = -1;
    for n, i in h.nodes {
        if n.kind == 5 && n.rows == [0, 1] { atom = i; }
        if n.kind == 3 && n.rows == [2, 3] { residue = i; }
    }
    let sel = bio::structural_select(h, atom, "B");
    assert(sel.error.len == 0 && bio::structural_rows(sel.hierarchy, 0, false) == [1, 3]);
    let comp = bio::structural_select(h, residue, "SER");
    assert(comp.error.len == 0 && bio::structural_rows(comp.hierarchy, 0, false) == [0, 2]);
    assert(bio::structural_select(h, atom, "Z").error.len > 0);
    assert(bio::structural_select(h, -1, "A").error.len > 0);
    let before = bio::write_mmcif(h.structure.document);
    let bad = bio::structural_set(h, [bio::StructuralCoordinate { 0, 9.0, 9.0, 9.0 }, bio::StructuralCoordinate { 99, 0.0, 0.0, 0.0 }]);
    assert(bad.error.len > 0 && bio::write_mmcif(bad.hierarchy.structure.document).text == before.text);
    assert(bio::structural_set(h, [bio::StructuralCoordinate { 0, 1.0, 2.0, 3.0 }, bio::StructuralCoordinate { 0, 2.0, 3.0, 4.0 }]).error.len > 0);
    let huge = 1.0e308;
    assert(bio::structural_transform(h, 0, true, [huge, huge, huge, huge, huge, huge, huge, huge, huge], [0.0, 0.0, 0.0]).error.len > 0);
    assert(bio::structural_set(h, [bio::StructuralCoordinate { 0, huge * huge, 2.0, 3.0 }]).error.len > 0);
    assert(bio::structural_transform(h, 0, false, [1.0], [0.0, 0.0, 0.0]).error.len > 0);
    let all = bio::structural_transform(h, 0, true, [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0], [1.0, 0.0, 0.0]);
    assert(all.error.len == 0);
    let written = bio::write_mmcif(all.hierarchy.structure.document);
    let again = bio::parse_mmcif_structure(written.text);
    assert(again.error.len == 0);
    for a, i in again.structure.atoms { assert(a.x == 2.0 + i * 3.0); }
    assert(bio::write_mmcif(h.structure.document).text == before.text);
    let missing = bio::parse_mmcif_structure(str(header, "ATOM L A 1 42 ALA CA A 1 2 3 ?\n"));
    assert(bio::structural_hierarchy(missing.structure, true, false, 0.0).error.len > 0);
    assert(bio::structural_hierarchy(missing.structure, true, true, 0.25).error.len == 0);
    let dup = bio::parse_mmcif_structure(str(header, rows, "ATOM L A 1 42 ALA CA A 1 2 3 1\n"));
    assert(bio::structural_hierarchy(dup.structure, true, false, 0.0).error.len > 0);
    let label = bio::structural_hierarchy(p.structure, false, false, 0.0);
    assert(label.error.len == 0);
    for n in label.hierarchy.nodes { if n.kind == 2 { assert(n.id == "L"); } }
    print("structural hierarchy atomic cases: passed");
}
