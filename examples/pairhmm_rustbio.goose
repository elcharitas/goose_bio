import bio from "..";
import bio.stats.pairhmm_rustbio;
import math;
fn main() {
    let z = log(0.0);
    let result = bio::rustbio_pairhmm_checked(2,2,
        [log(0.9),log(0.1),log(0.1),log(0.9)],
        [0.0,0.0],[0.0,0.0],z,z,z,z,[],false,false,true);
    assert(result.error.len == 0);
    assert(abs(result.log_probability-log(0.81)) < 1e-12);
}
