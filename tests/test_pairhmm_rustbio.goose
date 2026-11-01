// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio from "..";
import bio.stats.pairhmm_rustbio;
import math;
fn main() {
    let z = log(0.0);
    assert(bio::rustbio_pairhmm_checked(-1, 0, [], [], [], z, z, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(4000000, 4000000, [], [], [], z, z, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(1, 1, [], [0.0], [0.0], z, z, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(0, 0, [], [], [], 0.0, 0.0, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(0, 0, [], [], [], 0.0 / 0.0, z, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(1, 1, [1.0], [0.0], [0.0], z, z, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(1, 1, [-1e308], [0.0], [0.0], z, z, z, z, [], false, false, true).error.len > 0);
    assert(bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], z, z, z, z, [0.0, 0.0], false, false, true).error.len > 0);
    assert(bio::rbph_three(0.0, -10.001, z, true) == 0.0);
    assert(bio::rbph_three(0.0, -10.0, z, true) > 0.0);
    assert(bio::rbph_three(0.0, -9.999, z, true) > 0.0);
    assert(bio::rbph_three(0.0, -10.001, z, false) > 0.0);
    assert(abs(bio::rbph_add(0.0, -46.051701859880914) - 1e-20) < 1e-34);
    assert(abs(bio::rbph_three(0.0, -46.051701859880914, z, false) - 1e-20) < 1e-34);
    let regression = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0],
        -1e-20, -46.74484904044086, z, z, [], false, false, false);
    assert(regression.error.len == 0);
    assert(abs(regression.log_probability - (-46.74484904044086)) < 2e-12);
    let tiny = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, z, z, z, [], false, false, false);
    assert(tiny.error.len == 0);
    assert(abs(tiny.log_probability - log(1e-20)) < 1e-12);
}
