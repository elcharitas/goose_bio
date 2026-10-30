// Copyright (c) 2026 Jonathan Irhodia. MIT License.
use bio::stats::{LogProb, bayesian::{expected_fdr, bayes_factors::BayesFactor, model::{Model,Likelihood,Prior,Posterior}}};
use std::io::{self,BufRead};
struct L; struct P(Vec<f64>); struct Q;
impl Likelihood for L { type Event=usize; type Data=Vec<f64>;
 fn compute(&self,e:&usize,d:&Vec<f64>,_:&mut ())->LogProb {LogProb(d[*e])} }
impl Prior for P {type Event=usize; fn compute(&self,e:&usize)->LogProb {LogProb(self.0[*e])} }
impl Posterior for Q {type Event=usize;type BaseEvent=usize;type Data=Vec<f64>;
 fn compute<F:FnMut(&usize,&Vec<f64>)->LogProb>(&self,e:&usize,d:&Vec<f64>,f:&mut F)->LogProb {f(e,d)} }
fn main(){for line in io::stdin().lock().lines(){let line=line.unwrap();let mut t=line.split_whitespace();let mode=t.next().unwrap();let v:Vec<f64>=t.map(|x|x.parse().unwrap()).collect();
 match mode {
 "f"=>{for p in expected_fdr(&v.iter().map(|x|LogProb(*x)).collect::<Vec<_>>()){print!("{} ",p.0)}},
 "b"=>{let b=BayesFactor::new(LogProb(v[0]),LogProb(v[1]));print!("{} {}",b.0,b.evidence_kass_raftery());},
 "m"=>{let n=v.len()/2;let model:Model<L,P,Q>=Model::new(L,P(v[..n].to_vec()),Q);let m=model.compute(0..n,&v[n..].to_vec());print!("{} ",m.marginal().0);for i in 0..n{print!("{} ",m.posterior(&i).unwrap().0);}},
 _=>panic!("unknown mode")};println!();}}
