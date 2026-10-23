namespace bio;
import std;
import math;
import .mmcif;

// Indices retain row order and all alternate sites without selection.
struct StructuralAtom {
    row: i64, model: u8[],
    label_chain: CifToken, author_chain: CifToken,
    label_residue: CifToken, author_residue: CifToken,
    label_component: CifToken, author_component: CifToken,
    label_atom: CifToken, author_atom: CifToken,
    alternate: CifToken, insertion: CifToken,
    hetero: bool, x: f64, y: f64, z: f64
}
struct StructuralGroup {
    model: u8[], label_chain: CifToken, author_chain: CifToken,
    label_residue: CifToken, author_residue: CifToken,
    insertion: CifToken, hetero: bool, atoms: i64[]
}
struct StructuralModel {
    document: CifDocument, atoms: StructuralAtom[], residues: StructuralGroup[]
}
struct StructuralResult { structure: StructuralModel, error: u8[] }

fn cif_same(a: const CifToken&, b: const CifToken&) -> bool {
    a.kind == b.kind && a.text == b.text
}
fn cif_column(tags: const u8[][:], name: const u8[:]) -> i64 {
    for tag, i in tags { if tag == name { return i; } }
    -1
}
fn cif_cell(values: const CifToken&[:], offset: i64, column: i64) -> CifToken {
    if column < 0 { return CifToken { "?", 1, false }; }
    let v = values[offset + column];
    CifToken { copy(v.text), v.kind, v.quoted }
}
/*
Requires one atom_site loop with group_PDB, label_asym_id, label_seq_id, label_comp_id,
label_atom_id, and finite Cartesian coordinates. Model numbers are positive integers; an
absent model column means 1. Other absent optional columns become unknown view tokens.
*/
/*
IDs stay strings. Label chain, atom, and component IDs must be nonempty; at least one
residue namespace must identify each atom. Original tokens remain in the document.
Grouping retains alternates/components and both author/label IDs, model, insertion code,
hetero status, and atom indices.
*/
fn mmcif_structure(doc: const CifDocument&) -> StructuralResult {
    let empty = StructuralModel { CifDocument { "", [] }, [], [] };
    var atoms: StructuralAtom[>..] = [];
    var groups: StructuralGroup[>..] = [];
    var found = false;
    for item in doc.items {
        var atom_category = false;
        for tag in item.tags { if starts_with(tag, "_atom_site.") { atom_category = true; } }
        if !atom_category { continue; }
        if found || !item.looped { return StructuralResult { empty, "atom_site must be one loop" }; }
        found = true;
        for tag in item.tags { if !starts_with(tag, "_atom_site.") { return StructuralResult { empty, "mixed atom_site category" }; } }
        let cx = cif_column(item.tags, "_atom_site.cartn_x");
        let cy = cif_column(item.tags, "_atom_site.cartn_y");
        let cz = cif_column(item.tags, "_atom_site.cartn_z");
        let lc = cif_column(item.tags, "_atom_site.label_asym_id");
        let lr = cif_column(item.tags, "_atom_site.label_seq_id");
        let la = cif_column(item.tags, "_atom_site.label_atom_id");
        let lp = cif_column(item.tags, "_atom_site.label_comp_id");
        let gp = cif_column(item.tags, "_atom_site.group_pdb");
        if cx < 0 || cy < 0 || cz < 0 || lc < 0 || lr < 0 || la < 0 || lp < 0 || gp < 0 {
            return StructuralResult { empty, "required atom_site column absent" };
        }
        if item.tags.len == 0 || item.values.len % item.tags.len != 0 { return StructuralResult { empty, "invalid atom_site dimensions" }; }
        if item.values.len / item.tags.len > 100000 { return StructuralResult { empty, "atom row limit" }; }
        var values: const CifToken&[>..] = [];
        for v in item.values { values.push(v); }
        let mc = cif_column(item.tags, "_atom_site.pdbx_pdb_model_num");
        let ac = cif_column(item.tags, "_atom_site.auth_asym_id");
        let ar = cif_column(item.tags, "_atom_site.auth_seq_id");
        let ap = cif_column(item.tags, "_atom_site.auth_comp_id");
        let aa = cif_column(item.tags, "_atom_site.auth_atom_id");
        let alt = cif_column(item.tags, "_atom_site.label_alt_id");
        let ins = cif_column(item.tags, "_atom_site.pdbx_pdb_ins_code");
        var offset = 0;
        while offset < item.values.len {
            let tx = cif_cell(values, offset, cx);
            let ty = cif_cell(values, offset, cy);
            let tz = cif_cell(values, offset, cz);
            let x, ox = parse_flt(tx.text); let y, oy = parse_flt(ty.text); let z, oz = parse_flt(tz.text);
            if tx.kind != 0 || ty.kind != 0 || tz.kind != 0 || !ox || !oy || !oz ||
                is_nan(x) || is_nan(y) || is_nan(z) || is_inf(x) || is_inf(y) || is_inf(z) {
                return StructuralResult { empty, "invalid atom_site coordinate" };
            }
            let group = cif_cell(values, offset, gp);
            if group.text != "ATOM" && group.text != "HETATM" { return StructuralResult { empty, "invalid atom_site group" }; }
            let mt = cif_cell(values, offset, mc);
            var mb: u8[>..] = [];
            if mc < 0 { mb.append("1"); } else { mb.append(mt.text); }
            let model = copy(mb);
            let mn, mok = parse_int(model);
            if !mok || mn < 1 || (mc >= 0 && mt.kind != 0) { return StructuralResult { empty, "invalid atom_site model" }; }
            let a = StructuralAtom {
                offset / item.tags.len, copy(model),
                cif_cell(values, offset, lc),
                cif_cell(values, offset, ac),
                cif_cell(values, offset, lr),
                cif_cell(values, offset, ar),
                cif_cell(values, offset, lp),
                cif_cell(values, offset, ap),
                cif_cell(values, offset, la),
                cif_cell(values, offset, aa),
                cif_cell(values, offset, alt),
                cif_cell(values, offset, ins),
                group.text == "HETATM", x, y, z
            };
            if a.label_chain.kind != 0 || a.label_chain.text.len == 0 || a.label_atom.kind != 0 || a.label_atom.text.len == 0 ||
                a.label_component.kind != 0 || a.label_component.text.len == 0 ||
                ((a.label_residue.kind != 0 || a.label_residue.text.len == 0) &&
                 (a.author_residue.kind != 0 || a.author_residue.text.len == 0)) {
                return StructuralResult { empty, "insufficient atom_site identity for residue grouping" };
            }
            atoms.push(copy(a)); offset += item.tags.len;
        }
    }
    if !found { return StructuralResult { empty, "atom_site loop absent" }; }
    for a, ai in atoms {
        var seen = false;
        for g in groups {
            if structural_key(a, g) { seen = true; break; }
        }
        if seen { continue; }
        let key = StructuralGroup { copy(a.model), copy(a.label_chain), copy(a.author_chain),
            copy(a.label_residue), copy(a.author_residue), copy(a.insertion), a.hetero, [] };
        var ids: i64[>..] = [];
        for b, bi in atoms { if structural_key(b, key) { ids.push(bi); } }
        groups.push(StructuralGroup { copy(key.model), copy(key.label_chain), copy(key.author_chain),
            copy(key.label_residue), copy(key.author_residue), copy(key.insertion), key.hetero, copy(ids) });
    }
    StructuralResult { StructuralModel { copy(doc), copy(atoms), copy(groups) }, "" }
}
/*
The flat atom view and grouped residue index retain the source document. Filter groups
by model and chain. Coordinates are a read view: serialize edits through document cells.
Occupancy, B factors, element, charge, and extra columns remain opaque tokens without
typed validation or PDB conversion.
*/
fn parse_mmcif_structure(text: const u8[:]) -> StructuralResult {
    let result = parse_mmcif(text);
    if result.error.len > 0 {
        return StructuralResult { StructuralModel { CifDocument { "", [] }, [], [] }, copy(result.error) };
    }
    mmcif_structure(result.document)
}

fn structural_key(a: const StructuralAtom&, g: const StructuralGroup&) -> bool {
    a.model == g.model && cif_same(a.label_chain, g.label_chain) &&
    cif_same(a.author_chain, g.author_chain) && cif_same(a.label_residue, g.label_residue) &&
    cif_same(a.author_residue, g.author_residue) && cif_same(a.insertion, g.insertion) && a.hetero == g.hetero
}
