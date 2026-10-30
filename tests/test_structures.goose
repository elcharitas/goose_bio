import bio from "..";
import bio.structure.pdb;

fn main() {
    let pdb = "ATOM      1  N   ALA A   1      11.000  12.000  13.000  1.00 20.00           N  \nATOM      2  CA  ALA A   1      14.000  16.000  13.000  1.00 21.00           C  \n";
    let result = bio::parse_pdb(pdb);
    assert(result.error.len == 0);
    assert(result.atoms.len == 2);
    var atoms: const bio::Atom&[>..] = [];
    for a in result.atoms { atoms.push(a); }
    assert(atoms[0].name == "N");
    assert(atoms[1].element == "C");
    assert(bio::atom_distance(atoms[0], atoms[1]) == 5.0);
    assert(bio::atom_contacts(result.atoms, 5.0).len == 1);
    assert(bio::atom_contacts(result.atoms, 4.9).len == 0);
    assert(bio::coordinate_rmsd(result.atoms, result.atoms) == 0.0);
    let x, y, z = bio::centroid(result.atoms);
    assert(x == 12.5 && y == 14.0 && z == 13.0);
    assert(bio::parse_pdb("ATOM  bad").error.len > 0);
    let malformed = "ATOM      X  N   ALA A   1      11.000  12.000  13.000  1.00 20.00           N  ";
    assert(bio::parse_pdb(malformed).error.len > 0);
    let models = bio::parse_pdb(str("MODEL        1\n", pdb, "ENDMDL\nMODEL        2\n", pdb, "ENDMDL\n"));
    assert(models.error.len == 0 && models.atoms.len == 4);
    assert(bio::atom_contacts(models.atoms, 5.0).len == 2);
    let alternate = bio::parse_pdb("HETATM    7  CA BALA Z  42A      1.000   2.000   3.000  0.50 30.00           C  ");
    assert(alternate.error.len == 0);
    for a in alternate.atoms {
        assert(a.hetero && a.alternate == 'B' && a.chain == 'Z');
        assert(a.insertion == 'A' && a.residue_number == 42 && a.occupancy == 0.5);
    }
    print("structures: passed");
}
