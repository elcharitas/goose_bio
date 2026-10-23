// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import math;
import .structural_model;
import .mmcif;

// Node IDs are stable indices; atom IDs are authoritative source rows.
/*
Kinds: structure 0, model 1, chain 2, residue 3, component 4, atom 5. Node
indices/source rows stay stable across selection and coordinate edits; children follow
first appearance. Models use zero-based occurrence order; every serial change starts a
model, even serial reentry.
*/
struct StructuralNode { parent: i64, kind: i64, id: u8[], rows: i64[] }
/*
Source retains author/label IDs, serials, components, insertion/alternate tokens, hetero
flags, and rows. Residue keys include hetero/insertion; unknown/inapplicable insertion
both group as absent while document token states survive. Water uses W; other hetero
classes include component.
*/
/*
Requires parser-built structs; arbitrary hand-built/altered values are not validated.
Construction uses quadratic scans/copies and mutation scans per edit. The safety cap is
not a maximum-input performance guarantee; allocation uses runtime checks, without a new
dependency.
*/
struct StructuralHierarchy {
    structure: StructuralModel, nodes: StructuralNode[], selected: bool[],
    author: bool, occupancy: f64[], alternate_selected: bool[]
}
struct HierarchyResult { hierarchy: StructuralHierarchy, error: u8[] }
fn hierarchy_empty() -> StructuralHierarchy {
    StructuralHierarchy { StructuralModel { CifDocument { "", [] }, [], [] }, [], [], false, [], [] }
}
fn hierarchy_token(t: const CifToken&) -> u8[] {
    str(t.kind, ":", t.text.len, ":", t.text)
}
fn hierarchy_node(nodes: StructuralNode[>..]&, parent: i64, kind: i64, id: u8[:]) -> i64 {
    for n, i in nodes { if n.parent == parent && n.kind == kind && n.id == id { return i; } }
    nodes.push(StructuralNode { parent, kind, str(id), [] });
    nodes.len - 1
}
// Missing occupancy requires rejection or a caller-supplied finite fallback.
/*
Build from parse_mmcif_structure. author=true selects author chain/residue IDs,
otherwise label IDs; missing chosen IDs fail. Atom names use label IDs; identity across
namespaces/writers is not assumed. Missing occupancy requires rejection or finite
explicit fallback, not inferred zero.
*/
/*
Rejects over 100,000 atom rows before allocation; parser caps input at 64 MiB before
normalization. At most 1+5*rows nodes; bounded row references and validated loop offsets
keep arithmetic within i64.
*/
fn structural_hierarchy(s: const StructuralModel&, author: bool,
    allow_missing: bool, missing_occupancy: f64) -> HierarchyResult {
    let empty = hierarchy_empty();
    if s.atoms.len > 100000 || is_nan(missing_occupancy) || is_inf(missing_occupancy) {
        return HierarchyResult { empty, "invalid bound or occupancy policy" };
    }
    var atoms: const StructuralAtom&[>..] = [];
    for a in s.atoms { atoms.push(a); }
    var occupancy: f64[>..] = [];
    for item in s.document.items {
        let col = cif_column(item.tags, "_atom_site.occupancy");
        if cif_column(item.tags, "_atom_site.cartn_x") < 0 { continue; }
        var values: const CifToken&[>..] = [];
        for v in item.values { values.push(v); }
        for a in s.atoms {
            var value = missing_occupancy;
            if col >= 0 {
                let t = values[a.row * item.tags.len + col];
                if t.kind == 0 {
                    let v, ok = parse_flt(t.text);
                    if !ok || is_nan(v) || is_inf(v) { return HierarchyResult { empty, "invalid occupancy" }; }
                    value = v;
                } else if !allow_missing { return HierarchyResult { empty, "missing occupancy" }; }
            } else if !allow_missing { return HierarchyResult { empty, "missing occupancy" }; }
            occupancy.push(value);
        }
    }
    if occupancy.len != s.atoms.len { return HierarchyResult { empty, "invalid atom document" }; }
    var nodes: StructuralNode[>..] = [];
    nodes.push(StructuralNode { -1, 0, copy(s.document.name), [] });
    var selected: bool[>..] = [];
    var previous_serial = -1; var occurrence = -1; var model = -1;
    for a, row in s.atoms {
        if a.row != row { return HierarchyResult { empty, "invalid source row" }; }
        let chain = if author { copy(a.author_chain) } else { copy(a.label_chain) };
        let residue = if author { copy(a.author_residue) } else { copy(a.label_residue) };
        let atom = copy(a.label_atom);
        if a.alternate.kind == 0 && a.alternate.text.len != 1 {
            return HierarchyResult { empty, "alternate ID requires one character" };
        }
        if chain.kind != 0 || chain.text.len == 0 || residue.kind != 0 || residue.text.len == 0 {
            return HierarchyResult { empty, "namespace identity unavailable" };
        }
        let rn, rok = parse_int(residue.text);
        if !rok { return HierarchyResult { empty, "invalid residue ID" }; }
        let serial, valid_serial = parse_int(a.model);
        if !valid_serial || serial < 1 { return HierarchyResult { empty, "invalid model serial" }; }
        if serial != previous_serial {
            occurrence += 1; previous_serial = serial;
            model = hierarchy_node(nodes, 0, 1, str(occurrence));
        }
        let ch = hierarchy_node(nodes, model, 2, chain.text);
        let het: u8[>..] = if !a.hetero { " " } else if a.label_component.text == "HOH" || a.label_component.text == "WAT" { "W" } else { str("H_", a.label_component.text) };
        let insertion: u8[>..] = if a.insertion.kind == 0 { hierarchy_token(a.insertion) } else { "blank" };
        let res = hierarchy_node(nodes, ch, 3, str(het, ":", rn, ":", insertion));
        let comp = hierarchy_node(nodes, res, 4, a.label_component.text);
        for n in nodes { if n.parent == res && n.kind == 4 &&
            n.id == a.label_component.text && n.rows.len > 0 {
            for r in nodes { if r.parent == ch && r.kind == 3 &&
                r.id == str(het, ":", rn, ":", insertion) && r.rows.len > 0 {
                if atoms[r.rows[r.rows.len - 1]].label_component.text != a.label_component.text {
                    return HierarchyResult { empty, "component reentry ordering unsupported" };
                }
            } }
        } }
        let at = hierarchy_node(nodes, comp, 5, atom.text);
        var refs: StructuralNode&[>..] = [];
        for n in nodes { refs.push(n); }
        for old in refs[at].rows {
            if a.alternate.kind != 0 && atoms[old].alternate.kind == 0 {
                return HierarchyResult { empty, "blank alternate after explicit child" };
            }
            if cif_same(atoms[old].alternate, a.alternate) {
                return HierarchyResult { empty, "duplicate atom alternate child" };
            }
            if atoms[old].alternate.kind != 0 && a.alternate.kind != 0 {
                return HierarchyResult { empty, "duplicate atom child" };
            }
        }
        var updated: StructuralNode[>..] = [];
        for n, ni in nodes {
            var rows: i64[>..] = copy(n.rows);
            if ni == 0 || ni == model || ni == ch || ni == res || ni == comp || ni == at { rows.push(row); }
            updated.push(StructuralNode { n.parent, n.kind, copy(n.id), copy(rows) });
        }
        nodes = copy(updated);
        selected.push(false);
    }
    for n in nodes {
        if n.kind != 5 { continue; }
        var best = n.rows[0];
        // Promotion inserts the explicit child before the old blank atom.
        if n.rows.len > 1 && atoms[best].alternate.kind != 0 { best = n.rows[1]; }
        for row in n.rows { if occupancy[row] > occupancy[best] { best = row; } }
        selected[best] = true;
    }
    let alternate_selected = copy(selected);
    for n, ni in nodes {
        if n.kind != 3 { continue; }
        var last = -1; var components = 0;
        for c, ci in nodes { if c.parent == ni && c.kind == 4 { last = ci; components += 1; } }
        if components > 1 { for row in n.rows {
            if atoms[row].alternate.kind != 0 || atoms[row].alternate.text.len == 0 {
                return HierarchyResult { empty, "residue disorder requires alternate IDs" };
            }
        } }
        for c, ci in nodes { if c.parent == ni && c.kind == 4 && ci != last {
            for row in c.rows { selected[row] = false; }
        } }
    }
    HierarchyResult { StructuralHierarchy { copy(s), copy(nodes), copy(selected), author, copy(occupancy), copy(alternate_selected) }, "" }
}
/*
Explicitly chooses selected/unpacked rows; invalid node IDs, including negatives, return
empty. Traversal follows hierarchy child order rather than flat row order. Unpacked
components follow insertion order; atom alternates sort blank then character. Wrapper
promotion changes traversal, not node IDs.
*/
fn structural_rows(h: const StructuralHierarchy&, node: i64, unpacked: bool) -> i64[] {
    var rows: i64[>..] = [];
    if node < 0 || node >= h.nodes.len { return []; }
    var refs: const StructuralNode&[>..] = [];
    for n in h.nodes { refs.push(n); }
    var stack: i64[>..] = [node];
    while stack.len > 0 {
        let current = stack[stack.len - 1];
        var tail: i64[>..] = [];
        for ci, i in stack { if i + 1 < stack.len { tail.push(ci); } }
        stack = copy(tail);
        let n = refs[current];
        if n.kind == 5 {
            if !unpacked {
                for row in n.rows { if h.selected[row] { rows.push(row); } }
            } else {
                var atoms: const StructuralAtom&[>..] = [];
                for a in h.structure.atoms { atoms.push(a); }
                // Bio unpacks atom alternates in blank then lexical order.
                var pending: i64[>..] = copy(n.rows);
                while pending.len > 0 {
                    var best = 0;
                    for row, i in pending {
                        let key: u8[>..] = if atoms[row].alternate.kind == 0 { str(atoms[row].alternate.text) } else { " " };
                        let old = atoms[pending[best]].alternate;
                        let oldkey: u8[>..] = if old.kind == 0 { str(old.text) } else { " " };
                        if key[0] < oldkey[0] { best = i; }
                    }
                    rows.push(pending[best]);
                    var rest: i64[>..] = [];
                    for row, i in pending { if i != best { rest.push(row); } }
                    pending = copy(rest);
                }
            }
        } else {
            var children: i64[>..] = structural_children(h, current);
            if n.kind == 4 {
                // Promotion detaches and appends the atom wrapper.
                var ordered: i64[>..] = [];
                while children.len > 0 {
                    var best = 0; var bestkey = h.structure.atoms.len;
                    for ci, i in children {
                        let c = refs[ci];
                        var key = c.rows[0];
                        for a, row in h.structure.atoms { if row == key &&
                            a.alternate.kind != 0 && c.rows.len > 1 { key = c.rows[1]; } }
                        if key < bestkey { best = i; bestkey = key; }
                    }
                    ordered.push(children[best]);
                    var rest: i64[>..] = [];
                    for ci, i in children { if i != best { rest.push(ci); } }
                    children = copy(rest);
                }
                children = copy(ordered);
            }
            var i = children.len;
            while i > 0 { i -= 1; stack.push(children[i]); }
        }
    }
    copy(rows)
}
/*
Returns immediate child indices in stable creation order; invalid IDs return empty.
*/
fn structural_children(h: const StructuralHierarchy&, node: i64) -> i64[] {
    var ids: i64[>..] = [];
    if node < 0 || node >= h.nodes.len { return []; }
    for n, i in h.nodes { if n.parent == node { ids.push(i); } }
    copy(ids)
}
// Selection returns a private copy; failed selections leave input untouched.
/*
Select residue component before its active atom alternate. Alternate IDs have one
character; all source alternates/rows survive. Atom selection favors highest occupancy,
then first insertion; residue disorder selects the last component.
*/
/*
Explicit alternate promotion of a blank atom inserts that child first and appends its
wrapper, so occupancy ties favor the explicit child. Ordinary explicit ties favor first
insertion. Blank after explicit, blank in component disorder, and component reentry such
as SER/CYS/SER fail, even with distinct atom names.
*/
fn structural_select(h: const StructuralHierarchy&, node: i64, child: u8[:]) -> HierarchyResult {
    if node < 0 || node >= h.nodes.len { return HierarchyResult { copy(h), "invalid selection node" }; }
    var out = copy(h);
    var refs: const StructuralNode&[>..] = [];
    for n in h.nodes { refs.push(n); }
    var atoms: const StructuralAtom&[>..] = [];
    for a in h.structure.atoms { atoms.push(a); }
    let n = refs[node];
    var chosen: i64[>..] = [];
    if n.kind == 5 {
        var active = false;
        for row in n.rows { if h.selected[row] { active = true; } }
        if !active { return HierarchyResult { copy(h), "select residue component first" }; }
        for row in n.rows { if atoms[row].alternate.text == child { chosen.push(row); } }
    } else if n.kind == 3 {
        for c in h.nodes { if c.parent == node && c.id == child { chosen.append(c.rows); } }
    } else { return HierarchyResult { copy(h), "selection requires residue or atom" }; }
    if chosen.len == 0 { return HierarchyResult { copy(h), "selection unavailable" }; }
    for row in n.rows { out.selected[row] = false; }
    if n.kind == 5 {
        for row in n.rows { out.alternate_selected[row] = false; }
        out.alternate_selected[chosen[0]] = true;
        out.selected[chosen[0]] = true;
    } else {
        for row in chosen { out.selected[row] = out.alternate_selected[row]; }
    }
    HierarchyResult { out, "" }
}
