// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio from "..";
import bio.stats.pairhmm_rustbio;
import math;
fn main() {
    let z = log(0.0);
    assert(bio::rustbio_pairhmm_pruned_checked(-1,0,[],[],[],z,z,z,z,[],false,false,false,[],true,0).error.len > 0);
    assert(bio::rustbio_pairhmm_pruned_checked(4000000,4000000,[],[],[],z,z,z,z,[],false,false,false,[],true,0).error.len > 0);
    assert(bio::rustbio_pairhmm_pruned_checked(0,0,[],[],[],z,z,z,z,[],false,false,false,[],false,-1).error.len > 0);
    assert(bio::rustbio_pairhmm_pruned_checked(1,1,[0.0],[0.0],[0.0],z,z,z,z,[],false,false,false,[],true,0).error.len > 0);
    assert(bio::rustbio_pairhmm_pruned_checked(1,1,[0.0],[0.0],[0.0],z,z,z,z,[],false,false,false,[-1],true,0).error.len > 0);
    assert(bio::rustbio_pairhmm_pruned_checked(1,1,[0.0],[0.0],[0.0],z,z,z,z,[],false,false,false,[2],false,0).error.len > 0);
    assert(bio::rbph_distance_next(9223372036854775807) == 9223372036854775807);
    let tiny = bio::rustbio_pairhmm_pruned_checked(1,1,[0.0],[0.0],[0.0],-1e-20,-46.74484904044086,z,z,[],false,false,false,[1],true,0);
    assert(tiny.error.len == 0);
    assert(abs(tiny.log_probability-(-46.74484904044086)) < 2e-12);
    let matched = bio::rustbio_pairhmm_pruned_checked(2,2,[-1.0,-1.0,-1.0,-1.0],[-1.0,-1.0],[-1.0,-1.0],z,z,z,z,[],false,false,false,[0,0,0,0],true,0);
    let mismatch = bio::rustbio_pairhmm_pruned_checked(2,2,[-1.0,-1.0,-1.0,-1.0],[-1.0,-1.0],[-1.0,-1.0],z,z,z,z,[],false,false,false,[1,1,1,1],true,0);
    assert(matched.log_probability == -2.0);
    assert(mismatch.log_probability == z);
    assert(matched.scanned_cells == mismatch.scanned_cells);
}
