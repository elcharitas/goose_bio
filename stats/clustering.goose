namespace bio;
import math;

/* Flat row-major full symmetric square distances. Only row clustering and weighted mean-square
 * distance are supported. Storage is quadratic; extreme finite inputs can lose precision or
 * overflow. Extreme-range arithmetic is not scaled. */
struct ClusterDistances { values: f64[], size: i64, error: u8[] }

/* Means use method a, medians m. Observations have equal weight within features; feature weights do
 * not weight observations. Even medians average the middle pair. No observations gives value/mask
 * zero; other masks are one. */
struct ClusterCentroids { values: f64[], mask: i64[], rows: i64, columns: i64, error: u8[] }

/* Leaves are 0..n-1 and merge i has ID n+i. Height is merge dissimilarity, separate from phylogenetic
 * branch lengths, without implicit conversion. */
struct ClusterMerge { left: i64, right: i64, height: f64 }
struct ClusterTree { merges: ClusterMerge[], size: i64, error: u8[] }
struct ClusterCut { ids: i64[], error: u8[] }
fn cluster_finite(x: f64) -> bool { !is_nan(x) && !is_inf(x) }
fn cluster_data_error(data: const f64[:], mask: const i64[:], rows: i64, columns: i64) -> u8[] {
    if rows <= 0 || columns <= 0 { return "positive dimensions required"; }
    if rows > data.len / columns || data.len % columns != 0 || data.len / columns != rows || mask.len != data.len {
        return "data and mask dimensions differ";
    }
    for x, i in data {
        if mask[i] != 0 && !cluster_finite(x) { return "non-finite observed value"; }
    }
    return "";
}
// Distance e is weighted mean squared difference, without a root.

/* Dimensions are positive and match arrays. Any nonzero mask means observed; those values must be
 * finite even at zero weight, while masked values may be nonfinite. Weights are finite, nonnegative,
 * with positive finite total. Overflow rejects. Check errors before fields. The e distance divides
 * weighted squared differences by common observed weight, without square root. No shared positive-
 * weight observation gives zero and can join unmeasured pairs. */
fn cluster_distances(data: const f64[:], mask: const i64[:], rows: i64,
    columns: i64, weights: const f64[:]) -> ClusterDistances {
    let error = cluster_data_error(data, mask, rows, columns);
    if error.len > 0 { return ClusterDistances { [], 0, error }; }
    if weights.len != columns { return ClusterDistances { [], 0, "weight dimensions differ" }; }
    var total = 0.0;
    for w in weights {
        if !cluster_finite(w) || w < 0 { return ClusterDistances { [], 0, "invalid weight" }; }
        total += w;
    }
    if total <= 0 || !cluster_finite(total) { return ClusterDistances { [], 0, "positive finite total weight required" }; }
    var result: f64[>..] = [];
    for i in rows {
        for j in rows {
            var sum = 0.0; var common = 0.0;
            for c in columns {
                if mask[i * columns + c] != 0 && mask[j * columns + c] != 0 && weights[c] > 0 {
                    let d = data[i * columns + c] - data[j * columns + c];
                    sum += weights[c] * d * d; common += weights[c];
                }
            }
            let distance = if common > 0 { sum / common } else { 0.0 };
            if !cluster_finite(distance) { return ClusterDistances { [], 0, "distance arithmetic overflow" }; }
            result.push(distance);
        }
    }
    return ClusterDistances { result, rows, "" };
}
// Centroid observations have equal weight; feature weights affect distances.

/* Cluster IDs must cover every integer 0..count-1; empty clusters reject. Median sorting uses
 * insertion sort. */
fn cluster_centroids(data: const f64[:], mask: const i64[:], rows: i64,
    columns: i64, ids: const i64[:], count: i64, method: u8) -> ClusterCentroids {
    let error = cluster_data_error(data, mask, rows, columns);
    if error.len > 0 { return ClusterCentroids { [], [], 0, 0, error }; }
    if ids.len != rows || count <= 0 || count > rows || (method != 'a' && method != 'm') {
        return ClusterCentroids { [], [], 0, 0, "invalid centroid parameters" };
    }
    for id in ids { if id < 0 || id >= count { return ClusterCentroids { [], [], 0, 0, "invalid cluster id" }; } }
    var values: f64[>..] = []; var masks: i64[>..] = [];
    for k in count {
        var members = 0;
        for id in ids { if id == k { members += 1; } }
        if members == 0 { return ClusterCentroids { [], [], 0, 0, "empty cluster" }; }
        for c in columns {
            var observed: f64[>..] = [];
            for r in rows { if ids[r] == k && mask[r * columns + c] != 0 { observed.push(data[r * columns + c]); } }
            var value = 0.0;
            if observed.len > 0 {
                if method == 'a' { for x in observed { value += x / observed.len; } }
                else {
                    for i in observed.len {
                        var j = i;
                        while j > 0 && observed[j] < observed[j - 1] {
                            let x = observed[j]; observed[j] = observed[j - 1]; observed[j - 1] = x; j -= 1;
                        }
                    }
                    let mid = observed.len / 2;
                    value = if observed.len % 2 == 1 { observed[mid] } else { observed[mid - 1] / 2 + observed[mid] / 2 };
                }
            }
            if !cluster_finite(value) { return ClusterCentroids { [], [], 0, 0, "centroid arithmetic overflow" }; }
            values.push(value); masks.push(if observed.len > 0 { 1 } else { 0 });
        }
    }
    return ClusterCentroids { values, masks, count, columns, "" };
}
// IDs: leaves 0..n-1, merge i is n+i. Heights are not branch lengths.

/* Methods s/m/a mean single/complete/average linkage. Average weights by observation counts,
 * including missing-value observations. Active slots scan in ascending pair order; equal minima
 * retain the first pair, merge into the smaller slot, and keep that child order. Linkage takes cubic
 * work. */
fn cluster_linkage(distances: const ClusterDistances&, method: u8) -> ClusterTree {
    let n = distances.size;
    if distances.error.len > 0 { return ClusterTree { [], 0, copy(distances.error) }; }
    if n <= 0 || n > distances.values.len / n || distances.values.len / n != n || distances.values.len % n != 0 ||
        (method != 's' && method != 'm' && method != 'a') { return ClusterTree { [], 0, "invalid linkage parameters" }; }
    for i in n { for j in n {
        let x = distances.values[i * n + j];
        if !cluster_finite(x) || x < 0 || x != distances.values[j * n + i] || (i == j && x != 0) {
            return ClusterTree { [], 0, "invalid distance matrix" };
        }
    } }
    var active: i64[>..] = []; var sizes: i64[>..] = []; var labels: i64[>..] = []; var d: f64[>..] = [];
    for i in n { active.push(1); sizes.push(1); labels.push(i); }
    for x in distances.values { d.push(x); }
    var merges: ClusterMerge[>..] = [];
    for step in n - 1 {
        var a = -1; var b = -1; var best = 0.0;
        for i in n { if active[i] != 0 { for j in i + 1..n { if active[j] != 0 {
            if a < 0 || d[i * n + j] < best { a = i; b = j; best = d[i * n + j]; }
        } } } }
        merges.push(ClusterMerge { labels[a], labels[b], best });
        for k in n { if active[k] != 0 && k != a && k != b {
            let x = d[a * n + k]; let y = d[b * n + k];
            var v = if method == 's' { min(x, y) } else if method == 'm' { max(x, y) }
                else { x * (sizes[a] as f64 / (sizes[a] + sizes[b])) + y * (sizes[b] as f64 / (sizes[a] + sizes[b])) };
            if method == 'a' { v = clamp(v, min(x, y), max(x, y)); }
            d[a * n + k] = v; d[k * n + a] = v;
        } }
        sizes[a] += sizes[b]; active[b] = 0; labels[a] = n + step;
    }
    return ClusterTree { merges, n, "" };
}

/* Cuts label contiguously by first leaf occurrence; compare partitions by pairwise membership rather
 * than label values. Tree validation rejects invalid child references and reused nodes; keep public
 * tree fields consistent. */
fn cluster_cut(tree: const ClusterTree&, count: i64) -> ClusterCut {
    let n = tree.size;
    if tree.error.len > 0 { return ClusterCut { [], copy(tree.error) }; }
    if n <= 0 || tree.merges.len != n - 1 || count < 1 || count > n { return ClusterCut { [], "invalid cut parameters" }; }
    var reps: i64[>..] = []; var active: i64[>..] = []; var ids: i64[>..] = [];
    for i in n { reps.push(i); active.push(1); ids.push(i); }
    for merge, step in tree.merges {
        let limit = n + step;
        if merge.left < 0 || merge.right < 0 || merge.left >= limit || merge.right >= limit || merge.left == merge.right ||
            !cluster_finite(merge.height) || merge.height < 0 { return ClusterCut { [], "invalid tree" }; }
        if active[merge.left] == 0 || active[merge.right] == 0 { return ClusterCut { [], "reused tree node" }; }
        active[merge.left] = 0; active[merge.right] = 0; active.push(1);
        let a = reps[merge.left]; let b = reps[merge.right]; reps.push(a);
        if step < n - count { for i in n { if ids[i] == b { ids[i] = a; } } }
    }
    var unique: i64[>..] = []; var result: i64[>..] = [];
    for id in ids {
        var label = -1;
        for x, i in unique { if x == id { label = i; } }
        if label < 0 { label = unique.len; unique.push(id); }
        result.push(label);
    }
    return ClusterCut { result, "" };
}

/* Includes merges at or below a finite nonnegative threshold. Merge heights must be monotone.
 */
fn cluster_cut_height(tree: const ClusterTree&, height: f64) -> ClusterCut {
    if !cluster_finite(height) || height < 0 { return ClusterCut { [], "invalid cut height" }; }
    var count = tree.size; var previous = 0.0;
    for merge in tree.merges {
        if merge.height < previous { return ClusterCut { [], "nonmonotone tree heights" }; }
        previous = merge.height;
        if merge.height <= height { count -= 1; }
    }
    return cluster_cut(tree, count);
}
