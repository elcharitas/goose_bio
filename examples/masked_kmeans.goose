import bio from "..";
import bio.stats.masked_kmeans;
fn main() {
    let result = bio::masked_kcluster([0.0, 1, 2, 100, 101], [1, 1, 1, 1, 1],
        5, 1, [1.0], [0, 0, 0, 0, 1], 2, 'a', 'e', false, 100, 1000000);
    assert(result.error.len == 0);
    assert(result.labels[0] == 0 && result.labels[4] == 1);
    print(result.labels);
    print(result.final_objective);
}
