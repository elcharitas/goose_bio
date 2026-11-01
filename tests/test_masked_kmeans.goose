// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio from "..";
import bio.stats.masked_kmeans;
import math;
fn failed(r: bio::MaskedKCluster) {
    assert(r.error.len > 0 && r.labels.len == 0 && r.centroids.len == 0);
    assert(r.centroid_mask.len == 0 && r.nfound == 0 && r.passes == 0);
}
fn main() {
    let data:    f64[] = [0, 1, 2, 100, 101]; let mask: i64[] = [1, 1, 1, 1, 1];
    let initial: i64[] = [0, 0, 0, 0, 1];
    let r = bio::masked_kcluster(data, mask, 5, 1, [1.0], initial, 2, 'a', 'e', false, 100, 1000000);
    assert(r.error.len == 0 && r.nfound == 1);
    for i in 3 { assert(r.labels[i] == 0); }
    assert(r.labels[3] == 1 && r.labels[4] == 1);
    let ties = bio::masked_kcluster([2.0, 2, 2, 2], [1, 1, 1, 1], 4, 1, [1.0], [1, 0, 1, 0], 2, 'm', 'e', false, 10, 100000);
    assert(ties.error.len == 0 && ties.objective == 0 && ties.passes == 1);
    assert(ties.labels[0] == 1 && ties.labels[1] == 0);
    let missing = bio::masked_kcluster([log(-1.0), 3.0], [0, 0], 2, 1, [0.0], [0, 1], 2, 'a', 'e', false, 2, 1000);
    assert(missing.error.len == 0 && missing.final_objective == 0);
    assert(missing.centroid_mask[0] == 0);
    failed(bio::masked_kcluster(data, mask, 5, 1, [1.0], initial, 2, 'a', 'e', false, 1, 100000));
    failed(bio::masked_kcluster(data, mask, 5, 1, [1.0], initial, 2, 'a', 'e', false, 100, 1));
    failed(bio::masked_kcluster(data, mask, 5, 1, [1.0], [0, 0, 0, 0, 0], 2, 'a', 'e', false, 100, 100000));
    failed(bio::masked_kcluster(data, mask, 5, 1, [1.0], [0, 0, 0, 0, 2], 2, 'a', 'e', false, 100, 100000));
    failed(bio::masked_kcluster(data, mask, 5, 1, [1.0], [], 2, 'a', 'e', false, 100, 100000));
    for method in ['x', 'a'] { for dist in ['e', 'b'] {
        if method == 'a' && dist == 'e' { continue; }
        failed(bio::masked_kcluster(data, mask, 5, 1, [1.0], initial, 2, method as u8, dist as u8, false, 100, 100000));
    } }
    for weight in [-1.0, log(-1.0), log(0.0)] {
        failed(bio::masked_kcluster(data, mask, 5, 1, [weight], initial, 2, 'a', 'e', false, 100, 100000));
    }
    failed(bio::masked_kcluster([log(-1.0)], [1], 1, 1, [1.0], [0], 1, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1.0], [2], 1, 1, [1.0], [0], 1, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1.0], [], 1, 1, [1.0], [0], 1, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1.0], [1], 4097, 1, [1.0], [0], 1, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1.0], [1], 1, 65, [1.0], [0], 1, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1.0], [1], 1, 1, [1.0], [0], 257, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1.0], [1], 1, 1, [1.0], [0], 1, 'a', 'e', false, 10001, 10000));
    failed(bio::masked_kcluster([1e308, 1e308], [1, 1], 2, 1, [1.0], [0, 0], 1, 'a', 'e', false, 10, 10000));
    failed(bio::masked_kcluster([1e308, -1e308, 0.0], [1, 1, 1], 3, 1, [1.0], [0, 0, 1], 2, 'a', 'e', false, 10, 10000));
    print("masked kcluster focused: passed");
}
