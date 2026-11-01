import bio from "..";
import bio.stats.clustering;
import math;
fn main() {
    let d = bio::cluster_distances([0.0, 100.0, 2.0, 900.0], [1, 0, 1, 0], 2, 2, [3.0, 0.0]);
    assert(d.error.len == 0 && d.values[1] == 4);
    let missing = bio::cluster_distances([log(-1.0), 2.0], [0, 1], 2, 1, [1.0]);
    assert(missing.error.len == 0 && missing.values[1] == 0);
    assert(bio::cluster_distances([log(-1.0)], [1], 1, 1, [1.0]).error.len > 0);
    assert(bio::cluster_distances([1.0], [1], 1, 1, [-1.0]).error.len > 0);
    assert(bio::cluster_distances([1.0], [1], 1, 1, [0.0]).error.len > 0);
    assert(bio::cluster_distances([1.0], [1], 1, 1, [log(0.0)]).error.len > 0);
    assert(bio::cluster_distances([1.0], [1], 2, 1, [1.0]).error.len > 0);
    assert(bio::cluster_distances([1.0], [], 1, 1, [1.0]).error.len > 0);
    assert(bio::cluster_distances([1e308, -1e308], [1, 1], 2, 1, [1.0]).error.len > 0);
    let c = bio::cluster_centroids([1.0, 99.0, 3.0, 99.0], [1, 0, 1, 0], 2, 2, [0, 0], 1, 'm');
    assert(c.error.len == 0 && c.values[0] == 2 && c.mask[0] == 1 && c.mask[1] == 0 && c.values[1] == 0);
    assert(bio::cluster_centroids([1.0, 2.0], [1, 1], 2, 1, [0, 0], 2, 'a').error.len > 0);
    assert(bio::cluster_centroids([1.0], [1], 1, 1, [-1], 1, 'a').error.len > 0);
    let ties = bio::cluster_distances([0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1], 4, 1, [1.0]);
    for method in ['s', 'm', 'a'] {
        let t = bio::cluster_linkage(ties, method as u8);
        assert(t.error.len == 0 && t.merges.len == 3);
        assert(t.merges[0].left == 0 && t.merges[0].right == 1);
        assert(t.merges[1].left == 4 && t.merges[1].right == 2);
        let cut = bio::cluster_cut(t, 2);
        assert(cut.error.len == 0 && cut.ids[0] == cut.ids[2] && cut.ids[0] != cut.ids[3]);
        let byheight = bio::cluster_cut_height(t, 0);
        assert(byheight.error.len == 0 && byheight.ids[0] == byheight.ids[3]);
        assert(bio::cluster_cut(t, 0).error.len > 0);
    }
    let one = bio::cluster_distances([1.0], [1], 1, 1, [1.0]);
    let separated = bio::cluster_distances([0.0, 2.0, 10.0], [1, 1, 1], 3, 1, [1.0]);
    let single = bio::cluster_linkage(separated, 's');
    let complete = bio::cluster_linkage(separated, 'm');
    let average = bio::cluster_linkage(separated, 'a');
    assert(single.merges[1].height == 64 && complete.merges[1].height == 100);
    assert(average.merges[1].height == 82);
    let before = bio::cluster_cut_height(average, 3.9);
    let exact = bio::cluster_cut_height(average, 4);
    let after = bio::cluster_cut_height(average, 82);
    assert(before.ids[0] != before.ids[1]);
    assert(exact.ids[0] == exact.ids[1] && exact.ids[0] != exact.ids[2]);
    assert(after.ids[0] == after.ids[2]);
    let singleton = bio::cluster_linkage(one, 'a');
    assert(singleton.error.len == 0 && bio::cluster_cut(singleton, 1).ids[0] == 0);
    let asymmetric = bio::ClusterDistances { [0, 1, 2, 0], 2, "" };
    assert(bio::cluster_linkage(asymmetric, 'a').error.len > 0);
    assert(bio::cluster_linkage(d, 'x').error.len > 0);
    let bad = bio::ClusterTree { [bio::ClusterMerge { 0, 0, 1 }], 2, "" };
    assert(bio::cluster_cut(bad, 1).error.len > 0);
    assert(bio::cluster_cut_height(singleton, log(-1.0)).error.len > 0);
    let level = 1.9983942017714307;
    var tied_values: f64[>..] = [];
    for i in 4 { for j in 4 { tied_values.push(if i == j { 0.0 } else { level }); } }
    let tied_distances = bio::ClusterDistances { copy(tied_values), 4, "" };
    let tied_tree = bio::cluster_linkage(tied_distances, 'a');
    assert(tied_tree.error.len == 0);
    for merge in tied_tree.merges { assert(merge.height == level); }
    let tied_cut = bio::cluster_cut_height(tied_tree, 3.0);
    assert(tied_cut.error.len == 0);
    for id in tied_cut.ids { assert(id == tied_cut.ids[0]); }
    print("clustering: passed");
}
