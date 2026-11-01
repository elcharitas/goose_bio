import bio from "..";
import bio.structure.structural_model;
import bio.structure.mmcif;
fn main() {
    let header = "data_demo\n_entry.id demo\nloop_\n_atom_site.group_PDB\n_atom_site.id\n_atom_site.label_asym_id\n_atom_site.auth_asym_id\n_atom_site.label_seq_id\n_atom_site.auth_seq_id\n_atom_site.label_comp_id\n_atom_site.auth_comp_id\n_atom_site.label_atom_id\n_atom_site.auth_atom_id\n_atom_site.label_alt_id\n_atom_site.pdbx_PDB_ins_code\n_atom_site.pdbx_PDB_model_num\n_atom_site.Cartn_x\n_atom_site.Cartn_y\n_atom_site.Cartn_z\n_atom_site.occupancy\n";
    let rows = "ATOM 1 LONG ZZ 1 42 ALA ALA CA C1 A I 1 1 2 3 0.5\nATOM 2 LONG ZZ 1 42 ALA ALA CA C1 B I 1 4 6 3 0.5\nHETATM 3 WATER ZZ . 43 HOH HOH O O . ? 1 0 0 0 1\nATOM 4 LONG ZZ 1 42 ALA ALA CA C1 . I 2 9 8 7 1\n";
    let r = bio::parse_mmcif_structure(str(header, rows));
    assert(r.error.len == 0 && r.structure.atoms.len == 4 && r.structure.residues.len == 3);
    for g, i in r.structure.residues {
        if i == 0 { assert(g.atoms.len == 2 && g.model == "1"); }
    }
    for a, i in r.structure.atoms {
        if i == 0 { assert(a.label_chain.text == "LONG" && a.author_chain.text == "ZZ");
            assert(a.author_residue.text == "42" && a.insertion.text == "I" && a.x == 1.0); }
        if i == 2 { assert(a.hetero && a.label_residue.kind == 2); }
        if i == 3 { assert(a.model == "2" && a.z == 7.0); }
    }
    let w = bio::write_mmcif(r.structure.document);
    assert(w.error.len == 0);
    let q = bio::parse_mmcif_structure(w.text);
    assert(q.error.len == 0 && q.structure.atoms.len == 4 && q.structure.residues.len == 3);
    assert(bio::parse_mmcif_structure(str(header, "ATOM 1 A A 1 1 ALA ALA CA CA . ? 1 ? 0 0 1\n")).error.len > 0);
    for row in [
        "ATOM 1 A ? '' ? ALA ? CA ? . ? 1 0 0 0 1\n",
        "ATOM 1 A ? ? '' ALA ? CA ? . ? 1 0 0 0 1\n",
        "ATOM 1 A ? 1 ? '' ? CA ? . ? 1 0 0 0 1\n",
        "ATOM 1 A ? 1 ? ALA ? '' ? . ? 1 0 0 0 1\n",
        "ATOM 1 '' ? 1 ? ALA ? CA ? . ? 1 0 0 0 1\n",
    ] { assert(bio::parse_mmcif_structure(str(header, row)).error.len > 0); }
    let fallback = bio::parse_mmcif_structure(str(header,
        "ATOM 1 A ? '' 1 ALA ? CA ? . ? 1 0 0 0 1\n",
        "ATOM 2 A ? '' 2 ALA ? CA ? . ? 1 0 0 0 1\n"));
    assert(fallback.error.len == 0 && fallback.structure.residues.len == 2);
    for a in fallback.structure.atoms { assert(a.label_residue.text == "" && a.label_residue.kind == 0); }
    let missing = "data_x\nloop_\n_atom_site.group_PDB\n_atom_site.label_asym_id\n_atom_site.label_seq_id\n_atom_site.label_comp_id\n_atom_site.label_atom_id\n_atom_site.Cartn_x\n_atom_site.Cartn_y\n_atom_site.Cartn_z\n";
    assert(bio::parse_mmcif_structure(str(missing, "ATOM A '' ALA CA 0 0 0\n")).error.len > 0);
    assert(bio::parse_mmcif_structure(str(missing, "ATOM A 1 ALA CA 0 0 0\n")).error.len == 0);
    print("structural model: passed");
}
