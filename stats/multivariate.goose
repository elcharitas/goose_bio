namespace bio;
import math;

/* Row-major outputs: means, rows*min(rows,columns) coordinates, min(rows,columns)*columns
 * components, and descending singular values. Reconstruct as coordinates*components+means. Errors
 * return empty arrays. */
struct ClusterPCA {
    mean: f64[], coordinates: f64[], components: f64[],
    singular_values: f64[], rows: i64, columns: i64, rank_size: i64,
    error: u8[]
}


fn pca_error(message: const u8[:]) -> ClusterPCA {
    var error: u8[>..] = []; for x in message { error.push(x); }
    return ClusterPCA {[], [], [], [], 0, 0, 0, error};
}
// Row-major thin SVD of centered observations; no variance scaling.

/* Centers all observations and uses scaled one-sided Jacobi rotations. No masks, weights,
 * standardization, covariance normalization, or imputation. Zero, constant, singleton, wide, tall, and
 * rank-deficient data are valid. Signs and bases within repeated singular spaces are unspecified.
 * Limits: positive dimensions <=256 rows/64 columns and 1..10000 sweeps; exhaustion errors. */
fn cluster_pca(data: const f64[:], rows: i64, columns: i64,
    max_sweeps: i64) -> ClusterPCA {
    if rows <= 0 || columns <= 0 || rows > 256 || columns > 64 ||
        data.len != rows*columns || max_sweeps <= 0 || max_sweeps > 10000 {
        return pca_error("invalid PCA dimensions or sweep limit");
    }
    var scale = 0.0;
    for x in data {
        if !cluster_finite(x) { return pca_error("non-finite PCA input"); }
        scale = max(scale, abs(x));
    }
    /* Nonzero maximum input magnitude must be [1e-100,1e100]. Nonzero input/centered magnitudes below
     * 1e-140 of that maximum reject. Relative pair tolerance is 1e-15 and absolute normalized
     * cross-product tolerance 1e-28. Tiny singular spaces have absolute, not relative, accuracy. This is
     * not a high-accuracy ill-conditioned SVD; exact zeros do not determine numerical rank. */
    if scale != 0 && (scale < 1e-100 || scale > 1e100) {
        return pca_error("unsupported PCA scale");
    }
    if scale == 0 { scale = 1.0; }
    for x in data {
        if x != 0 && abs(x) < scale*1e-140 {
            return pca_error("unsupported input dynamic range");
        }
    }
    var mean: f64[>..] = []; var a: f64[>..] = [];
    var v: f64[>..] = [];
    for c in columns {
        var sum = 0.0;
        for r in rows { sum += (data[r*columns+c]/scale)/rows; }
        mean.push(sum*scale);
    }
    for r in rows { for c in columns {
        let x = data[r*columns+c]/scale-mean[c]/scale;
        if x != 0 && abs(x) < 1e-140 { return pca_error("unsupported centered dynamic range"); }
        a.push(x);
    } }
    for i in columns { for j in columns { v.push(if i == j { 1.0 } else { 0.0 }); } }
    var converged = false;
    // Absolute tolerance also permits numerically null singular columns.
    for sweep in max_sweeps {
        var changed = false;
        for p in columns { for q in p+1..columns {
            var alpha = 0.0; var beta = 0.0; var gamma = 0.0;
            for r in rows {
                let x = a[r*columns+p]; let y = a[r*columns+q];
                alpha += x*x; beta += y*y; gamma += x*y;
            }
            if abs(gamma) > 1e-15*sqrt(alpha*beta) && abs(gamma) > 1e-28 {
                changed = true;
                let zeta = (beta-alpha)/(2*gamma);
                let t = (if zeta >= 0 { 1.0 } else { -1.0 })/(abs(zeta)+sqrt(1+zeta*zeta));
                let cs = 1/sqrt(1+t*t); let sn = cs*t;
                for r in rows {
                    let x = a[r*columns+p]; let y = a[r*columns+q];
                    a[r*columns+p] = cs*x-sn*y; a[r*columns+q] = sn*x+cs*y;
                }
                for r in columns {
                    let x = v[r*columns+p]; let y = v[r*columns+q];
                    v[r*columns+p] = cs*x-sn*y; v[r*columns+q] = sn*x+cs*y;
                }
            }
        } }
        if !changed { converged = true; break; }
    }
    if !converged { return pca_error("PCA sweep limit reached"); }
    var norms: f64[>..] = []; var order: i64[>..] = [];
    for c in columns {
        var sum = 0.0; for r in rows { sum += a[r*columns+c]*a[r*columns+c]; }
        norms.push(sqrt(sum)); order.push(c);
    }
    for i in columns { var j = i;
        while j > 0 && norms[order[j]] > norms[order[j-1]] {
            let x = order[j]; order[j] = order[j-1]; order[j-1] = x; j -= 1;
        }
    }
    let n = min(rows, columns);
    var singular: f64[>..] = []; var components: f64[>..] = []; var coords: f64[>..] = [];
    for k in n {
        singular.push(norms[order[k]]*scale);
        for c in columns { components.push(v[c*columns+order[k]]); }
    }
    for r in rows { for k in n { coords.push(a[r*columns+order[k]]*scale); } }
    return ClusterPCA {mean, coords, components, singular, rows, columns, n, ""};
}

/* IDs are medoid row indexes, not contiguous labels. objective sums distances to medoids; iterations
 * counts assignment passes. No random restarts or nfound. */
struct ClusterMedoids { ids: i64[], objective: f64, iterations: i64, error: u8[] }

/* Masks/weights enter via cluster_distances, whose e metric is weighted mean square without square
 * root and gives zero with no common observation. Precomputed distances keep their units; lost
 * information cannot be recovered. No SOM, random initialization, or alternate metric. Deterministic
 * masked k-means is separate. */
fn medoid_error(message: const u8[:]) -> ClusterMedoids {
    var error: u8[>..] = []; for x in message { error.push(x); }
    return ClusterMedoids {[], 0.0, 0, error};
}
// Output IDs are medoid row indices.

/* Requires a full symmetric distance matrix with zero diagonal and initial labels covering every
 * cluster. Empty clusters fail. Medoid ties choose lowest member row; assignment ties choose first
 * cluster, except medoids retain themselves. Stops at stable assignments or nondecreasing objective,
 * exhaustion errors. Limits: 4,096 items, 10,000 passes; nonzero distances in [1e-100,1e100].
 * Negative/nonfinite/asymmetric distances reject. Work is quadratic per pass. */
fn cluster_kmedoids(distances: const ClusterDistances&, initial: const i64[:],
    count: i64, max_iterations: i64) -> ClusterMedoids {
    let n = distances.size;
    if distances.error.len > 0 { return medoid_error(distances.error); }
    if n <= 0 || n > 4096 || count <= 0 || count > n || initial.len != n ||
        distances.values.len != n*n || max_iterations <= 0 || max_iterations > 10000 {
        return medoid_error("invalid medoid parameters");
    }
    for i in n { for j in n {
        let x = distances.values[i*n+j];
        if !cluster_finite(x) || x < 0 || x > 1e100 ||
            (x != 0 && x < 1e-100) || x != distances.values[j*n+i] || (i == j && x != 0) {
            return medoid_error("invalid or unsupported distance matrix");
        }
    } }
    var ids: i64[>..] = [];
    for id in initial {
        if id < 0 || id >= count { return medoid_error("invalid initial id"); }
        ids.push(id);
    }
    var previous = -1.0;
    for iteration in max_iterations {
        var medoids: i64[>..] = [];
        for k in count {
            var best = -1; var cost = 0.0;
            for i in n { if ids[i] == k {
                var sum = 0.0;
                for j in n { if ids[j] == k { sum += distances.values[i*n+j]; } }
                if best < 0 || sum < cost { best = i; cost = sum; }
            } }
            if best < 0 { return medoid_error("empty cluster"); }
            medoids.push(best);
        }
        var changed = false; var total = 0.0;
        for i in n {
            var best = 0; var distance = distances.values[i*n+medoids[0]];
            for k in count {
                if i == medoids[k] { best = k; distance = 0.0; break; }
                let d = distances.values[i*n+medoids[k]];
                if d < distance { best = k; distance = d; }
            }
            if ids[i] != best { changed = true; }
            ids[i] = best; total += distance;
        }
        if !changed || (previous >= 0 && total >= previous) {
            var result: i64[>..] = [];
            for id in ids { result.push(medoids[id]); }
            return ClusterMedoids {result, total, iteration+1, ""};
        }
        previous = total;
    }
    return medoid_error("medoid iteration limit reached");
}
