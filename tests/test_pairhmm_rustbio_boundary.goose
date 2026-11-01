// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio from "..";
import bio.stats.pairhmm_rustbio;
import math;
fn main() {
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.74484904044086, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-46.744849040440855)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.74484904044086, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-46.744849040440855)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.696304297144057, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-36.64656967355463)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.696304297144057, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-36.64656967355463)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.696304297144057, -0.69, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-36.64656967355463)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.696304297144057, -0.69, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-36.64656967355463)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440568, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.25431011023126)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440568, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.25431011023126)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440568, -0.69, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.25431011023126)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440568, -0.69, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.25431011023126)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440567, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-39.06389260353963)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440567, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-39.06389260353963)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440567, -0.69, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-39.06389260353963)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440567, -0.69, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-39.06389260353963)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440566, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440566, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440566, -0.69, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440566, -0.69, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440565, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.69, -0.6963042971440565, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440565, -0.69, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.6963042971440565, -0.69, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671888, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.03490311552361)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671888, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.03490311552361)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671888, -0.5, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.03490311552361)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671888, -0.5, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.03490311552361)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671887, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.79018364557589)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671887, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.79018364557589)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671887, -0.5, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.79018364557589)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671887, -0.5, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-37.79018364557589)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671886, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671886, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671886, -0.5, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671886, -0.5, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671884, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671884, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671884, -0.5, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671884, -0.5, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671883, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.5, -0.9327521295671883, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671883, -0.5, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.9327521295671883, -0.5, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966065, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-44.96114392682663)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966065, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-44.96114392682663)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966065, -1e-05, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-44.96114392682663)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966065, -1e-05, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-44.96114392682663)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966063, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-45.86972534281387)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966063, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-45.86972534281387)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966063, -1e-05, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-45.86972534281387)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966063, -1e-05, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-45.86972534281387)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966061, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966061, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966061, -1e-05, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966061, -1e-05, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.51293046496606, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.51293046496606, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.51293046496606, -1e-05, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.51293046496606, -1e-05, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966058, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-05, -11.512930464966058, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966058, -1e-05, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -11.512930464966058, -1e-05, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.05170185988093, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-77.88611472414065)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.05170185988093, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-77.88611472414065)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.05170185988093, -1e-20, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-77.88611472414065)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.05170185988093, -1e-20, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-77.88611472414065)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.05170185988092, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-78.53131921991175)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.05170185988092, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-78.53131921991175)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.05170185988092, -1e-20, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-78.53131921991175)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.05170185988092, -1e-20, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-78.53131921991175)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.051701859880914, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-80.89979666114358)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.051701859880914, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-80.89979666114358)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.051701859880914, -1e-20, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-80.89979666114358)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.051701859880914, -1e-20, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-80.89979666114358)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.05170185988091, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.05170185988091, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.05170185988091, -1e-20, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.05170185988091, -1e-20, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.0517018598809, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, -46.0517018598809, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.0517018598809, -1e-20, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -46.0517018598809, -1e-20, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940464, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-260.5790606944241)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940464, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-260.5790606944241)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940464, -1e-100, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-260.5790606944241)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940464, -1e-100, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-260.5790606944241)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.2585092994046, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-261.1212097938034)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.2585092994046, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-261.1212097938034)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.2585092994046, -1e-100, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-261.1212097938034)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.2585092994046, -1e-100, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-261.1212097938034)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940458, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-262.39309996641447)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940458, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-262.39309996641447)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940458, -1e-100, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-262.39309996641447)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940458, -1e-100, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-262.39309996641447)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940455, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940455, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940455, -1e-100, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940455, -1e-100, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940452, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-100, -230.25850929940452, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940452, -1e-100, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -230.25850929940452, -1e-100, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982139, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-719.9976383987819)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982139, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-719.9976383987819)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982139, -1e-300, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-719.9976383987819)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982139, -1e-300, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-719.9976383987819)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982138, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-720.8143086229276)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982138, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-720.8143086229276)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982138, -1e-300, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-720.8143086229276)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982138, -1e-300, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-720.8143086229276)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982137, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982137, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982137, -1e-300, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982137, -1e-300, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982136, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982136, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982136, -1e-300, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982136, -1e-300, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982135, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, -690.7755278982135, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982135, -1e-300, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -690.7755278982135, -1e-300, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909742, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-765.8017427424875)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909742, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-765.8017427424875)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909742, -1e-320, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-765.8017427424875)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909742, -1e-320, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-765.8017427424875)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.827240890974, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-766.3738922567085)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.827240890974, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-766.3738922567085)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.827240890974, -1e-320, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-766.3738922567085)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.827240890974, -1e-320, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-766.3738922567085)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909739, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-767.8526179856162)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909739, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-767.8526179856162)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909739, -1e-320, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-767.8526179856162)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909739, -1e-320, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-767.8526179856162)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909738, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909738, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909738, -1e-320, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909738, -1e-320, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909737, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-320, -736.8272408909737, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909737, -1e-320, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -736.8272408909737, -1e-320, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213814, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-773.7685470201743)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213814, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-773.7685470201743)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213814, -5e-324, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-773.7685470201743)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213814, -5e-324, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-773.7685470201743)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213813, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-774.7380627991926)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213813, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-774.7380627991926)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213813, -5e-324, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-774.7380627991926)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213813, -5e-324, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-774.7380627991926)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213812, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213812, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213812, -5e-324, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213812, -5e-324, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213811, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.4400719213811, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213811, -5e-324, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.4400719213811, -5e-324, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.440071921381, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -744.440071921381, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.440071921381, -5e-324, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -744.440071921381, -5e-324, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], 0.0, log(0.0), log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], 0.0, log(0.0), log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], log(0.0), 0.0, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], log(0.0), 0.0, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], log(0.0), log(0.0), log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], log(0.0), log(0.0), log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], 0.0, -1000.0, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], 0.0, -1000.0, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], 0.0, -5e-324, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], 0.0, -5e-324, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len > 0);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -1000.0, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-744.4400719213812)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -5e-324, -1000.0, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-744.4400719213812)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e+300, -1e+300, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e+300, -1e+300, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, log(0.0), log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-46.051701859880914)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-20, log(0.0), log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-46.051701859880914)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, log(0.0), log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-690.7755278982137)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -1e-300, log(0.0), log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-690.7755278982137)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.7, -0.7, log(0.0), log(0.0), [], false, false, false);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-4.986519567309444)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_checked(1, 1, [0.0], [0.0], [0.0], -0.7, -0.7, log(0.0), log(0.0), [], false, false, true);
        assert(r.error.len == 0);
        assert(abs(r.log_probability - (-4.986519567309444)) < 2e-12);
    }
}
