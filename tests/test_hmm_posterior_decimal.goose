// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.stats.hmm_posterior;
import math;
fn near(a: f64,b: f64) { if is_inf(b) { assert(a == b); } else { assert(abs(a-b)<=1e-10*(1.0+abs(b))); } }
fn main() {
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+16,-1e+16];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+16);
let alpha: f64[6] = [-1e+16,-1.0000000000000002e+16,-1e+16,-1.0000000000000002e+16,-1e+16,-1.0000000000000002e+16];
let beta: f64[6] = [-0.8111119731562731,-1.5408686689199889,-0.5044545354020371,-1.2288993340522223,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8493812963297808,0.15061870367021923,0.8783926002291165,0.1216073997708835,0.8822568681208941,0.11774313187910591];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-1e+16,-1e+16];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-3e+16);
let alpha: f64[6] = [-1e+16,-1.0000000000000002e+16,-2e+16,-2e+16,-3e+16,-3e+16];
let beta: f64[6] = [-2e+16,-2e+16,-1e+16,-1e+16,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.7948321688116415,0.20516783118835846,0.6672382946779735,0.33276170532202654,0.6741372007159108,0.3258627992840892];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-1e+16,-1e+16,-1e+16,-1e+16];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-2e+16);
let alpha: f64[6] = [-0.55,-2.55,-1e+16,-1.0000000000000002e+16,-2e+16,-2e+16];
let beta: f64[6] = [-2e+16,-2e+16,-1e+16,-1e+16,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8807970779778824,0.11920292202211755,0.7310585786300049,0.2689414213699951,0.8455347349164654,0.1544652650835347];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-1e+16,-1e+16];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+16);
let alpha: f64[6] = [-0.55,-2.55,-0.9014126484262579,-2.3485867220172474,-1.2184163462519595,-2.573667330246924];
let beta: f64[6] = [-1e+16,-1.0000000000000002e+16,-1e+16,-1e+16,-1e+16,-1e+16];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.9362919889014162,0.06370801109858383,0.8793912588278596,0.1206087411721404,0.7949867740142528,0.2050132259857472];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+100,-1e+100];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+100);
let alpha: f64[6] = [-1e+100,-1e+100,-1e+100,-1e+100,-1e+100,-1e+100];
let beta: f64[6] = [-0.8111119731562731,-1.5408686689199889,-0.5044545354020371,-1.2288993340522223,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8493812963297808,0.15061870367021923,0.8783926002291165,0.1216073997708835,0.8822568681208941,0.11774313187910591];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-1e+100,-1e+100];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-3e+100);
let alpha: f64[6] = [-1e+100,-1e+100,-2e+100,-2e+100,-3.0000000000000002e+100,-3.0000000000000002e+100];
let beta: f64[6] = [-2e+100,-2e+100,-1e+100,-1e+100,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.7948321688116415,0.20516783118835846,0.6672382946779735,0.33276170532202654,0.6741372007159108,0.3258627992840892];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-1e+100,-1e+100,-1e+100,-1e+100];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-2e+100);
let alpha: f64[6] = [-0.55,-2.55,-1e+100,-1e+100,-2e+100,-2e+100];
let beta: f64[6] = [-2e+100,-2e+100,-1e+100,-1e+100,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8807970779778824,0.11920292202211755,0.7310585786300049,0.2689414213699951,0.8455347349164654,0.1544652650835347];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-1e+100,-1e+100];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+100);
let alpha: f64[6] = [-0.55,-2.55,-0.9014126484262579,-2.3485867220172474,-1.2184163462519595,-2.573667330246924];
let beta: f64[6] = [-1e+100,-1e+100,-1e+100,-1e+100,-1e+100,-1e+100];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.9362919889014162,0.06370801109858383,0.8793912588278596,0.1206087411721404,0.7949867740142528,0.2050132259857472];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+300,-1e+300];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+300);
let alpha: f64[6] = [-1e+300,-1e+300,-1e+300,-1e+300,-1e+300,-1e+300];
let beta: f64[6] = [-0.8111119731562731,-1.5408686689199889,-0.5044545354020371,-1.2288993340522223,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8493812963297808,0.15061870367021923,0.8783926002291165,0.1216073997708835,0.8822568681208941,0.11774313187910591];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-1e+300,-1e+300];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-3e+300);
let alpha: f64[6] = [-1e+300,-1e+300,-2e+300,-2e+300,-3e+300,-3e+300];
let beta: f64[6] = [-2e+300,-2e+300,-1e+300,-1e+300,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.7948321688116415,0.20516783118835846,0.6672382946779735,0.33276170532202654,0.6741372007159108,0.3258627992840892];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-1e+300,-1e+300,-1e+300,-1e+300];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-0.2,-0.9];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-2e+300);
let alpha: f64[6] = [-0.55,-2.55,-1e+300,-1e+300,-2e+300,-2e+300];
let beta: f64[6] = [-2e+300,-2e+300,-1e+300,-1e+300,-0.2,-0.9];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8807970779778824,0.11920292202211755,0.7310585786300049,0.2689414213699951,0.8455347349164654,0.1544652650835347];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-0.25,-1.25];
let a: f64[4] = [-0.1,-0.7,-1.1,-0.2];
let e: f64[2] = [-0.3,-1.3];
let b: f64[2] = [-1e+300,-1e+300];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+300);
let alpha: f64[6] = [-0.55,-2.55,-0.9014126484262579,-2.3485867220172474,-1.2184163462519595,-2.573667330246924];
let beta: f64[6] = [-1e+300,-1e+300,-1e+300,-1e+300,-1e+300,-1e+300];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.9362919889014162,0.06370801109858383,0.8793912588278596,0.1206087411721404,0.7949867740142528,0.2050132259857472];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[1] = [0];
let i: f64[2] = [-1e+16,-1e+16];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [0.0,0.0];
let b: f64[2] = [0.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+16);
let alpha: f64[2] = [-1e+16,-1e+16];
let beta: f64[2] = [0.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[2] = [0.5,0.5];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 1 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[1] = [0];
let i: f64[2] = [-1e+300,-1e+300];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [-0.25,-1.25];
let b: f64[2] = [0.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+300);
let alpha: f64[2] = [-1e+300,-1e+300];
let beta: f64[2] = [0.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[2] = [0.7310585786300049,0.2689414213699951];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 1 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[1] = [0];
let i: f64[2] = [-1e+16,-1.0000000000000002e+16];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [0.0,0.0];
let b: f64[2] = [-2.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1.0000000000000002e+16);
let alpha: f64[2] = [-1e+16,-1.0000000000000002e+16];
let beta: f64[2] = [-2.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[2] = [0.5,0.5];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 1 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+16,log(0.0)];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[2] = [0.0,-0.5];
let b: f64[2] = [0.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+16);
let alpha: f64[6] = [-1e+16,log(0.0),-1e+16,log(0.0),-1e+16,log(0.0)];
let beta: f64[6] = [0.0,-1.0,0.0,-0.5,0.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [1.0,0.0,1.0,0.0,1.0,0.0];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+100,-1e+100];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[2] = [0.0,-0.5];
let b: f64[2] = [log(0.0),0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+100);
let alpha: f64[6] = [-1e+100,-1e+100,-1e+100,-1e+100,-1e+100,-1e+100];
let beta: f64[6] = [log(0.0),-1.0,log(0.0),-0.5,log(0.0),0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.0,1.0,0.0,1.0,0.0,1.0];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+16,-1e+16];
let a: f64[4] = [0.0,log(0.0),log(0.0),0.0];
let e: f64[2] = [0.0,-0.5];
let b: f64[2] = [log(0.0),log(0.0)];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,log(0.0));
let alpha: f64[6] = [-1e+16,-1e+16,-1e+16,-1e+16,-1e+16,-1.0000000000000002e+16];
let beta: f64[6] = [log(0.0),log(0.0),log(0.0),log(0.0),log(0.0),log(0.0)];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
assert(!got.defined && got.posterior.len == 0);
}
{
let o: i64[1] = [0];
let i: f64[2] = [-1e+308,-1e+308];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [0.0,-1.0];
let b: f64[2] = [0.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+308);
let alpha: f64[2] = [-1e+308,-1e+308];
let beta: f64[2] = [0.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[2] = [0.7310585786300049,0.2689414213699951];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 1 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+16,-1.0000000000000002e+16];
let a: f64[4] = [0.0,-2.0,-2.0,0.0];
let e: f64[2] = [0.0,-0.5];
let b: f64[2] = [-2.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1.0000000000000002e+16);
let alpha: f64[6] = [-1e+16,-1.0000000000000002e+16,-1e+16,-1.0000000000000002e+16,-1e+16,-1.0000000000000002e+16];
let beta: f64[6] = [-1.3141196100122035,-0.8954761825852946,-1.5259230158198933,-0.47024958172737946,-2.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.8890778869314708,0.11092211306852923,0.7273655584331571,0.27263444156684286,0.4607470027035409,0.539252997296459];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[1] = [0];
let i: f64[2] = [0.0,log(0.0)];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [0.0,0.0];
let b: f64[2] = [-1e+300,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+300);
let alpha: f64[2] = [0.0,log(0.0)];
let beta: f64[2] = [-1e+300,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[2] = [1.0,0.0];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 1 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[2] = [0,0];
let i: f64[2] = [0.0,0.0];
let a: f64[4] = [-1e+300,-1e+300,-1e+300,-1e+300];
let e: f64[2] = [0.0,-1.0];
let b: f64[2] = [-1e+300,-1e+300];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-2e+300);
let alpha: f64[4] = [0.0,-1.0,-1e+300,-1e+300];
let beta: f64[4] = [-2e+300,-2e+300,-1e+300,-1e+300];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[4] = [0.7310585786300049,0.2689414213699951,0.7310585786300049,0.2689414213699951];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 2 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[3] = [0,0,0];
let i: f64[2] = [-1e+16,-1e+16];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [-0.25,-1.25];
let b: f64[2] = [-1e+16,-1e+16];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-2e+16);
let alpha: f64[6] = [-1e+16,-1.0000000000000002e+16,-1e+16,-1.0000000000000002e+16,-1e+16,-1.0000000000000002e+16];
let beta: f64[6] = [-1e+16,-1e+16,-1e+16,-1e+16,-1e+16,-1e+16];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[6] = [0.7310585786300049,0.2689414213699951,0.7310585786300049,0.2689414213699951,0.7310585786300049,0.2689414213699951];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 3 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[1] = [0];
let i: f64[2] = [0.0,-1e+16];
let a: f64[4] = [0.0,0.0,0.0,0.0];
let e: f64[2] = [-1e+16,-0.25];
let b: f64[2] = [0.0,0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len == 0);
near(got.log_z,-1e+16);
let alpha: f64[2] = [-1e+16,-1e+16];
let beta: f64[2] = [0.0,0.0];
for j in alpha.len { near(got.alpha[j],alpha[j]); near(got.beta[j],beta[j]); }
let p: f64[2] = [0.5621765008857981,0.4378234991142019];
assert(got.defined);
for j in p.len { near(got.posterior[j],p[j]); }
for k in 1 { var total = 0.0; for s in 2 { total += got.posterior[k*2+s]; } near(total,1.0); }
}
{
let o: i64[1] = [0];
let i: f64[1] = [-1e+308];
let a: f64[1] = [0.0];
let e: f64[1] = [-1e+308];
let b: f64[1] = [0.0];
let got = bio::hmm_posterior_log(o,i,a,e,1,b);
assert(got.error.len > 0 && !got.defined);
}
print("25 Decimal centered posterior cases passed");
}
