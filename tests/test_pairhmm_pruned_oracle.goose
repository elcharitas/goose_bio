// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio from "..";
import bio.stats.pairhmm_rustbio;
import math;
fn main() {
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 0.0001);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(abs(r.log_probability - (0.0)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 0, [], [], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(0, 3, [], [], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 0);
        assert(r.admitted_cells == 0);
        assert(r.log_probability == log(0.0));
        let u = bio::rustbio_pairhmm_checked(3, 0, [], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462862967017377)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-0.4462871026284195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260834462189783)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260835676821022)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260834462189783)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260835676821022)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-6.266615205496523)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-6.266616427333377)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-6.260834462189783)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-6.260835676821022)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260834462189783)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260835676821022)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260834462189783)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.260835676821022)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353062433202)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353823506339)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353062433202)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353823506339)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-6.266615205496523)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-6.266616427333377)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-6.069623014591207)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-6.069623781631191)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353062433202)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353823506339)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353062433202)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-6.046353823506339)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.45470577287453)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.454708249758195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.45470577287453)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.454708249758195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-5.459867331279933)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-5.459869836159832)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-5.45470577287453)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-5.454708249758195)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 6);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 6);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.45470577287453)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.454708249758195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.45470577287453)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.454708249758195)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250629283899914)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250631171528365)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250629283899914)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250631171528365)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-5.459867331279933)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-5.459869836159832)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-5.271606699710399)) < 0.0008);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 11);
        assert(abs(r.log_probability - (-5.271608571235334)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 6);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 6);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250629283899914)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250631171528365)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250629283899914)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-5.250631171528365)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(3, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741009184503458)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741010933666326)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741009184503458)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741010933666326)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 5);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 5);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 7);
        assert(abs(r.log_probability - (-5.741009184503458)) < 0.0007);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 7);
        assert(abs(r.log_probability - (-5.741010933666326)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741009184503458)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741010933666326)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741009184503458)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-5.741010933666326)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.1011499380703462)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.101151343277309)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.1011499380703462)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.101151343277309)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 5);
        assert(abs(r.log_probability - (-2.1277568496336534)) < 0.0007);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 5);
        assert(abs(r.log_probability - (-2.1277582179623513)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 7);
        assert(abs(r.log_probability - (-2.1011499380703462)) < 0.0007);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 7);
        assert(abs(r.log_probability - (-2.101151343277309)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(abs(r.log_probability - (-2.215305641259284)) < 0.0007);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(abs(r.log_probability - (-2.215307084886985)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.1011499380703462)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.101151343277309)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.1011499380703462)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.101151343277309)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.0752328227143786)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-2.075234085450745)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 0, 0, 0, 0, 0, 0, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348547194203443)) < 0.0007);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 8);
        assert(r.admitted_cells == 8);
        assert(abs(r.log_probability - (-0.7348549005525555)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 2, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-2.998589674771016)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-2.9985913969547253)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 1);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, true, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-2.998589674771016)) < 0.0008);
        let u = bio::rustbio_pairhmm_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, false, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 12);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-2.9985913969547253)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 3, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [log(0.0), -1.6094379124341003, log(0.0), -0.35667494393873245], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(5, 6, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 30);
        assert(r.admitted_cells == 26);
        assert(abs(r.log_probability - (-8.022134537245153)) < 0.0012000000000000001);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(5, 6, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 30);
        assert(r.admitted_cells == 26);
        assert(abs(r.log_probability - (-8.022138957183154)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.139433477261683)) < 0.00030000000000000003);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [1], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 1);
        assert(r.admitted_cells == 1);
        assert(abs(r.log_probability - (-1.1394342831883648)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 1, [-0.916290731874155], [-0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(5, 6, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 30);
        assert(r.admitted_cells == 30);
        assert(abs(r.log_probability - (-8.022110080548552)) < 0.0012000000000000001);
        let u = bio::rustbio_pairhmm_checked(5, 6, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(5, 6, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 30);
        assert(r.admitted_cells == 30);
        assert(abs(r.log_probability - (-8.022114501709959)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(5, 6, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 2);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 2);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 20);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-21.8582855790835)) < 0.0011);
        let u = bio::rustbio_pairhmm_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 20);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-21.85828638501018)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(1, 9, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 2);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 2);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 3);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 4);
        assert(r.log_probability == log(0.0));
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 20);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-12.300611116629735)) < 0.0011);
        let u = bio::rustbio_pairhmm_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false, [0, 0, 0, 0, 0, 0, 0, 0, 0], true, 20);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 9);
        assert(r.admitted_cells == 9);
        assert(abs(r.log_probability - (-12.300611922556417)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(9, 1, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, false, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-4.341299146347401)) < 0.0009000000000000001);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-4.341302112500702)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-3.543327455058561)) < 0.0009000000000000001);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], false, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-3.5433304308746623)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 10);
        assert(abs(r.log_probability - (-4.378307155675041)) < 0.0009000000000000001);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 10);
        assert(abs(r.log_probability - (-4.378310182844219)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-3.5876879728979145)) < 0.0009000000000000001);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 0);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 12);
        assert(abs(r.log_probability - (-3.587691067776449)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 14);
        assert(abs(r.log_probability - (-4.345488695720892)) < 0.0009000000000000001);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 14);
        assert(abs(r.log_probability - (-4.345491661508998)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 15);
        assert(abs(r.log_probability - (-3.5470992828184467)) < 0.0009000000000000001);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 1);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 15);
        assert(abs(r.log_probability - (-3.547102259272614)) < 2e-12);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-4.341299146347401)) < 0.0009000000000000001);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-4.341302112500702)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-3.543327455058561)) < 0.0009000000000000001);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 2);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-3.5433304308746623)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-4.341299146347401)) < 0.0009000000000000001);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-4.341302112500702)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], false, true, false);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-3.543327455058561)) < 0.0009000000000000001);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, true);
        assert(u.log_probability == r.log_probability);
    }
    {
        let r = bio::rustbio_pairhmm_pruned_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false, [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0], true, 12);
        assert(r.error.len == 0);
        assert(r.scanned_cells == 16);
        assert(r.admitted_cells == 16);
        assert(abs(r.log_probability - (-3.5433304308746623)) < 2e-12);
        let u = bio::rustbio_pairhmm_checked(4, 4, [-0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155, -0.916290731874155], [-0.6931471805599453, -0.6931471805599453, -0.6931471805599453, -0.6931471805599453], [-1.2039728043259361, -1.2039728043259361, -1.2039728043259361, -1.2039728043259361], -2.659260036932778, -2.0402208285265546, -1.2039728043259361, -0.5108256237659907, [], true, true, false);
        assert(u.log_probability == r.log_probability);
    }
}
