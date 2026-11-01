// Copyright (c) 2026 Jonathan Irhodia. MIT license.
namespace bio;
import math;

/* Labels are cluster numbers, not medoid row indexes. Centroids are cluster-major, including
 * transpose; missing features have mask zero. Each centroid observation has equal weight. objective is
 * the last-pass cost using frozen centroids and excludes singletons. final_objective recomputes all
 * items from final centroids, so costs may differ. nfound is one on success. */
struct MaskedKCluster {
    labels:    i64[], objective: f64, nfound: i64,
    centroids: f64[], centroid_mask: i64[], final_objective: f64,
    passes:    i64, error: u8[],
}
fn mk_fail(message: const u8[:]) -> MaskedKCluster {
    var text: u8[>..] = []; for c in message { text.push(c); }
    return MaskedKCluster { [], 0, 0, [], [], 0, 0, text };
}
fn mk_finite(x: f64) -> bool { !is_nan(x) && !is_inf(x) }

/* Methods a/m use arithmetic means/medians. Means sum then divide; medians sort observations. Sums,
 * midpoint addition, distances, and costs must stay finite: extreme finite data can reject. No
 * arbitrary precision or universal floating-point equivalence. */
struct MKCenters { values: f64[], mask: i64[], error: u8[] }

/* Transpose clusters physical columns with one weight per physical row. No random restarts, other
 * metrics, SOM, centroid linkage. */
fn mk_centers(data: const f64[:], mask: const i64[:], n: i64,
    p: i64, ids: const i64[:], k: i64, method: u8) -> MKCenters {
    var values: f64[>..] = []; var masks: i64[>..] = [];
    for c in k { for f in p {
        var observed: f64[>..] = []; var sum = 0.0;
        for i in n { if ids[i] == c && mask[i * p + f] != 0 {
            let x = data[i * p + f]; observed.push(x);
            if method == 'a' { sum += x; }
        } }
        var value = 0.0;
        if observed.len > 0 {
            if method == 'a' { value = sum / observed.len; }
            else {
                for i in observed.len { var j = i;
                    while j > 0 && observed[j] < observed[j - 1] {
                        let x = observed[j]; observed[j] = observed[j - 1];
                        observed[j - 1] = x; j -= 1;
                    }
                }
                let mid = observed.len / 2;
                value = if observed.len % 2 == 1 { observed[mid] }
                    else { (observed[mid - 1] + observed[mid]) / 2 };
            }
        }
        if !mk_finite(value) { return MKCenters { [], [], "centroid overflow" }; }
        values.push(value); masks.push(if observed.len > 0 { 1 } else { 0 });
    } }
    return MKCenters { values, masks, "" };
}

/* Distance e is weighted mean squared difference over common observed features, without square root.
 * No common observations or zero common weight gives zero. Weights are finite/nonnegative, including
 * all-zero weights; only observed data must be finite. Masks must be binary. */
fn mk_distance(data: const f64[:], mask: const i64[:], p: i64,
    weights: const f64[:], centers: const MKCenters&, i: i64, c: i64) -> f64 {
    var sum = 0.0; var weight = 0.0;
    for f in p { if mask[i * p + f] != 0 && centers.mask[c * p + f] != 0 {
        let d = data[i * p + f] - centers.values[c * p + f];
        sum += weights[f] * d * d; weight += weights[f];
    } }
    if !mk_finite(sum) { return sum; }
    return if weight > 0 { sum / weight } else { 0.0 };
}
// objective is Bio's last pass cost, not final-centroid SSE.

/* Flat row-major data use required initial labels with every cluster occupied. Inputs remain
 * unchanged on success or failure. One deterministic run uses supplied initial labels: freeze
 * centroids each pass, visit items in input order, update counts immediately after strictly
 * improving moves, and skip the original cluster even after moving. Equal distances retain
 * assignment; singletons cannot move. This is not batch Lloyd assignment and is not order-invariant. */
fn masked_kcluster(data: const f64[:], mask: const i64[:], rows: i64,
    columns:  i64, weights: const f64[:], initial: const i64[:],
    clusters: i64, method: u8, dist: u8, transpose: bool,
    max_passes: i64, work_budget: i64) -> MaskedKCluster {
    let n = if transpose { columns } else { rows };
    let p = if transpose { rows } else { columns };
    /* Limits: 4096 items, 64 features, 256 clusters, 10000 passes, and caller budget <=100000000 work
     * units. Conservative charges cover centroid scans, distance features, and median insertion sorting.
     * Each pass and final recomputation needs full prepayment; exhaustion returns empty error arrays,
     * never partial convergence. Dimension caps bound copies. */
    if n <= 0 || n > 4096 || p <= 0 || p > 64 || clusters <= 0 ||
        clusters > 256 || clusters > n || max_passes <= 0 ||
        max_passes > 10000 || work_budget <= 0 || work_budget > 100000000 {
        return mk_fail("limit or dimension error");
    }
    if data.len != n * p || mask.len != data.len || weights.len != p ||
        initial.len != n || (method != 'a' && method != 'm') || dist != 'e' {
        return mk_fail("shape or option error");
    }
    for x, i in data {
        if mask[i] != 0 && mask[i] != 1 { return mk_fail("mask must be binary"); }
        if mask[i] != 0 && !mk_finite(x) { return mk_fail("nonfinite observation"); }
    }
    var weight_sum = 0.0;
    for w in weights {
        if !mk_finite(w) || w < 0 { return mk_fail("invalid weight"); }
        weight_sum += w;
    }
    if !mk_finite(weight_sum) { return mk_fail("weight overflow"); }
    var counts: i64[>..] = []; for c in clusters { counts.push(0); }
    for id in initial {
        if id < 0 || id >= clusters { return mk_fail("invalid label"); }
        counts[id] += 1;
    }
    for count in counts { if count == 0 { return mk_fail("empty initial cluster"); } }
    var values: f64[>..] = []; var masks: i64[>..] = [];
    for i in n { for f in p {
        let offset = if transpose { f * columns + i } else { i * p + f };
        values.push(data[offset]); masks.push(mask[offset]);
    } }
    var ids: i64[>..] = []; for id in initial { ids.push(id); }
    var saved = copy(ids);
    var period = 10; var counter = 0; var total = 1.7976931348623157e308;
    var work = 0;
    // Charge worst-case insertion sorting as well as distance work.
    let pass_work = n * p * clusters + n * clusters * p +
        (if method == 'm' { n * n * p } else { n * p }) + n;
    /* Stops on nondecreasing pass cost or recurrence of saved labels. Saves when counter modulo period is
     * zero, starting counter zero and period ten, then doubles the period. The stopping pass remains
     * without rollback. */
    while counter < max_passes {
        if pass_work > work_budget - work { return mk_fail("work budget exhausted"); }
        work += pass_work;
        let previous = total; total = 0.0;
        if counter % period == 0 { saved = copy(ids); period *= 2; }
        counter += 1;
        let centers = mk_centers(values, masks, n, p, ids, clusters, method);
        if centers.error.len > 0 { return mk_fail(centers.error); }
        for i in n {
            let old = ids[i];
            if counts[old] == 1 { continue; }
            var distance = mk_distance(values, masks, p, weights, centers, i, old);
            if !mk_finite(distance) { return mk_fail("distance overflow"); }
            for c in clusters {
                if c == old { continue; }
                let d = mk_distance(values, masks, p, weights, centers, i, c);
                if !mk_finite(d) { return mk_fail("distance overflow"); }
                if d < distance {
                    distance = d; counts[ids[i]] -= 1;
                    ids[i] = c; counts[c] += 1;
                }
            }
            total += distance;
        }
        if !mk_finite(total) { return mk_fail("cost overflow"); }
        var same = true;
        for id, i in ids { if id != saved[i] { same = false; } }
        if total >= previous || same {
            if pass_work > work_budget - work { return mk_fail("work budget exhausted"); }
            let final = mk_centers(values, masks, n, p, ids, clusters, method);
            if final.error.len > 0 { return mk_fail(final.error); }
            var objective = 0.0;
            for id, i in ids {
                let d = mk_distance(values, masks, p, weights, final, i, id);
                if !mk_finite(d) { return mk_fail("distance overflow"); }
                objective += d;
            }
            if !mk_finite(objective) { return mk_fail("cost overflow"); }
            return MaskedKCluster { ids, total, 1, copy(final.values), copy(final.mask),
                objective, counter, "" };
        }
    }
    return mk_fail("pass limit exhausted");
}
