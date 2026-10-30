// Copyright (c) 2026 Jonathan Irhodia. MIT License.
use bio::stats::{hmm::*, LogProb};
use std::io::{self, BufRead};
struct Dense { n: usize, m: usize, i: Vec<f64>, a: Vec<f64>, e: Vec<f64>, end: Vec<f64> }
impl Model<usize> for Dense {
 fn num_states(&self)->usize {self.n}
 fn states(&self)->StateIter {StateIter::new(self.n)}
 fn transitions(&self)->StateTransitionIter {StateTransitionIter::new(self.n)}
 fn initial_prob(&self,s:State)->LogProb {LogProb(self.i[s.0])}
 fn transition_prob(&self,s:State,t:State)->LogProb {LogProb(self.a[s.0*self.n+t.0])}
 fn observation_prob(&self,s:State,o:&usize)->LogProb {LogProb(self.e[s.0*self.m+o])}
 fn end_prob(&self,s:State)->LogProb {LogProb(self.end[s.0])}
}
fn main() {
 for line in io::stdin().lock().lines() {
 let line=line.unwrap(); let mut p=line.split_whitespace();
 let n:usize=p.next().unwrap().parse().unwrap(); let m:usize=p.next().unwrap().parse().unwrap(); let t:usize=p.next().unwrap().parse().unwrap();
 let mut floats=|k| (0..k).map(|_|p.next().unwrap().parse::<f64>().unwrap()).collect::<Vec<_>>();
 let model=Dense{n,m,i:floats(n),a:floats(n*n),e:floats(n*m),end:floats(n)};
 let obs=(0..t).map(|_|p.next().unwrap().parse::<usize>().unwrap()).collect::<Vec<_>>();
 let (a,z)=forward(&model,&obs); let (b,bz)=backward(&model,&obs);
 print!("{} {}",z.0,bz.0);
 for v in a.iter(){print!(" {}",v.0);}
 for k in 0..t {for s in 0..n {print!(" {}",b[[t-1-k,s]].0);}}
 println!();
 }
}
