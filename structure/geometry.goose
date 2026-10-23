namespace bio;
import math;

struct Point3 { x: f64, y: f64, z: f64 }
// Rotation is row-major: fitted = rotation * moving + translation.
struct Superposition {
    rotation: f64[], translation: Point3, rmsd: f64, error: u8[]
}
fn point_finite(p: const Point3&) -> bool {
    !is_nan(p.x) && !is_inf(p.x) && !is_nan(p.y) &&
    !is_inf(p.y) && !is_nan(p.z) && !is_inf(p.z)
}
fn transform_point(p: const Point3&, fit: const Superposition&) -> Point3 {
    assert(fit.error.len == 0 && fit.rotation.len == 9);
    let r = fit.rotation;
    Point3 { r[0]*p.x+r[1]*p.y+r[2]*p.z+fit.translation.x,
        r[3]*p.x+r[4]*p.y+r[5]*p.z+fit.translation.y,
        r[6]*p.x+r[7]*p.y+r[8]*p.z+fit.translation.z }
}
fn fit_error(message: const u8[:]) -> Superposition {
    Superposition { [], Point3 {0,0,0}, 0, message }
}
// Equal-weight, fixed-correspondence, proper rotations only.
// No atom matching, mass weighting, periodic boundaries, or outlier fit.
// Extreme scale separation can lose information in f64 arithmetic.
// Degenerate sets have a valid but not necessarily unique rotation.
fn superpose(moving: const Point3[:], target: const Point3[:]) -> Superposition {
    let n = moving.len;
    if n == 0 || target.len != n { return fit_error("coordinate counts must be equal and nonzero"); }
    var ca = Point3 {0,0,0}; var cb = Point3 {0,0,0};
    var scale = 0.0;
    for p in moving {
        if !point_finite(p) { return fit_error("non-finite coordinate"); }
        scale = max(scale, max(abs(p.x), max(abs(p.y), abs(p.z))));
    }
    for p in target {
        if !point_finite(p) { return fit_error("non-finite coordinate"); }
        scale = max(scale, max(abs(p.x), max(abs(p.y), abs(p.z))));
    }
    if scale == 0 { scale = 1; }
    // Normalize before centering to avoid covariance overflow.
    for p in moving { ca.x += p.x/scale/n; ca.y += p.y/scale/n; ca.z += p.z/scale/n; }
    for p in target { cb.x += p.x/scale/n; cb.y += p.y/scale/n; cb.z += p.z/scale/n; }
    var spread = 0.0;
    for p, i in moving {
        let q = target[i];
        for x in [p.x/scale-ca.x,p.y/scale-ca.y,p.z/scale-ca.z,
            q.x/scale-cb.x,q.y/scale-cb.y,q.z/scale-cb.z] {
            spread = max(spread, abs(x));
        }
        for x in [p.x,p.y,p.z,q.x,q.y,q.z] {
            if x != 0 && x/scale == 0 {
                return fit_error("unsupported coordinate scale separation");
            }
        }
    }
    if spread == 0 { spread = 1; }
    var s: f64[9] = [0,0,0,0,0,0,0,0,0];
    for p, k in moving {
        let q = target[k];
        let a = [p.x/scale-ca.x, p.y/scale-ca.y, p.z/scale-ca.z];
        let b = [q.x/scale-cb.x, q.y/scale-cb.y, q.z/scale-cb.z];
        for i in 3 { for j in 3 { s[3*i+j] += (a[i]/spread)*(b[j]/spread)/n; } }
    }
    var h: f64[16] = [s[0]+s[4]+s[8], s[5]-s[7], s[6]-s[2], s[1]-s[3],
        s[5]-s[7], s[0]-s[4]-s[8], s[1]+s[3], s[6]+s[2],
        s[6]-s[2], s[1]+s[3], -s[0]+s[4]-s[8], s[5]+s[7],
        s[1]-s[3], s[6]+s[2], s[5]+s[7], -s[0]-s[4]+s[8]];
    var v: f64[16] = [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1];
    var norm = 0.0; for x in h { norm = max(norm, abs(x)); }
    if norm > 0 { for i in 16 { h[i] /= norm; } }
    var converged = false;
    // Jacobi selects the largest algebraic eigenvalue.
    for iteration in 128 {
        var p: i64 = 0; var q: i64 = 1; var largest = 0.0;
        for i in 4 { for j in 4 {
            if j > i && abs(h[4*i+j]) > largest { largest = abs(h[4*i+j]); p = i; q = j; }
        } }
        if largest < 1e-15 { converged = true; break; }
        let off = h[4*p+q];
        let tau = (h[4*q+q]-h[4*p+p])/(2*off);
        var t = 1.0/(abs(tau)+sqrt(1+tau*tau));
        if tau < 0 { t = -t; }
        let c = 1/sqrt(1+t*t); let sn = t*c;
        h[4*p+p] -= t*off; h[4*q+q] += t*off;
        h[4*p+q] = 0; h[4*q+p] = 0;
        for k in 4 {
            if k != p && k != q {
                let x = h[4*k+p]; let y = h[4*k+q];
                h[4*k+p] = c*x-sn*y; h[4*p+k] = h[4*k+p];
                h[4*k+q] = sn*x+c*y; h[4*q+k] = h[4*k+q];
            }
            let x = v[4*k+p]; let y = v[4*k+q];
            v[4*k+p] = c*x-sn*y; v[4*k+q] = sn*x+c*y;
        }
    }
    if !converged { return fit_error("quaternion eigensolver did not converge"); }
    var best: i64 = 0;
    for i in 4 { if h[4*i+i] > h[4*best+best] { best = i; } }
    let w = v[best]; let x = v[4+best]; let y = v[8+best]; let z = v[12+best];
    let r = [1-2*(y*y+z*z), 2*(x*y-z*w), 2*(x*z+y*w),
        2*(x*y+z*w), 1-2*(x*x+z*z), 2*(y*z-x*w),
        2*(x*z-y*w), 2*(y*z+x*w), 1-2*(x*x+y*y)];
    let tr = Point3 { (cb.x-r[0]*ca.x-r[1]*ca.y-r[2]*ca.z)*scale,
        (cb.y-r[3]*ca.x-r[4]*ca.y-r[5]*ca.z)*scale,
        (cb.z-r[6]*ca.x-r[7]*ca.y-r[8]*ca.z)*scale };
    var residual_scale = 0.0; var squared = 0.0;
    for p, i in moving {
        let q = target[i];
        let ax = p.x/scale-ca.x; let ay = p.y/scale-ca.y; let az = p.z/scale-ca.z;
        let dx = r[0]*ax+r[1]*ay+r[2]*az-(q.x/scale-cb.x);
        let dy = r[3]*ax+r[4]*ay+r[5]*az-(q.y/scale-cb.y);
        let dz = r[6]*ax+r[7]*ay+r[8]*az-(q.z/scale-cb.z);
        for delta in [dx,dy,dz] {
            let value = abs(delta);
            if value > residual_scale {
                let ratio = residual_scale/value;
                squared = squared*ratio*ratio + 1;
                residual_scale = value;
            } else if value > 0 {
                let ratio = value/residual_scale;
                squared += ratio*ratio;
            }
        }
    }
    let rmsd = (residual_scale*scale)*sqrt(squared/n);
    if residual_scale != 0 && rmsd == 0 { return fit_error("residual scale out of range"); }
    if !point_finite(tr) || is_inf(rmsd) || is_nan(rmsd) { return fit_error("transform arithmetic overflow"); }
    Superposition { r, tr, rmsd, "" }
}
