// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.stats.hmm_posterior;
import math;
fn near(a: f64, b: f64) { if is_inf(a) || is_inf(b) { assert(a == b); } else { assert(abs(a - b) <= 1e-10 * (1.0 + abs(b))); } }
fn main() {
    {
        let o:   i64[1] = [0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.37);
        let alpha: f64[1] = [-0.37];
        let beta:  f64[1] = [0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[1] = [1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.37);
        let alpha: f64[1] = [-0.37];
        let beta:  f64[1] = [0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[1] = [1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[1] = [log(0.0)];
        let beta:  f64[1] = [0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1000.37);
        let alpha: f64[1] = [-1000.37];
        let beta:  f64[1] = [0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[1] = [1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.8400000000000001);
        let alpha: f64[2] = [-0.37, -0.8400000000000001];
        let beta:  f64[2] = [-0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.8400000000000001);
        let alpha: f64[2] = [-0.37, -0.8400000000000001];
        let beta:  f64[2] = [-0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[2] = [log(0.0), log(0.0)];
        let beta:  f64[2] = [-0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2000.8400000000001);
        let alpha: f64[2] = [-1000.37, -2000.8400000000001];
        let beta:  f64[2] = [-1000.47, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.1400000000000001);
        let alpha: f64[3] = [-0.37, -0.8400000000000001, -1.1400000000000001];
        let beta:  f64[3] = [-0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.1400000000000001);
        let alpha: f64[3] = [-0.37, -0.8400000000000001, -1.1400000000000001];
        let beta:  f64[3] = [-0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[3] = [log(0.0), log(0.0), log(0.0)];
        let beta:  f64[3] = [-0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -3001.1400000000003);
        let alpha: f64[3] = [-1000.37, -2000.8400000000001, -3001.1400000000003];
        let beta:  f64[3] = [-2000.77, -1000.3, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.61);
        let alpha: f64[4] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61];
        let beta:  f64[4] = [-1.24, -0.77, -0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.61);
        let alpha: f64[4] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61];
        let beta:  f64[4] = [-1.24, -0.77, -0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[4] = [log(0.0), log(0.0), log(0.0), log(0.0)];
        let beta:  f64[4] = [-1.24, -0.77, -0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -4001.6100000000006);
        let alpha: f64[4] = [-1000.37, -2000.8400000000001, -3001.1400000000003, -4001.6100000000006];
        let beta:  f64[4] = [-3001.24, -2000.77, -1000.47, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.9100000000000001);
        let alpha: f64[5] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61, -1.9100000000000001];
        let beta:  f64[5] = [-1.54, -1.07, -0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[5] = [1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.9100000000000001);
        let alpha: f64[5] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61, -1.9100000000000001];
        let beta:  f64[5] = [-1.54, -1.07, -0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[5] = [1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[5] = [log(0.0), log(0.0), log(0.0), log(0.0), log(0.0)];
        let beta:  f64[5] = [-1.54, -1.07, -0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -5001.910000000001);
        let alpha: f64[5] = [-1000.37, -2000.8400000000001, -3001.1400000000003, -4001.6100000000006, -5001.910000000001];
        let beta:  f64[5] = [-4001.54, -3001.0699999999997, -2000.77, -1000.3, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[5] = [1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2.3800000000000003);
        let alpha: f64[6] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61, -1.9100000000000001, -2.3800000000000003];
        let beta:  f64[6] = [-2.0100000000000002, -1.54, -1.24, -0.77, -0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2.3800000000000003);
        let alpha: f64[6] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61, -1.9100000000000001, -2.3800000000000003];
        let beta:  f64[6] = [-2.0100000000000002, -1.54, -1.24, -0.77, -0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[6] = [log(0.0), log(0.0), log(0.0), log(0.0), log(0.0), log(0.0)];
        let beta:  f64[6] = [-2.0100000000000002, -1.54, -1.24, -0.77, -0.47000000000000003, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -6002.380000000001);
        let alpha: f64[6] = [-1000.37, -2000.8400000000001, -3001.1400000000003, -4001.6100000000006, -5001.910000000001, -6002.380000000001];
        let beta:  f64[6] = [-5002.01, -4001.54, -3001.24, -2000.77, -1000.47, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2.6800000000000006);
        let alpha: f64[7] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61, -1.9100000000000001, -2.3800000000000003, -2.6800000000000006];
        let beta:  f64[7] = [-2.3100000000000005, -1.84, -1.54, -1.07, -0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[7] = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2.6800000000000006);
        let alpha: f64[7] = [-0.37, -0.8400000000000001, -1.1400000000000001, -1.61, -1.9100000000000001, -2.3800000000000003, -2.6800000000000006];
        let beta:  f64[7] = [-2.3100000000000005, -1.84, -1.54, -1.07, -0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[7] = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[1] = [log(0.0)];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-0.17, -0.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[7] = [log(0.0), log(0.0), log(0.0), log(0.0), log(0.0), log(0.0), log(0.0)];
        let beta:  f64[7] = [-2.3100000000000005, -1.84, -1.54, -1.07, -0.77, -0.30000000000000004, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[1] = [-0.2];
        let a:   f64[1] = [-0.13];
        let e:   f64[2] = [-1000.17, -1000.34];
        let end: f64[1] = [-0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -7002.680000000001);
        let alpha: f64[7] = [-1000.37, -2000.8400000000001, -3001.1400000000003, -4001.6100000000006, -5001.910000000001, -6002.380000000001, -7002.680000000001];
        let beta:  f64[7] = [-6002.31, -5001.84, -4001.54, -3001.0699999999997, -2000.77, -1000.3, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[7] = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.07508774039508875);
        let alpha: f64[2] = [-0.37, -0.74];
        let beta:  f64[2] = [0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [0.7445969158274759, 0.25540308417252405];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.15516294973063516);
        let alpha: f64[2] = [-0.37, -0.74];
        let beta:  f64[2] = [0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [0.59145897843278, 0.4085410215672199];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.44);
        let alpha: f64[2] = [log(0.0), -0.74];
        let beta:  f64[2] = [0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [0.0, 1.0];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1000.0750877403951);
        let alpha: f64[2] = [-1000.37, -1000.74];
        let beta:  f64[2] = [0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[2] = [0.7445969158275059, 0.25540308417252156];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.09977802266990043);
        let alpha: f64[4] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234];
        let beta:  f64[4] = [-0.15673831248177716, -0.4167383124817771, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [0.6524894621927443, 0.34751053780725544, 0.7310585786300048, 0.2689414213699952];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.14131553428040367);
        let alpha: f64[4] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234];
        let beta:  f64[4] = [0.08435524446852699, -0.17564475553147296, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [0.6524894621927444, 0.34751053780725555, 0.574442516811659, 0.425557483188341];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.1567383124817772);
        let alpha: f64[4] = [log(0.0), -0.74, -1.47, -1.77];
        let beta:  f64[4] = [-0.15673831248177716, -0.4167383124817771, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [0.0, 1.0, 0.7310585786300049, 0.2689414213699952];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2000.09977802267);
        let alpha: f64[4] = [-1000.37, -1000.74, -2000.4130397101883, -2000.713039710188];
        let beta:  f64[4] = [-1000.1567383124818, -1000.4167383124818, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[4] = [0.6524894621927558, 0.3475105378073027, 0.7310585786300168, 0.2689414213699995];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.05206740467440585);
        let alpha: f64[6] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171];
        let beta:  f64[6] = [-0.0048928851374707705, -0.2648928851374708, 0.01326168751822282, -0.2467383124817772, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.6524894621927445, 0.34751053780725555, 0.6364525402815664, 0.3635474597184337, 0.7310585786300048, 0.2689414213699951];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.29316096162471017);
        let alpha: f64[6] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171];
        let beta:  f64[6] = [0.23620067181283355, -0.023799328187166457, 0.254355244468527, -0.0056447555314730335, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.6524894621927444, 0.34751053780725555, 0.6364525402815663, 0.36354745971843355, 0.5744425168116589, 0.42555748318834097];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.0048928851374708);
        let alpha: f64[6] = [log(0.0), -0.74, -1.47, -1.77, -1.3181545726556938, -1.6181545726556936];
        let beta:  f64[6] = [-0.0048928851374707705, -0.2648928851374708, 0.01326168751822282, -0.2467383124817772, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.0, 1.0, 0.6364525402815663, 0.3635474597184337, 0.7310585786300048, 0.26894142136999505];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2999.9479325953257);
        let alpha: f64[6] = [-1000.37, -1000.74, -2000.4130397101883, -2000.713039710188, -3000.261194282844, -3000.561194282844];
        let beta:  f64[6] = [-2000.0048928851375, -2000.2648928851374, -999.9867383124817, -1000.2467383124817, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.6524894621926075, 0.3475105378073027, 0.6364525402815552, 0.3635474597184471, 0.7310585786300168, 0.2689414213699995];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.03391283201871231);
        let alpha: f64[8] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108];
        let beta:  f64[8] = [-0.023047457793164527, -0.2830474577931643, -0.0048928851374707705, -0.2648928851374708, -0.15673831248177716, -0.4167383124817771, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[8] = [0.6524894621927444, 0.34751053780725544, 0.6364525402815663, 0.3635474597184336, 0.6364525402815662, 0.3635474597184336, 0.7310585786300048, 0.2689414213699951];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.2750063889690164);
        let alpha: f64[8] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108];
        let beta:  f64[8] = [0.2180460991571398, -0.041953900842860214, 0.23620067181283355, -0.023799328187166457, 0.08435524446852699, -0.17564475553147296, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[8] = [0.6524894621927445, 0.34751053780725555, 0.6364525402815663, 0.3635474597184336, 0.6364525402815663, 0.3635474597184336, 0.574442516811659, 0.42555748318834097];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.0230474577931645);
        let alpha: f64[8] = [log(0.0), -0.74, -1.47, -1.77, -1.3181545726556938, -1.6181545726556936, -1.3363091453113873, -1.6363091453113874];
        let beta:  f64[8] = [-0.023047457793164527, -0.2830474577931643, -0.0048928851374707705, -0.2648928851374708, -0.15673831248177716, -0.4167383124817771, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[8] = [0.0, 1.0, 0.6364525402815663, 0.3635474597184336, 0.6364525402815663, 0.3635474597184336, 0.7310585786300049, 0.26894142136999527];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -3999.9660871679816);
        let alpha: f64[8] = [-1000.37, -1000.74, -2000.4130397101883, -2000.713039710188, -3000.261194282844, -3000.561194282844, -4000.2793488555, -4000.5793488554996];
        let beta:  f64[8] = [-3000.0230474577934, -3000.283047457793, -2000.0048928851375, -2000.2648928851374, -1000.1567383124818, -1000.4167383124818, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[8] = [0.6524894621929042, 0.3475105378073027, 0.6364525402815552, 0.3635474597186124, 0.6364525402815552, 0.3635474597184471, 0.7310585786300168, 0.2689414213701218];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.18575825936301849);
        let alpha: f64[10] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108, -0.12750342815520432, -0.42750342815520437];
        let beta:  f64[10] = [0.12879796955114187, -0.13120203044885814, 0.1469525422068354, -0.11304745779316439, -0.0048928851374707705, -0.2648928851374708, 0.01326168751822282, -0.2467383124817772, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[10] = [0.6524894621927445, 0.34751053780725555, 0.6364525402815665, 0.36354745971843355, 0.6364525402815665, 0.3635474597184336, 0.6364525402815665, 0.3635474597184337, 0.7310585786300049, 0.2689414213699952];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.4268518163133228);
        let alpha: f64[10] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108, -0.12750342815520432, -0.42750342815520437];
        let beta:  f64[10] = [0.3698915265014462, 0.10989152650144618, 0.3880460991571397, 0.12804609915713971, 0.23620067181283355, -0.023799328187166457, 0.254355244468527, -0.0056447555314730335, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[10] = [0.6524894621927445, 0.34751053780725544, 0.6364525402815663, 0.3635474597184336, 0.6364525402815663, 0.3635474597184336, 0.6364525402815663, 0.3635474597184336, 0.574442516811659, 0.42555748318834097];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.8712020304488581);
        let alpha: f64[10] = [log(0.0), -0.74, -1.47, -1.77, -1.3181545726556938, -1.6181545726556936, -1.3363091453113873, -1.6363091453113874, -1.184463717967081, -1.484463717967081];
        let beta:  f64[10] = [0.12879796955114187, -0.13120203044885814, 0.1469525422068354, -0.11304745779316439, -0.0048928851374707705, -0.2648928851374708, 0.01326168751822282, -0.2467383124817772, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[10] = [0.0, 1.0, 0.6364525402815665, 0.3635474597184336, 0.6364525402815665, 0.3635474597184336, 0.6364525402815663, 0.3635474597184336, 0.7310585786300049, 0.26894142136999527];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -4999.814241740637);
        let alpha: f64[10] = [-1000.37, -1000.74, -2000.4130397101883, -2000.713039710188, -3000.261194282844, -3000.561194282844, -4000.2793488555, -4000.5793488554996, -5000.127503428155, -5000.427503428155];
        let beta:  f64[10] = [-3999.871202030449, -4000.131202030449, -2999.8530474577933, -3000.113047457793, -2000.0048928851375, -2000.2648928851374, -999.9867383124817, -1000.2467383124817, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[10] = [0.6524894621926075, 0.34751053780714464, 0.6364525402812657, 0.3635474597184471, 0.6364525402812657, 0.3635474597184471, 0.6364525402812657, 0.3635474597184471, 0.7310585786300168, 0.2689414213699995];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.16760368670732495);
        let alpha: f64[12] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108, -0.12750342815520432, -0.42750342815520437, -0.14565800081089808, -0.4456580008108979];
        let beta:  f64[12] = [0.11064339689544811, -0.14935660310455168, 0.12879796955114187, -0.13120203044885814, -0.023047457793164527, -0.2830474577931643, -0.0048928851374707705, -0.2648928851374708, -0.15673831248177716, -0.4167383124817771, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.6524894621927443, 0.34751053780725544, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.7310585786300048, 0.26894142136999505];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.40869724365762927);
        let alpha: f64[12] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108, -0.12750342815520432, -0.42750342815520437, -0.14565800081089808, -0.4456580008108979];
        let beta:  f64[12] = [0.35173695384575243, 0.09173695384575264, 0.3698915265014462, 0.10989152650144618, 0.2180460991571398, -0.041953900842860214, 0.23620067181283355, -0.023799328187166457, 0.08435524446852699, -0.17564475553147296, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.6524894621927443, 0.34751053780725544, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.5744425168116588, 0.42555748318834097];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.8893566031045519);
        let alpha: f64[12] = [log(0.0), -0.74, -1.47, -1.77, -1.3181545726556938, -1.6181545726556936, -1.3363091453113873, -1.6363091453113874, -1.184463717967081, -1.484463717967081, -1.2026182906227747, -1.5026182906227745];
        let beta:  f64[12] = [0.11064339689544811, -0.14935660310455168, 0.12879796955114187, -0.13120203044885814, -0.023047457793164527, -0.2830474577931643, -0.0048928851374707705, -0.2648928851374708, -0.15673831248177716, -0.4167383124817771, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.0, 1.0, 0.6364525402815663, 0.3635474597184337, 0.6364525402815665, 0.3635474597184337, 0.6364525402815663, 0.3635474597184337, 0.6364525402815665, 0.3635474597184336, 0.7310585786300049, 0.2689414213699953];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -5999.832396313293);
        let alpha: f64[12] = [-1000.37, -1000.74, -2000.4130397101883, -2000.713039710188, -3000.261194282844, -3000.561194282844, -4000.2793488555, -4000.5793488554996, -5000.127503428155, -5000.427503428155, -6000.145658000812, -6000.445658000811];
        let beta:  f64[12] = [-4999.889356603105, -5000.149356603105, -3999.871202030449, -4000.131202030449, -3000.0230474577934, -3000.283047457793, -2000.0048928851375, -2000.2648928851374, -1000.1567383124818, -1000.4167383124818, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.6524894621932009, 0.3475105378074607, 0.6364525402818446, 0.3635474597187778, 0.6364525402818446, 0.3635474597187778, 0.6364525402818446, 0.3635474597187778, 0.6364525402818446, 0.3635474597187778, 0.7310585786300168, 0.26894142137024407];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.31944911405163134);
        let alpha: f64[14] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108, -0.12750342815520432, -0.42750342815520437, -0.14565800081089808, -0.4456580008108979, 0.006187426533408313, -0.2938125734665915];
        let beta:  f64[14] = [0.2624888242397545, 0.0024888242397547167, 0.28064339689544826, 0.02064339689544825, 0.12879796955114187, -0.13120203044885814, 0.1469525422068354, -0.11304745779316439, -0.0048928851374707705, -0.2648928851374708, 0.01326168751822282, -0.2467383124817772, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[14] = [0.6524894621927443, 0.34751053780725544, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.3635474597184337, 0.6364525402815662, 0.3635474597184337, 0.6364525402815662, 0.3635474597184337, 0.6364525402815662, 0.3635474597184337, 0.7310585786300048, 0.2689414213699952];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.5605426710019357);
        let alpha: f64[14] = [-0.37, -0.74, -0.4130397101881234, -0.7130397101881234, -0.26119428284381707, -0.5611942828438171, -0.2793488554995107, -0.5793488554995108, -0.12750342815520432, -0.42750342815520437, -0.14565800081089808, -0.4456580008108979, 0.006187426533408313, -0.2938125734665915];
        let beta:  f64[14] = [0.5035823811900588, 0.24358238119005904, 0.5217369538457526, 0.2617369538457526, 0.3698915265014462, 0.10989152650144618, 0.3880460991571397, 0.12804609915713971, 0.23620067181283355, -0.023799328187166457, 0.254355244468527, -0.0056447555314730335, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[14] = [0.6524894621927443, 0.34751053780725544, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.6364525402815662, 0.36354745971843355, 0.5744425168116588, 0.42555748318834097];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[2] = [log(0.0), -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-0.17, -0.34, -0.34, -0.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.7375111757602455);
        let alpha: f64[14] = [log(0.0), -0.74, -1.47, -1.77, -1.3181545726556938, -1.6181545726556936, -1.3363091453113873, -1.6363091453113874, -1.184463717967081, -1.484463717967081, -1.2026182906227747, -1.5026182906227745, -1.050772863278468, -1.3507728632784683];
        let beta:  f64[14] = [0.2624888242397545, 0.0024888242397547167, 0.28064339689544826, 0.02064339689544825, 0.12879796955114187, -0.13120203044885814, 0.1469525422068354, -0.11304745779316439, -0.0048928851374707705, -0.2648928851374708, 0.01326168751822282, -0.2467383124817772, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[14] = [0.0, 1.0, 0.6364525402815665, 0.3635474597184337, 0.6364525402815665, 0.3635474597184337, 0.6364525402815665, 0.3635474597184337, 0.6364525402815665, 0.3635474597184337, 0.6364525402815665, 0.3635474597184337, 0.731058578630005, 0.2689414213699953];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[2] = [-0.2, -0.4];
        let a:   f64[4] = [-0.13, -0.26, -0.39, -0.52];
        let e:   f64[4] = [-1000.17, -1000.34, -1000.34, -1000.51];
        let end: f64[2] = [-0.0, -0.7];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -6999.680550885949);
        let alpha: f64[14] = [-1000.37, -1000.74, -2000.4130397101883, -2000.713039710188, -3000.261194282844, -3000.561194282844, -4000.2793488555, -4000.5793488554996, -5000.127503428155, -5000.427503428155, -6000.145658000812, -6000.445658000811, -6999.993812573467, -7000.293812573467];
        let beta:  f64[14] = [-5999.73751117576, -5999.99751117576, -4999.719356603105, -4999.979356603105, -3999.871202030449, -4000.131202030449, -2999.8530474577933, -3000.113047457793, -2000.0048928851375, -2000.2648928851374, -999.9867383124817, -1000.2467383124817, 0.0, -0.7];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[14] = [0.6524894621926075, 0.3475105378074607, 0.6364525402818446, 0.3635474597184471, 0.6364525402818446, 0.3635474597184471, 0.6364525402818446, 0.3635474597184471, 0.6364525402818446, 0.3635474597184471, 0.6364525402812657, 0.3635474597187778, 0.7310585786300168, 0.2689414213699995];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.008890688997687302);
        let alpha: f64[3] = [-0.37, -0.74, -1.11];
        let beta:  f64[3] = [0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [0.6846204451232585, 0.2348306438762639, 0.08054891100047758];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.4037350839680697);
        let alpha: f64[3] = [-0.37, -0.74, -1.11];
        let beta:  f64[3] = [0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [0.46128690131889294, 0.318626699014285, 0.22008639966682197];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1.1450877403950888);
        let alpha: f64[3] = [log(0.0), -0.74, -1.11];
        let beta:  f64[3] = [0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [0.0, 0.7445969158274759, 0.2554030841725241];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[1] = [0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -999.9911093110023);
        let alpha: f64[3] = [-1000.37, -1000.74, -1001.11];
        let beta:  f64[3] = [0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[3] = [0.6846204451232693, 0.23483064387625588, 0.08054891100047994];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.16437760303187);
        let alpha: f64[6] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103];
        let beta:  f64[6] = [-0.06239403555561962, -0.3223940355556196, -0.5823940355556196, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.5505862614273942, 0.29323772858327024, 0.15617600998933556, 0.6652409557748219, 0.2447284710547977, 0.09003057317038052];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.5851618084936141);
        let alpha: f64[6] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103];
        let beta:  f64[6] = [0.3583901699061243, 0.09839016990612437, -0.16160983009387564, 0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.5505862614273942, 0.2932377285832702, 0.15617600998933556, 0.4367518169107908, 0.3235537038833594, 0.23969447920584974];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.635433745743743);
        let alpha: f64[6] = [log(0.0), -0.74, -1.11, -1.0430397101881232, -1.3430397101881235, -1.6430397101881236];
        let beta:  f64[6] = [-0.06239403555561962, -0.3223940355556196, -0.5823940355556196, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.0, 0.6524894621927445, 0.34751053780725544, 0.6652409557748219, 0.2447284710547977, 0.09003057317038048];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[2] = [0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -1999.8356223969681);
        let alpha: f64[6] = [-1000.37, -1000.74, -1001.11, -2000.2432283614125, -2000.5432283614125, -2000.8432283614125];
        let beta:  f64[6] = [-1000.0623940355556, -1000.3223940355556, -1000.5823940355556, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[6] = [0.5505862614273349, 0.2932377285832733, 0.15617600998935569, 0.6652409557747898, 0.24472847105478585, 0.09003057317039659];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.5049089616141922);
        let alpha: f64[9] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883];
        let beta:  f64[9] = [0.2781373230267026, 0.018137323026702568, -0.24186267697329744, 0.10760596444438036, -0.15239403555561964, -0.41239403555561965, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[9] = [0.5505862614273943, 0.29323772858327024, 0.15617600998933556, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.6652409557748219, 0.2447284710547977, 0.09003057317038048];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.9256931670759361);
        let alpha: f64[9] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883];
        let beta:  f64[9] = [0.6989215284884467, 0.4389215284884467, 0.17892152848844667, 0.5283901699061243, 0.2683901699061243, 0.00839016990612429, 0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[9] = [0.5505862614273943, 0.29323772858327024, 0.15617600998933556, 0.5270123171133408, 0.30103421229510613, 0.17195347059155303, 0.43675181691079085, 0.32355370388335947, 0.2396944792058498];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.2949023871614209);
        let alpha: f64[9] = [log(0.0), -0.74, -1.11, -1.0430397101881232, -1.3430397101881235, -1.6430397101881236, -0.7025083516058015, -1.0025083516058013, -1.3025083516058014];
        let beta:  f64[9] = [0.2781373230267026, 0.018137323026702568, -0.24186267697329744, 0.10760596444438036, -0.15239403555561964, -0.41239403555561965, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[9] = [0.0, 0.6524894621927445, 0.34751053780725555, 0.5270123171133407, 0.3010342122951061, 0.17195347059155294, 0.6652409557748217, 0.24472847105479764, 0.09003057317038043];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -2999.495091038386);
        let alpha: f64[9] = [-1000.37, -1000.74, -1001.11, -2000.2432283614125, -2000.5432283614125, -2000.8432283614125, -2999.9026970028303, -3000.20269700283, -3000.5026970028302];
        let beta:  f64[9] = [-1999.7218626769732, -1999.9818626769734, -2000.2418626769731, -999.8923940355556, -1000.1523940355556, -1000.4123940355556, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[9] = [0.5505862614273349, 0.29323772858333996, 0.15617600998935569, 0.5270123171133033, 0.3010342122951012, 0.17195347059155955, 0.6652409557747898, 0.24472847105478585, 0.09003057317041706];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.6754403201965145);
        let alpha: f64[12] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866];
        let beta:  f64[12] = [0.4486686816090246, 0.1886686816090246, -0.0713313183909754, 0.2781373230267026, 0.018137323026702346, -0.24186267697329744, -0.06239403555561962, -0.3223940355556196, -0.5823940355556196, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.5505862614273942, 0.2932377285832702, 0.15617600998933553, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.6652409557748217, 0.2447284710547977, 0.09003057317038043];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.0962245256582583);
        let alpha: f64[12] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866];
        let beta:  f64[12] = [0.8694528870707685, 0.6094528870707685, 0.3494528870707685, 0.6989215284884467, 0.43892152848844646, 0.17892152848844667, 0.3583901699061243, 0.09839016990612437, -0.16160983009387564, 0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.5505862614273943, 0.29323772858327024, 0.15617600998933553, 0.5270123171133408, 0.3010342122951061, 0.17195347059155303, 0.5270123171133408, 0.30103421229510624, 0.17195347059155303, 0.43675181691079074, 0.3235537038833594, 0.2396944792058498];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -0.1243710285790991);
        let alpha: f64[12] = [log(0.0), -0.74, -1.11, -1.0430397101881232, -1.3430397101881235, -1.6430397101881236, -0.7025083516058015, -1.0025083516058013, -1.3025083516058014, -0.5319769930234792, -0.8319769930234793, -1.1319769930234793];
        let beta:  f64[12] = [0.4486686816090246, 0.1886686816090246, -0.0713313183909754, 0.2781373230267026, 0.018137323026702346, -0.24186267697329744, -0.06239403555561962, -0.3223940355556196, -0.5823940355556196, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.0, 0.6524894621927447, 0.3475105378072556, 0.5270123171133411, 0.3010342122951063, 0.17195347059155303, 0.5270123171133411, 0.3010342122951063, 0.17195347059155305, 0.665240955774822, 0.2447284710547978, 0.09003057317038052];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[4] = [0, 1, 0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -3999.3245596798038);
        let alpha: f64[12] = [-1000.37, -1000.74, -1001.11, -2000.2432283614125, -2000.5432283614125, -2000.8432283614125, -2999.9026970028303, -3000.20269700283, -3000.5026970028302, -3999.732165644248, -4000.032165644248, -4000.3321656442477];
        let beta:  f64[12] = [-2999.551331318391, -2999.811331318391, -3000.071331318391, -1999.7218626769732, -1999.9818626769734, -2000.2418626769731, -1000.0623940355556, -1000.3223940355556, -1000.5823940355556, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[12] = [0.5505862614273349, 0.29323772858333996, 0.15617600998935569, 0.5270123171133033, 0.3010342122952381, 0.17195347059155955, 0.5270123171133033, 0.3010342122952381, 0.17195347059155955, 0.6652409557747898, 0.24472847105489715, 0.09003057317041706];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.0159716787788362);
        let alpha: f64[15] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866, 0.6083657143344561, 0.3083657143344558, 0.008365714334455987];
        let beta:  f64[15] = [0.7892000401913468, 0.5292000401913468, 0.2692000401913468, 0.6186686816090246, 0.35866868160902454, 0.09866868160902453, 0.2781373230267026, 0.018137323026702568, -0.24186267697329744, 0.10760596444438036, -0.15239403555561964, -0.41239403555561965, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[15] = [0.5505862614273943, 0.2932377285832703, 0.15617600998933556, 0.5270123171133411, 0.3010342122951063, 0.17195347059155305, 0.5270123171133411, 0.30103421229510613, 0.17195347059155305, 0.5270123171133411, 0.3010342122951063, 0.17195347059155305, 0.665240955774822, 0.2447284710547978, 0.09003057317038048];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.4367558842405805);
        let alpha: f64[15] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866, 0.6083657143344561, 0.3083657143344558, 0.008365714334455987];
        let beta:  f64[15] = [1.2099842456530907, 0.9499842456530907, 0.6899842456530907, 1.0394528870707689, 0.7794528870707689, 0.5194528870707689, 0.6989215284884467, 0.4389215284884467, 0.17892152848844667, 0.5283901699061243, 0.2683901699061243, 0.00839016990612429, 0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[15] = [0.5505862614273941, 0.2932377285832702, 0.1561760099893355, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.43675181691079074, 0.32355370388335936, 0.23969447920584974];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.21616033000322332);
        let alpha: f64[15] = [log(0.0), -0.74, -1.11, -1.0430397101881232, -1.3430397101881235, -1.6430397101881236, -0.7025083516058015, -1.0025083516058013, -1.3025083516058014, -0.5319769930234792, -0.8319769930234793, -1.1319769930234793, -0.19144563444115725, -0.4914456344411571, -0.7914456344411569];
        let beta:  f64[15] = [0.7892000401913468, 0.5292000401913468, 0.2692000401913468, 0.6186686816090246, 0.35866868160902454, 0.09866868160902453, 0.2781373230267026, 0.018137323026702568, -0.24186267697329744, 0.10760596444438036, -0.15239403555561964, -0.41239403555561965, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[15] = [0.0, 0.6524894621927445, 0.34751053780725544, 0.5270123171133408, 0.30103421229510613, 0.1719534705915529, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.6652409557748217, 0.2447284710547977, 0.09003057317038048];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[5] = [0, 1, 0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -4998.984028321222);
        let alpha: f64[15] = [-1000.37, -1000.74, -1001.11, -2000.2432283614125, -2000.5432283614125, -2000.8432283614125, -2999.9026970028303, -3000.20269700283, -3000.5026970028302, -3999.732165644248, -4000.032165644248, -4000.3321656442477, -4999.3916342856655, -4999.691634285666, -4999.991634285666];
        let beta:  f64[15] = [-3999.210799959809, -3999.4707999598086, -3999.730799959809, -2999.381331318391, -2999.6413313183907, -2999.901331318391, -1999.7218626769732, -1999.9818626769734, -2000.2418626769731, -999.8923940355556, -1000.1523940355556, -1000.4123940355556, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[15] = [0.5505862614273349, 0.2932377285834733, 0.1561760099894267, 0.527012317113543, 0.30103421229537497, 0.17195347059163774, 0.527012317113543, 0.3010342122951012, 0.17195347059163774, 0.527012317113543, 0.3010342122951012, 0.17195347059163774, 0.6652409557750923, 0.24472847105489715, 0.09003057317041706];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.1865030373611587);
        let alpha: f64[18] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866, 0.6083657143344561, 0.3083657143344558, 0.008365714334455987, 0.7788970729167781, 0.4788970729167783, 0.17889707291677803];
        let beta:  f64[18] = [0.9597313987736689, 0.6997313987736691, 0.43973139877366885, 0.7892000401913468, 0.5292000401913464, 0.2692000401913468, 0.4486686816090246, 0.1886686816090246, -0.0713313183909754, 0.2781373230267026, 0.018137323026702346, -0.24186267697329744, -0.06239403555561962, -0.3223940355556196, -0.5823940355556196, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[18] = [0.5505862614273943, 0.2932377285832702, 0.1561760099893355, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.6652409557748217, 0.2447284710547977, 0.09003057317038048];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.6072872428229026);
        let alpha: f64[18] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866, 0.6083657143344561, 0.3083657143344558, 0.008365714334455987, 0.7788970729167781, 0.4788970729167783, 0.17889707291677803];
        let beta:  f64[18] = [1.3805156042354128, 1.120515604235413, 0.8605156042354127, 1.2099842456530907, 0.9499842456530907, 0.6899842456530907, 0.8694528870707685, 0.6094528870707685, 0.3494528870707685, 0.6989215284884467, 0.43892152848844646, 0.17892152848844667, 0.3583901699061243, 0.09839016990612437, -0.16160983009387564, 0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[18] = [0.5505862614273943, 0.2932377285832702, 0.15617600998933556, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155305, 0.43675181691079074, 0.32355370388335947, 0.23969447920584974];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.38669168858554537);
        let alpha: f64[18] = [log(0.0), -0.74, -1.11, -1.0430397101881232, -1.3430397101881235, -1.6430397101881236, -0.7025083516058015, -1.0025083516058013, -1.3025083516058014, -0.5319769930234792, -0.8319769930234793, -1.1319769930234793, -0.19144563444115725, -0.4914456344411571, -0.7914456344411569, -0.020914275858834763, -0.32091427585883503, -0.6209142758588349];
        let beta:  f64[18] = [0.9597313987736689, 0.6997313987736691, 0.43973139877366885, 0.7892000401913468, 0.5292000401913464, 0.2692000401913468, 0.4486686816090246, 0.1886686816090246, -0.0713313183909754, 0.2781373230267026, 0.018137323026702346, -0.24186267697329744, -0.06239403555561962, -0.3223940355556196, -0.5823940355556196, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[18] = [0.0, 0.6524894621927445, 0.34751053780725544, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155305, 0.5270123171133408, 0.3010342122951063, 0.17195347059155305, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.665240955774822, 0.2447284710547978, 0.09003057317038048];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[6] = [0, 1, 0, 1, 0, 1];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -5998.813496962639);
        let alpha: f64[18] = [-1000.37, -1000.74, -1001.11, -2000.2432283614125, -2000.5432283614125, -2000.8432283614125, -2999.9026970028303, -3000.20269700283, -3000.5026970028302, -3999.732165644248, -4000.032165644248, -4000.3321656442477, -4999.3916342856655, -4999.691634285666, -4999.991634285666, -5999.221102927083, -5999.521102927083, -5999.821102927083];
        let beta:  f64[18] = [-4999.040268601227, -4999.300268601226, -4999.560268601226, -3999.210799959809, -3999.4707999598086, -3999.730799959809, -2999.551331318391, -2999.811331318391, -3000.071331318391, -1999.7218626769732, -1999.9818626769734, -2000.2418626769731, -1000.0623940355556, -1000.3223940355556, -1000.5823940355556, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[18] = [0.5505862614273349, 0.2932377285832066, 0.15617600998928466, 0.5270123171130637, 0.3010342122951012, 0.17195347059148136, 0.527012317113543, 0.3010342122951012, 0.17195347059148136, 0.5270123171130637, 0.3010342122951012, 0.17195347059163774, 0.5270123171130637, 0.3010342122951012, 0.17195347059163774, 0.6652409557750923, 0.24472847105489715, 0.09003057317041706];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.5270343959434811);
        let alpha: f64[21] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866, 0.6083657143344561, 0.3083657143344558, 0.008365714334455987, 0.7788970729167781, 0.4788970729167783, 0.17889707291677803, 1.1194284314991005, 0.8194284314991003, 0.5194284314991005];
        let beta:  f64[21] = [1.3002627573559908, 1.040262757355991, 0.7802627573559913, 1.1297313987736686, 0.869731398773669, 0.6097313987736688, 0.7892000401913468, 0.5292000401913468, 0.2692000401913468, 0.6186686816090246, 0.35866868160902454, 0.09866868160902453, 0.2781373230267026, 0.018137323026702568, -0.24186267697329744, 0.10760596444438036, -0.15239403555561964, -0.41239403555561965, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[21] = [0.5505862614273941, 0.2932377285832702, 0.1561760099893355, 0.5270123171133406, 0.301034212295106, 0.17195347059155297, 0.5270123171133406, 0.301034212295106, 0.17195347059155297, 0.5270123171133406, 0.301034212295106, 0.1719534705915529, 0.5270123171133406, 0.301034212295106, 0.17195347059155297, 0.5270123171133408, 0.301034212295106, 0.1719534705915529, 0.6652409557748217, 0.24472847105479759, 0.09003057317038043];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [0.0, 0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 1.947818601405225);
        let alpha: f64[21] = [-0.37, -0.74, -1.11, -0.24322836141251025, -0.5432283614125104, -0.8432283614125103, 0.09730299716981183, -0.2026970028301882, -0.5026970028301883, 0.2678343557521339, -0.032165644247866165, -0.332165644247866, 0.6083657143344561, 0.3083657143344558, 0.008365714334455987, 0.7788970729167781, 0.4788970729167783, 0.17889707291677803, 1.1194284314991005, 0.8194284314991003, 0.5194284314991005];
        let beta:  f64[21] = [1.7210469628177352, 1.4610469628177354, 1.2010469628177347, 1.550515604235413, 1.290515604235413, 1.030515604235413, 1.2099842456530907, 0.9499842456530907, 0.6899842456530907, 1.0394528870707689, 0.7794528870707689, 0.5194528870707689, 0.6989215284884467, 0.4389215284884467, 0.17892152848844667, 0.5283901699061243, 0.2683901699061243, 0.00839016990612429, 0.0, 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[21] = [0.5505862614273941, 0.2932377285832702, 0.15617600998933542, 0.5270123171133408, 0.301034212295106, 0.17195347059155297, 0.5270123171133406, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.30103421229510613, 0.17195347059155297, 0.5270123171133406, 0.30103421229510613, 0.17195347059155297, 0.5270123171133408, 0.301034212295106, 0.17195347059155297, 0.43675181691079074, 0.32355370388335936, 0.23969447920584974];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[3] = [log(0.0), -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-0.17, -0.34, -0.34, -0.51, -0.51, -0.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, 0.7272230471678673);
        let alpha: f64[21] = [log(0.0), -0.74, -1.11, -1.0430397101881232, -1.3430397101881235, -1.6430397101881236, -0.7025083516058015, -1.0025083516058013, -1.3025083516058014, -0.5319769930234792, -0.8319769930234793, -1.1319769930234793, -0.19144563444115725, -0.4914456344411571, -0.7914456344411569, -0.020914275858834763, -0.32091427585883503, -0.6209142758588349, 0.3196170827234872, 0.019617082723486945, -0.2803829172765129];
        let beta:  f64[21] = [1.3002627573559908, 1.040262757355991, 0.7802627573559913, 1.1297313987736686, 0.869731398773669, 0.6097313987736688, 0.7892000401913468, 0.5292000401913468, 0.2692000401913468, 0.6186686816090246, 0.35866868160902454, 0.09866868160902453, 0.2781373230267026, 0.018137323026702568, -0.24186267697329744, 0.10760596444438036, -0.15239403555561964, -0.41239403555561965, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[21] = [0.0, 0.6524894621927448, 0.3475105378072556, 0.5270123171133411, 0.3010342122951063, 0.17195347059155297, 0.5270123171133411, 0.3010342122951063, 0.17195347059155305, 0.5270123171133411, 0.3010342122951063, 0.17195347059155305, 0.5270123171133411, 0.3010342122951063, 0.17195347059155305, 0.5270123171133411, 0.3010342122951063, 0.17195347059155297, 0.665240955774822, 0.2447284710547978, 0.09003057317038052];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[7] = [0, 1, 0, 1, 0, 1, 0];
        let i:   f64[3] = [-0.2, -0.4, -0.6000000000000001];
        let a:   f64[9] = [-0.13, -0.26, -0.39, -0.39, -0.52, -0.65, -0.65, -0.78, -0.91];
        let e:   f64[6] = [-1000.17, -1000.34, -1000.34, -1000.51, -1000.51, -1000.68];
        let end: f64[3] = [-0.0, -0.7, -1.4];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, -6998.472965604056);
        let alpha: f64[21] = [-1000.37, -1000.74, -1001.11, -2000.2432283614125, -2000.5432283614125, -2000.8432283614125, -2999.9026970028303, -3000.20269700283, -3000.5026970028302, -3999.732165644248, -4000.032165644248, -4000.3321656442477, -4999.3916342856655, -4999.691634285666, -4999.991634285666, -5999.221102927083, -5999.521102927083, -5999.821102927083, -6998.880571568501, -6999.180571568501, -6999.480571568501];
        let beta:  f64[21] = [-5998.699737242644, -5998.959737242644, -5999.2197372426435, -4998.870268601227, -4999.130268601226, -4999.390268601226, -3999.210799959809, -3999.4707999598086, -3999.730799959809, -2999.381331318391, -2999.6413313183907, -2999.901331318391, -1999.7218626769732, -1999.9818626769734, -2000.2418626769731, -999.8923940355556, -1000.1523940355556, -1000.4123940355556, 0.0, -0.7, -1.4];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        let p: f64[21] = [0.5505862614273349, 0.2932377285832066, 0.15617600998928466, 0.5270123171130637, 0.3010342122951012, 0.17195347059148136, 0.5270123171130637, 0.3010342122951012, 0.17195347059148136, 0.5270123171130637, 0.3010342122951012, 0.17195347059163774, 0.5270123171130637, 0.3010342122951012, 0.17195347059148136, 0.5270123171130637, 0.3010342122951012, 0.17195347059163774, 0.6652409557744873, 0.24472847105467455, 0.09003057317041706];
        assert(got.defined);
        for k in p.len { near(got.posterior[k], p[k]); }
    }
    {
        let o:   i64[3] = [0, 1, 0];
        let i:   f64[2] = [0.0, 0.0];
        let a:   f64[4] = [0.0, 0.0, 0.0, 0.0];
        let e:   f64[4] = [log(0.0), log(0.0), log(0.0), log(0.0)];
        let end: f64[2] = [0.0, 0.0];
        let got = bio::hmm_posterior_log(o, i, a, e, 2, end);
        assert(got.error.len == 0);
        near(got.log_z, log(0.0));
        let alpha: f64[6] = [log(0.0), log(0.0), log(0.0), log(0.0), log(0.0), log(0.0)];
        let beta:  f64[6] = [log(0.0), log(0.0), log(0.0), log(0.0), 0.0, 0.0];
        for k in alpha.len { near(got.alpha[k], alpha[k]); near(got.beta[k], beta[k]); }
        assert(!got.defined && got.posterior.len == 0);
    }
    print("85 pinned RustBio and enumerated posterior cases passed");
}
