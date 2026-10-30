import bio from "..";
import bio.stats.multivariate;
import bio.stats.clustering;
import math;
fn main() {
    let p = bio::cluster_pca([1.0,2.0,3.0,4.0,5.0,6.0],3,2,100);
    assert(p.error.len == 0 && p.rank_size == 2);
    assert(abs(p.singular_values[0]-4.0) < 1e-12);
    assert(p.singular_values[1] < 1e-12);
    for r in 3 { for c in 2 {
        var x = p.mean[c]; for k in 2 { x += p.coordinates[r*2+k]*p.components[k*2+c]; }
        assert(abs(x-(r*2+c+1)) < 1e-12);
    } }
    assert(bio::cluster_pca([1.0],1,1,100).error.len == 0);
    assert(bio::cluster_pca([0.0,0.0],1,2,100).error.len == 0);
    assert(bio::cluster_pca([1e-200],1,1,100).error.len > 0);
    assert(bio::cluster_pca([1e200],1,1,100).error.len > 0);
    assert(bio::cluster_pca([log(-1.0)],1,1,100).error.len > 0);
    assert(bio::cluster_pca([1.0],2,1,100).error.len > 0);
    assert(bio::cluster_pca([1.0],1,1,0).error.len > 0);
    assert(bio::cluster_pca([1.0,3.0,4.0,7.0,2.0,9.0],3,2,1).error.len > 0);
    assert(bio::cluster_pca([1.0,1e-300],2,1,100).error.len > 0);
    let d = bio::cluster_distances([0.0,1.0,10.0,11.0],[1,1,1,1],4,1,[1.0]);
    let m = bio::cluster_kmedoids(d,[0,0,1,1],2,100);
    assert(m.error.len == 0 && m.objective == 2);
    assert(m.ids[0] == 0 && m.ids[1] == 0 && m.ids[2] == 2 && m.ids[3] == 2);
    assert(bio::cluster_kmedoids(d,[0,0,0,0],2,100).error.len > 0);
    assert(bio::cluster_kmedoids(d,[0,0,1,2],2,100).error.len > 0);
    assert(bio::cluster_kmedoids(d,[0,1,0,1],2,1).error.len > 0);
    let bad = bio::ClusterDistances {[0.0,1e-200,1e-200,0.0],2,""};
    assert(bio::cluster_kmedoids(bad,[0,1],2,10).error.len > 0);
    let z = bio::cluster_distances([0.0,0.0,0.0],[1,1,1],3,1,[1.0]);
    let tied = bio::cluster_kmedoids(z,[0,1,1],2,100);
    assert(tied.error.len == 0 && tied.ids[0] == 0 && tied.ids[1] == 1 && tied.ids[2] == 0);
}
