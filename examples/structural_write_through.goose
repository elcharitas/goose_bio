import bio from "..";
import bio.structure.structural_model;
import bio.structure.structural_hierarchy;
import bio.structure.structural_mutation;
import bio.structure.mmcif;
fn main() {
    let p = bio::parse_mmcif_structure("data_demo\nloop_\n_atom_site.group_PDB\n_atom_site.label_asym_id\n_atom_site.auth_asym_id\n_atom_site.label_seq_id\n_atom_site.auth_seq_id\n_atom_site.label_comp_id\n_atom_site.label_atom_id\n_atom_site.Cartn_x\n_atom_site.Cartn_y\n_atom_site.Cartn_z\n_atom_site.occupancy\nATOM A AUTHOR 1 42 ALA CA 1 2 3 1\n");
    assert(p.error.len == 0);
    let h = bio::structural_hierarchy(p.structure, true, false, 0.0);
    assert(h.error.len == 0);
    let moved = bio::structural_transform(h.hierarchy, 0, false,
        [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0], [10.0, 0.0, 0.0]);
    assert(moved.error.len == 0);
    let output = bio::write_mmcif(moved.hierarchy.structure.document);
    assert(output.error.len == 0);
    print(output.text);
}
