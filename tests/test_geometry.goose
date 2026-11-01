import bio from "..";
import bio.structure.geometry;
import math;
fn main() {
    let a = [bio::Point3 { 0, 0, 0 }, bio::Point3 { 1, 0, 0 }, bio::Point3 { 0, 2, 0 }, bio::Point3 { 0, 0, 3 }, bio::Point3 { 2, -1, 4 }];
    var b: bio::Point3[>..] = [];
    for p in a { b.push(bio::Point3 { -p.y + 5, p.x - 7, p.z + 2 }); }
    let fit = bio::superpose(a, b);
    assert(fit.error.len == 0 && fit.rmsd < 1e-12);
    for p, i in a {
        let q = bio::transform_point(p, fit);
        assert(abs(q.x - b[i].x) < 1e-12 && abs(q.y - b[i].y) < 1e-12 && abs(q.z - b[i].z) < 1e-12);
    }
    assert(abs(fit.translation.x - 5) < 1e-12 && abs(fit.translation.y + 7) < 1e-12);
    let single = bio::superpose([bio::Point3 { 1, 2, 3 }], [bio::Point3 { 4, 5, 6 }]);
    assert(single.error.len == 0 && single.rmsd < 1e-12);
    let line = bio::superpose([bio::Point3 { -1, 0, 0 }, bio::Point3 { 1, 0, 0 }], [bio::Point3 { 0, -1, 0 }, bio::Point3 { 0, 1, 0 }]);
    assert(line.error.len == 0 && line.rmsd < 1e-12);
    let repeated = bio::superpose([bio::Point3 { 2, 2, 2 }, bio::Point3 { 2, 2, 2 }], [bio::Point3 { 3, 3, 3 }, bio::Point3 { 3, 3, 3 }]);
    assert(repeated.error.len == 0 && repeated.rmsd == 0);
    let stretched = bio::superpose([bio::Point3 { -1, 0, 0 }, bio::Point3 { 1, 0, 0 }], [bio::Point3 { -2, 0, 0 }, bio::Point3 { 2, 0, 0 }]);
    assert(stretched.error.len == 0 && abs(stretched.rmsd - 1) < 1e-12);
    assert(bio::superpose([], []).error.len > 0);
    var halfturn: bio::Point3[>..] = [];
    for p in a { halfturn.push(bio::Point3 { -p.x, -p.y, p.z }); }
    let half = bio::superpose(a, halfturn);
    assert(half.error.len == 0 && half.rmsd < 1e-12);
    let tetra = [bio::Point3 { 1, 1, 1 }, bio::Point3 { 1, -1, -1 }, bio::Point3 { -1, 1, -1 }, bio::Point3 { -1, -1, 1 }];
    var mirror: bio::Point3[>..] = [];
    for p in tetra { mirror.push(bio::Point3 { -p.x, p.y, p.z }); }
    let reflected = bio::superpose(tetra, mirror);
    assert(reflected.error.len == 0 && abs(reflected.rmsd - 2) < 1e-12);
    let plane = [bio::Point3 { 0, 0, 0 }, bio::Point3 { 2, 0, 0 }, bio::Point3 { 0, 3, 0 }];
    let turned = [bio::Point3 { 4, 0, 0 }, bio::Point3 { 4, 0, 2 }, bio::Point3 { 4, 3, 0 }];
    let planar = bio::superpose(plane, turned);
    assert(planar.error.len == 0 && planar.rmsd < 1e-12);
    for factor in [1e-150, 1e150] {
        var small: bio::Point3[>..] = []; var other: bio::Point3[>..] = [];
        for p in a { small.push(bio::Point3 { p.x * factor, p.y * factor, p.z * factor }); }
        for p in b { other.push(bio::Point3 { p.x * factor, p.y * factor, p.z * factor }); }
        let scaled = bio::superpose(small, other);
        assert(scaled.error.len == 0 && scaled.rmsd / factor < 1e-12);
    }
    let separated = bio::superpose(
        [bio::Point3 { -1e-100, 0, 1e100 }, bio::Point3 { 1e-100, 0, 1e100 }],
        [bio::Point3 { -2e-100, 0, 1e100 }, bio::Point3 { 2e-100, 0, 1e100 }]);
    assert(separated.error.len == 0);
    assert(abs(separated.rmsd / 1e-100 - 1) < 1e-12);
    let unsupported = bio::superpose(
        [bio::Point3 { -1e-300, 0, 1e100 }, bio::Point3 { 1e-300, 0, 1e100 }],
        [bio::Point3 { -2e-300, 0, 1e100 }, bio::Point3 { 2e-300, 0, 1e100 }]);
    assert(unsupported.error == "unsupported coordinate scale separation");
    print("geometry: passed");
}
