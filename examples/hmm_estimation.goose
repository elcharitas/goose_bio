import bio from "..";
import bio.stats.hmm_estimation;
import math;
fn main() {
    let obs: i64[6] = [0,1,0,1,1,0];
    let offsets: i64[3] = [0,3,6];
    let pi: f64[2] = [log(0.6),log(0.4)];
    let a: f64[4] = [log(0.7),log(0.3),log(0.4),log(0.6)];
    let e: f64[4] = [log(0.8),log(0.2),log(0.3),log(0.7)];
    let terminal: f64[2] = [0.0,0.0];
    let fit = bio::hmm_train_batch(obs,offsets,pi,a,e,2,terminal,5,1e-8);
    assert(fit.error.len == 0 && fit.updates > 0);
    print(fit.updates); print(fit.likelihood); print(fit.converged);
}
