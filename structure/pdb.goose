namespace bio;

import math;
import std;

struct Atom {
    serial:         i64,
    name:           u8[],
    alternate:      u8,
    residue:        u8[],
    chain:          u8,
    residue_number: i64,
    insertion:      u8,
    x:              f64, y: f64, z: f64,
    occupancy:      f64,
    b_factor:       f64,
    element:        u8[],
    hetero:         bool,
    model:          i64,
}

struct StructureResult { atoms: Atom[], error: u8[] }

fn parse_pdb(text: const u8[:]) -> StructureResult {
    var atoms: Atom[>..] = [];
    var model: i64       = 1;
    for line in split(text, '\n') {
        if starts_with(line, "MODEL ") {
            let n, ok = parse_int(trim(line[6..]));
            if !ok { return StructureResult { [], "invalid PDB model number" }; }
            model = n;
        }
        let hetero = starts_with(line, "HETATM");
        if !hetero && !starts_with(line, "ATOM  ") { continue; }
        if line.len < 66 { return StructureResult { [], "truncated PDB atom record" }; }
        let serial, s_ok = parse_int(trim(line[6..11]));
        let residue_number, r_ok = parse_int(trim(line[22..26]));
        let x, x_ok = parse_flt(trim(line[30..38]));
        let y, y_ok = parse_flt(trim(line[38..46]));
        let z, z_ok = parse_flt(trim(line[46..54]));
        let occupancy, o_ok = parse_flt(trim(line[54..60]));
        let b_factor, b_ok = parse_flt(trim(line[60..66]));
        if !s_ok || !r_ok || !x_ok || !y_ok || !z_ok || !o_ok || !b_ok {
            return StructureResult { [], "invalid PDB numeric field" };
        }
        if is_nan(x) || is_nan(y) || is_nan(z) || is_nan(occupancy) || is_nan(b_factor) ||
           is_inf(x) || is_inf(y) || is_inf(z) || is_inf(occupancy) || is_inf(b_factor) {
            return StructureResult { [], "non-finite PDB numeric field" };
        }
        var element: u8[>..] = [];
        if line.len >= 78 { for c in trim(line[76..78]) { element.push(c); } }
        atoms.push(Atom { serial, trim(line[12..16]), line[16],
            trim(line[17..20]), line[21], residue_number, line[26],
            x, y, z, occupancy, b_factor, copy(element), hetero, model });
    }
    StructureResult { copy(atoms), "" }
}

fn atom_distance(a: const Atom&, b: const Atom&) -> f64 {
    let dx = a.x - b.x;
    let dy = a.y - b.y;
    let dz = a.z - b.z;
    sqrt(dx * dx + dy * dy + dz * dz)
}

struct Contact { first: i64, second: i64, distance: f64 }

fn atom_contacts(atoms: const Atom[:], cutoff: f64) -> Contact[>..] {
    assert(cutoff >= 0);
    var contacts: Contact[>..] = [];
    for a, i in atoms {
        for b, j in atoms {
            if j <= i || a.model != b.model { continue; }
            let distance = atom_distance(a, b);
            if distance <= cutoff { contacts.push(Contact { i, j, distance }); }
        }
    }
    contacts
}

fn centroid(atoms: const Atom[:]) -> f64, f64, f64 {
    assert(atoms.len > 0);
    var x = 0.0;
    var y = 0.0;
    var z = 0.0;
    for a in atoms { x += a.x; y += a.y; z += a.z; }
    return x / atoms.len, y / atoms.len, z / atoms.len;
}

fn coordinate_rmsd(a: const Atom[:], b: const Atom[:]) -> f64 {
    assert(a.len > 0 && a.len == b.len);
    var squared = 0.0;
    var refs: const Atom&[>..] = [];
    for atom in b { refs.push(atom); }
    for atom, i in a {
        let d = atom_distance(atom, refs[i]);
        squared += d * d;
    }
    sqrt(squared / a.len)
}
