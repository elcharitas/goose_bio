import bio from "..";
import bio.stats.hmm_posterior;
import math;
fn main() {
    let obs: i64[2] = [0,1];
    let initial: f64[2] = [log(0.6),log(0.4)];
    let transition: f64[4] = [log(0.7),log(0.3),log(0.4),log(0.6)];
    let emission: f64[4] = [log(0.5),log(0.5),log(0.1),log(0.9)];
    let terminal: f64[0] = [];
    let result = bio::hmm_posterior_log(obs,initial,transition,emission,2,terminal);
    assert(result.error.len == 0 && result.defined);
    print(result.posterior);
}
