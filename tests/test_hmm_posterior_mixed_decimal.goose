// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.stats.hmm_posterior;
import math;
fn near(a: f64, b: f64) { if is_inf(b) { assert(a == b); } else { assert(abs(a - b) <= 1e-10 * (1.0 + abs(b))); } }
fn main() {
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5312093733737563, 0.46879062662624377, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5926665999540698, 0.4073334000459302, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5312093733737563, 0.0, 0.46879062662624377];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5926665999540698, 0.0, 0.4073334000459302];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.46879062662624377, 0.5312093733737563, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.4073334000459302, 0.5926665999540698, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.46879062662624377, 0.0, 0.5312093733737563];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.4073334000459302, 0.0, 0.5926665999540698];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5312093733737563, 0.46879062662624377];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5926665999540698, 0.4073334000459302];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.46879062662624377, 0.5312093733737563];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.4073334000459302, 0.5926665999540698];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.7310585786300049, 0.2689414213699951, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9525741268224333, 0.04742587317756678, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.7310585786300049, 0.0, 0.2689414213699951];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9525741268224333, 0.0, 0.04742587317756678];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.2689414213699951, 0.7310585786300049, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.04742587317756678, 0.9525741268224333, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.2689414213699951, 0.0, 0.7310585786300049];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.04742587317756678, 0.0, 0.9525741268224333];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.7310585786300049, 0.2689414213699951];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.9525741268224333, 0.04742587317756678];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.2689414213699951, 0.7310585786300049];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.04742587317756678, 0.9525741268224333];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9990889488055994, 0.0009110511944006454, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.999999999241744, 7.582560422162384e-10, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9990889488055994, 0.0, 0.0009110511944006454];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.999999999241744, 0.0, 7.582560422162384e-10];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0009110511944006454, 0.9990889488055994, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, -1e+16, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, -100000000.0, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [7.582560422162384e-10, 0.999999999241744, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0009110511944006454, 0.0, 0.9990889488055994];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+16, 0.0, -1e+16];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-100000000.0, 0.0, log(0.0), 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [7.582560422162384e-10, 0.0, 0.999999999241744];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.9990889488055994, 0.0009110511944006454];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.999999999241744, 7.582560422162384e-10];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len == 0);
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.0009110511944006454, 0.9990889488055994];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+16, -1e+16];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -100000000.0, 0.0, -100000000.0, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 7.582560422162384e-10, 0.999999999241744];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5312093733737563, 0.46879062662624377, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5926665999540698, 0.4073334000459302, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5312093733737563, 0.0, 0.46879062662624377];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5926665999540698, 0.0, 0.4073334000459302];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.46879062662624377, 0.5312093733737563, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.4073334000459302, 0.5926665999540698, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.46879062662624377, 0.0, 0.5312093733737563];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.4073334000459302, 0.0, 0.5926665999540698];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5312093733737563, 0.46879062662624377];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5926665999540698, 0.4073334000459302];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.46879062662624377, 0.5312093733737563];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.4073334000459302, 0.5926665999540698];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.7310585786300049, 0.2689414213699951, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
        assert(got.error.len > 0);
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9525741268224333, 0.04742587317756678, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.7310585786300049, 0.0, 0.2689414213699951];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9525741268224333, 0.0, 0.04742587317756678];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.2689414213699951, 0.7310585786300049, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.04742587317756678, 0.9525741268224333, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.2689414213699951, 0.0, 0.7310585786300049];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.04742587317756678, 0.0, 0.9525741268224333];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.7310585786300049, 0.2689414213699951];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.9525741268224333, 0.04742587317756678];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.2689414213699951, 0.7310585786300049];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.04742587317756678, 0.9525741268224333];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9990889488055994, 0.0009110511944006454, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.999999999241744, 7.582560422162384e-10, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9990889488055994, 0.0, 0.0009110511944006454];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.999999999241744, 0.0, 7.582560422162384e-10];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0009110511944006454, 0.9990889488055994, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, -1e+100, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, -1e+50, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [7.582560422162384e-10, 0.999999999241744, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0009110511944006454, 0.0, 0.9990889488055994];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+100, 0.0, -1e+100];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+50, 0.0, log(0.0), 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [7.582560422162384e-10, 0.0, 0.999999999241744];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.9990889488055994, 0.0009110511944006454];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.999999999241744, 7.582560422162384e-10];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.0009110511944006454, 0.9990889488055994];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+100, -1e+100];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+50, 0.0, -1e+50, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 7.582560422162384e-10, 0.999999999241744];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5312093733737563, 0.46879062662624377, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5926665999540698, 0.4073334000459302, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5312093733737563, 0.0, 0.46879062662624377];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5926665999540698, 0.0, 0.4073334000459302];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.46879062662624377, 0.5312093733737563, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.4073334000459302, 0.5926665999540698, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.46879062662624377, 0.0, 0.5312093733737563];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-0.125, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.4073334000459302, 0.0, 0.5926665999540698];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5312093733737563, 0.46879062662624377];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -0.125];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5926665999540698, 0.4073334000459302];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.46879062662624377, 0.5312093733737563];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -0.125, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.4073334000459302, 0.5926665999540698];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.7310585786300049, 0.2689414213699951, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9525741268224333, 0.04742587317756678, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.7310585786300049, 0.0, 0.2689414213699951];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9525741268224333, 0.0, 0.04742587317756678];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.2689414213699951, 0.7310585786300049, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.04742587317756678, 0.9525741268224333, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.2689414213699951, 0.0, 0.7310585786300049];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-1.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.04742587317756678, 0.0, 0.9525741268224333];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.7310585786300049, 0.2689414213699951];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -1.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.9525741268224333, 0.04742587317756678];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.2689414213699951, 0.7310585786300049];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -1.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.04742587317756678, 0.9525741268224333];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9990889488055994, 0.0009110511944006454, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.999999999241744, 7.582560422162384e-10, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.9990889488055994, 0.0, 0.0009110511944006454];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.999999999241744, 0.0, 7.582560422162384e-10];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.5, 0.0];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0009110511944006454, 0.9990889488055994, 0.0];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, -1e+300, 0.0];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, -1e+150, 0.0, log(0.0), 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [7.582560422162384e-10, 0.999999999241744, 0.0];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.5, 0.0, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0009110511944006454, 0.0, 0.9990889488055994];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [-1e+300, 0.0, -1e+300];
        let a:   f64[9] = [-7.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [-1e+150, 0.0, log(0.0), 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [7.582560422162384e-10, 0.0, 0.999999999241744];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.9990889488055994, 0.0009110511944006454];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), 0.0, log(0.0), log(0.0), log(0.0), -7.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.999999999241744, 7.582560422162384e-10];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.5, 0.5];
            assert(got.posterior.len == 3);
            for row in 1 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[2] = [0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 0.0009110511944006454, 0.9990889488055994];
            assert(got.posterior.len == 6);
            for row in 2 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    {
        let o:   i64[4] = [0, 0, 0, 0];
        let i:   f64[3] = [0.0, -1e+300, -1e+300];
        let a:   f64[9] = [0.0, log(0.0), log(0.0), log(0.0), -7.0, log(0.0), log(0.0), log(0.0), 0.0];
        let e:   f64[6] = [log(0.0), 0.0, -1e+150, 0.0, -1e+150, 0.0];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        if got.error.len > 0 {
            assert(!got.defined && got.alpha.len == 0 && got.beta.len == 0 && got.posterior.len == 0);
        } else {
            assert(got.defined);
            let expected: f64[3] = [0.0, 7.582560422162384e-10, 0.999999999241744];
            assert(got.posterior.len == 12);
            for row in 4 { for s in 3 { near(got.posterior[row * 3 + s], expected[s]); } }
        }
    }
    print("162 Decimal mixed-scale cases passed");
}
