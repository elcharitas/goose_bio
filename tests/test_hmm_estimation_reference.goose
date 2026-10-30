// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.stats.hmm_estimation;
import math;
fn near(a: f64,b: f64) { assert(abs(a-b)<2e-10*(1.0+abs(b))); }
fn main() {
{
let o: i64[1] = [0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-1.6094379124341003);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [0.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-1.6094379124341003);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [0.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [log(0.0),0.0,log(0.0)];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[1] = [0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [0.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [1.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [1.0,1.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [1.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [1.0,1.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [log(0.0),0.0,log(0.0)];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[2] = [0,1];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.525728644308255);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [1.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [1.0,1.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-3.912023005428146);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [2.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [2.0,1.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-3.912023005428146);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [2.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [2.0,1.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [log(0.0),0.0,log(0.0)];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[3] = [0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-4.828313737302301);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [2.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [2.0,1.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.214608098422191);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [4.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [3.0,2.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.214608098422191);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [4.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [3.0,2.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [log(0.0),0.0,log(0.0)];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[1] = [0.0];
let a: f64[1] = [0.0];
let e: f64[3] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455];
let end: f64[1] = [0.0];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-7.354042381610556);
let want_initial: f64[1] = [1.0];
for k in 1 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[1] = [4.0];
for k in 1 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[3] = [3.0,2.0,0.0];
for k in 3 { near(c.emission[k],want_emission[k]); }
let want_end: f64[1] = [1.0];
for k in 1 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-1.897119984885881);
let want_initial: f64[2] = [0.6666666666666666,0.3333333333333333];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.0,0.0,0.0,0.0];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [0.6666666666666666,0.0,0.0,0.3333333333333333,0.0,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.6666666666666666,0.3333333333333333];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[2] = [0.0,log(0.0)];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-1.6094379124341003);
let want_initial: f64[2] = [1.0,0.0];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.0,0.0,0.0,0.0];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [1.0,0.0,0.0,0.0,0.0,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [1.0,0.0];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[1] = [0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[2] = [0.5,0.5];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.0,0.0,0.0,0.0];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [0.5,0.0,0.0,0.5,0.0,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.5,0.5];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.70805020110221);
let want_initial: f64[2] = [0.5,0.5];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.25,0.25,0.25,0.25];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [0.5,0.5,0.0,0.5,0.5,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.5,0.5];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[2] = [0.0,log(0.0)];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[2] = [1.0,0.0];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [1.0,0.0,0.0,0.0];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [1.0,1.0,0.0,0.0,0.0,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [1.0,0.0];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[2] = [0,1];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.5902671654458262);
let want_initial: f64[2] = [0.33333333333333326,0.6666666666666665];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.17777777777777776,0.15555555555555553,0.3555555555555555,0.31111111111111106];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [0.33333333333333326,0.5333333333333332,0.0,0.6666666666666665,0.46666666666666656,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.5333333333333332,0.46666666666666656];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-4.31748811353631);
let want_initial: f64[2] = [0.5,0.5];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.33333333333333337,0.5,0.5,0.6666666666666667];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [1.0,0.33333333333333337,0.0,1.0000000000000002,0.6666666666666667,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.5,0.5];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[2] = [0.0,log(0.0)];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-3.912023005428146);
let want_initial: f64[2] = [1.0,0.0];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [2.0,0.0,0.0,0.0];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [2.0,1.0,0.0,0.0,0.0,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [1.0,0.0];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[3] = [0,1,0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-4.509860006183766);
let want_initial: f64[2] = [0.3333333333333333,0.6666666666666666];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.2424242424242424,0.45454545454545453,0.4545454545454545,0.8484848484848484];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [0.6666666666666666,0.3636363636363636,0.0,1.3333333333333333,0.6363636363636362,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.3333333333333333,0.6666666666666666];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.620073206530356);
let want_initial: f64[2] = [0.5,0.5];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.5555555555555551,0.9444444444444442,0.9444444444444439,1.555555555555554];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [1.333333333333333,0.6666666666666663,0.0,1.6666666666666652,1.3333333333333326,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.5,0.5];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[2] = [0.0,log(0.0)];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[6] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.214608098422191);
let want_initial: f64[2] = [1.0,0.0];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [4.0,0.0,0.0,0.0];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [3.0,2.0,0.0,0.0,0.0,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [1.0,0.0];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[2] = [-0.6931471805599453,-0.6931471805599453];
let a: f64[4] = [-1.0986122886681098,-0.40546510810816444,-1.0986122886681098,-0.40546510810816444];
let e: f64[6] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455];
let end: f64[2] = [0.0,-0.6931471805599453];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.611774403715661);
let want_initial: f64[2] = [0.3333333333333333,0.6666666666666666];
for k in 2 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[4] = [0.3878787878787879,0.8727272727272726,0.8727272727272726,1.866666666666666];
for k in 4 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[6] = [0.8666666666666661,0.7272727272727272,0.0,2.1333333333333324,1.2727272727272725,0.0];
for k in 6 { near(c.emission[k],want_emission[k]); }
let want_end: f64[2] = [0.33333333333333337,0.6666666666666667];
for k in 2 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.1019143975318944);
let want_initial: f64[3] = [0.5454545454545454,0.2727272727272727,0.1818181818181818];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.5454545454545454,0.0,0.0,0.2727272727272727,0.0,0.0,0.1818181818181818,0.0,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.5454545454545454,0.2727272727272727,0.1818181818181818];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[3] = [0.0,log(0.0),log(0.0)];
let a: f64[9] = [0.0,log(0.0),log(0.0),log(0.0),0.0,log(0.0),log(0.0),log(0.0),0.0];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-1.6094379124341003);
let want_initial: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[1] = [0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[1] = [0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455,-1.203972804325936,-0.5108256237659905,-2.3025850929940455];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[3] = [0.3333333333333333,0.3333333333333333,0.3333333333333333];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.3333333333333333,0.0,0.0,0.3333333333333333,0.0,0.0,0.3333333333333333,0.0,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.3333333333333333,0.3333333333333333,0.3333333333333333];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.9957322735539913);
let want_initial: f64[3] = [0.3333333333333333,0.3333333333333333,0.3333333333333333];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.1111111111111111,0.1111111111111111,0.1111111111111111,0.1111111111111111,0.1111111111111111,0.1111111111111111,0.1111111111111111,0.1111111111111111,0.1111111111111111];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.3333333333333333,0.3333333333333333,0.0,0.3333333333333333,0.3333333333333333,0.0,0.3333333333333333,0.3333333333333333,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.3333333333333333,0.3333333333333333,0.3333333333333333];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[3] = [0.0,log(0.0),log(0.0)];
let a: f64[9] = [0.0,log(0.0),log(0.0),log(0.0),0.0,log(0.0),log(0.0),log(0.0),0.0];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.3025850929940455);
let want_initial: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[2] = [0,1];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[2] = [0,1];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455,-1.203972804325936,-0.5108256237659905,-2.3025850929940455];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-2.659260036932778);
let want_initial: f64[3] = [0.16666666666666666,0.3333333333333333,0.5];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.06349206349206349,0.055555555555555546,0.047619047619047616,0.12698412698412698,0.11111111111111109,0.09523809523809523,0.19047619047619047,0.16666666666666666,0.14285714285714288];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.16666666666666666,0.38095238095238093,0.0,0.3333333333333333,0.33333333333333326,0.0,0.5,0.2857142857142857,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.38095238095238093,0.33333333333333326,0.2857142857142857];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-4.605170185988092);
let want_initial: f64[3] = [0.33333333333333337,0.33333333333333337,0.33333333333333337];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.1111111111111111,0.16666666666666666,0.22222222222222227,0.16666666666666666,0.2222222222222222,0.27777777777777785,0.22222222222222227,0.2777777777777778,0.3333333333333334];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.6666666666666667,0.16666666666666666,0.0,0.6666666666666667,0.3333333333333333,0.0,0.6666666666666667,0.5000000000000001,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.33333333333333337,0.33333333333333337,0.33333333333333337];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[3] = [0.0,log(0.0),log(0.0)];
let a: f64[9] = [0.0,log(0.0),log(0.0),log(0.0),0.0,log(0.0),log(0.0),log(0.0),0.0];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-3.912023005428146);
let want_initial: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [2.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[3] = [0,1,0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[3] = [0,1,0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455,-1.203972804325936,-0.5108256237659905,-2.3025850929940455];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-4.31748811353631);
let want_initial: f64[3] = [0.16666666666666666,0.3333333333333333,0.5];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.06666666666666665,0.12499999999999997,0.17499999999999996,0.12499999999999997,0.23333333333333328,0.32499999999999996,0.175,0.32499999999999996,0.45000000000000007];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.33333333333333326,0.19999999999999996,0.0,0.6666666666666666,0.35,0.0,1.0,0.44999999999999996,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.16666666666666666,0.3333333333333333,0.5];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.907755278982137);
let want_initial: f64[3] = [0.3333333333333333,0.3333333333333333,0.3333333333333333];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.16666666666666666,0.27777777777777757,0.38888888888888945,0.2777777777777775,0.4444444444444442,0.6111111111111116,0.38888888888888923,0.6111111111111113,0.8333333333333337];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.8333333333333348,0.3333333333333335,0.0,1.0000000000000016,0.666666666666667,0.0,1.1666666666666683,1.000000000000001,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.3333333333333333,0.3333333333333333,0.3333333333333331];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[3] = [0.0,log(0.0),log(0.0)];
let a: f64[9] = [0.0,log(0.0),log(0.0),log(0.0),0.0,log(0.0),log(0.0),log(0.0),0.0];
let e: f64[9] = [-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361,-1.6094379124341003,-0.6931471805599453,-1.2039728043259361];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.214608098422191);
let want_initial: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [4.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [3.0,2.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [1.0,0.0,0.0];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0),log(0.0),0.0,log(0.0)];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len > 0 && c.initial.len == 0 && c.transition.len == 0);
}
{
let o: i64[5] = [0,1,0,1,0];
let pi: f64[3] = [-1.0986122886681098,-1.0986122886681098,-1.0986122886681098];
let a: f64[9] = [-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453,-1.791759469228055,-1.0986122886681098,-0.6931471805599453];
let e: f64[9] = [-2.3025850929940455,-0.2231435513142097,-2.3025850929940455,-1.6094379124341003,-0.3566749439387323,-2.3025850929940455,-1.203972804325936,-0.5108256237659905,-2.3025850929940455];
let end: f64[3] = [0.0,-0.6931471805599453,-1.0986122886681098];
let c = bio::hmm_expected_counts(o,pi,a,e,3,end);
assert(c.error.len == 0);
near(c.log_z,-6.178240454251316);
let want_initial: f64[3] = [0.16666666666666669,0.33333333333333337,0.5];
for k in 3 { near(c.initial[k],want_initial[k]); }
let want_transition: f64[9] = [0.09523809523809522,0.20714285714285716,0.3357142857142857,0.20714285714285718,0.43333333333333346,0.6785714285714284,0.3357142857142857,0.6785714285714285,1.0285714285714285];
for k in 9 { near(c.transition[k],want_transition[k]); }
let want_emission: f64[9] = [0.40476190476190466,0.4,0.0,0.9523809523809526,0.6999999999999998,0.0,1.6428571428571441,0.8999999999999999,0.0];
for k in 9 { near(c.emission[k],want_emission[k]); }
let want_end: f64[3] = [0.1666666666666666,0.3333333333333332,0.5];
for k in 3 { near(c.end[k],want_end[k]); }
}
{
let o: i64[4] = [0,1,1,0];
let offsets: i64[3] = [0,2,4];
let pi: f64[2] = [-0.5108256237659907,-0.916290731874155];
let a: f64[4] = [-0.35667494393873245,-1.2039728043259361,-0.916290731874155,-0.5108256237659907];
let e: f64[6] = [-0.6931471805599453,-0.916290731874155,-2.3025850929940455,-2.3025850929940455,-0.2231435513142097,-2.3025850929940455];
let end: f64[2] = [-0.2231435513142097,-1.2039728043259361];
let fit = bio::hmm_train_batch(o,offsets,pi,a,e,3,end,1,1e-14);
assert(fit.error.len == 0 && fit.updates == 1);
let want_initial: f64[2] = [0.7199662097940769,0.2800337902059231];
for k in 2 { near(exp(fit.initial[k]),want_initial[k]); }
let want_transition: f64[4] = [0.8376362350210309,0.1623637649789691,0.8154090767186739,0.18459092328132598];
for k in 4 { near(exp(fit.transition[k]),want_transition[k]); }
let want_emission: f64[6] = [0.5892028592827417,0.4107971407172582,0.0,0.19152785865942168,0.8084721413405783,0.0];
for k in 6 { near(exp(fit.emission[k]),want_emission[k]); }
}
print("48 independent enumerations and frozen batch update passed");
}
