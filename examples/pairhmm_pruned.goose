import bio from "..";
import bio.stats.pairhmm_rustbio;
import math;
fn main() {
    let z = log(0.0);
    let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-1.0], [-1.0], [-1.0],
        z, z, z, z, [], false, false, false, [1], true, 0);
    assert(r.error.len == 0);
    assert(r.log_probability == -1.0);
    assert(r.scanned_cells == 1 && r.admitted_cells == 1);
}
