// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import math;
import .mmcif;
import .structural_model;
import .structural_hierarchy;

/*
Edits identify original source rows. Returned structures own private copies, including
document cells; write the returned document with write_mmcif. Other categories and
unknown/inapplicable states survive.
*/
struct StructuralCoordinate { row: i64, x: f64, y: f64, z: f64 }
fn structural_finite(x: f64) -> bool { !is_nan(x) && !is_inf(x) }
/*
Invalid rows, duplicate edits, and nonfinite coordinates reject the whole edit and
preserve the input. Updated atom coordinates and authoritative document cells agree.
*/
fn structural_set(h: const StructuralHierarchy&, edits: const StructuralCoordinate[:]) -> HierarchyResult {
    for e, i in edits {
        if e.row < 0 || e.row >= h.structure.atoms.len || !structural_finite(e.x) ||
            !structural_finite(e.y) || !structural_finite(e.z) { return HierarchyResult { copy(h), "invalid coordinate edit" }; }
        for j in 0..i { if edits[j].row == e.row { return HierarchyResult { copy(h), "duplicate coordinate edit" }; } }
    }
    var out = copy(h);
    for e in edits {
        for a, row in out.structure.atoms { if row == e.row { a.x = e.x; a.y = e.y; a.z = e.z; } }
    }
    var items: CifItem[>..] = [];
    for item in h.structure.document.items {
        let x = cif_column(item.tags, "_atom_site.cartn_x");
        let y = cif_column(item.tags, "_atom_site.cartn_y");
        let z = cif_column(item.tags, "_atom_site.cartn_z");
        var values: CifToken[>..] = [];
        for v, i in item.values {
            var text: u8[>..] = copy(v.text);
            var kind = v.kind;
            var quoted = v.quoted;
            if x >= 0 { for e in edits {
                if i == e.row * item.tags.len + x { text = str(e.x); kind = 0; quoted = false; }
                if i == e.row * item.tags.len + y { text = str(e.y); kind = 0; quoted = false; }
                if i == e.row * item.tags.len + z { text = str(e.z); kind = 0; quoted = false; }
            } }
            values.push(CifToken { copy(text), kind, quoted });
        }
        items.push(CifItem { copy(item.tags), copy(values), item.looped });
    }
    HierarchyResult { StructuralHierarchy {
        StructuralModel { CifDocument { copy(h.structure.document.name), copy(items) }, copy(out.structure.atoms), copy(out.structure.residues) },
        copy(h.nodes), copy(h.selected), h.author, copy(h.occupancy), copy(h.alternate_selected) }, "" }
}
/*
Uses coordinate * rotation + translation with a row-major matrix; orthonormality is not
required. Select all alternates explicitly. Invalid nodes, dimensions, selections, or
nonfinite inputs/results leave the input unchanged.
*/
fn structural_transform(h: const StructuralHierarchy&, node: i64, all_alternates: bool,
    rotation: const f64[:], translation: const f64[:]) -> HierarchyResult {
    if node < 0 || node >= h.nodes.len || rotation.len != 9 || translation.len != 3 {
        return HierarchyResult { copy(h), "invalid transform dimensions or node" };
    }
    for x in rotation { if !structural_finite(x) { return HierarchyResult { copy(h), "nonfinite rotation" }; } }
    for x in translation { if !structural_finite(x) { return HierarchyResult { copy(h), "nonfinite translation" }; } }
    var edits: StructuralCoordinate[>..] = [];
    var atoms: const StructuralAtom&[>..] = [];
    for a in h.structure.atoms { atoms.push(a); }
    for row in structural_rows(h, node, all_alternates) {
        let a = atoms[row];
        edits.push(StructuralCoordinate { row,
            a.x*rotation[0]+a.y*rotation[3]+a.z*rotation[6]+translation[0],
            a.x*rotation[1]+a.y*rotation[4]+a.z*rotation[7]+translation[1],
            a.x*rotation[2]+a.y*rotation[5]+a.z*rotation[8]+translation[2] });
    }
    structural_set(h, edits)
}
