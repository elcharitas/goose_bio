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
fn training_probe() {
 use ndarray::array;
 let a=array![[0.7,0.3],[0.4,0.6]];
 let e=array![[0.8,0.2],[0.3,0.7]];
 let pi=array![0.6,0.4];
 let seqs=vec![vec![0,1,0],vec![1,1,0]];
 let make=|| discrete_emission_opt_end::Model::with_float(&a,&e,&pi,None).unwrap();
 let model=make();
 let (_,before)=forward(&model,&seqs[0]);
 let _=model.train_baum_welch(&seqs,Some(1),Some(1e-8));
 let (_,after)=forward(&model,&seqs[0]);
 assert_eq!(before,after);
 let sequential=make();
 for seq in &seqs {
  let (p,a,e,end)=baum_welch(&sequential,seq);
  sequential.update_matrices(a,e,p,end);
 }
 let trained=make();
 let _=trained.train_baum_welch(&seqs,Some(2),Some(1e-8));
 let (_,x)=forward(&sequential,&seqs[0]);
 let (_,y)=forward(&trained,&seqs[0]);
 assert_eq!(x,y);
 println!("actual Trainable: one iteration unchanged; two sequential updates verified");
}
fn main() {
 if std::env::args().any(|a|a=="--training") {training_probe(); return;}

 for line in io::stdin().lock().lines() {
 let line=line.unwrap(); let mut p=line.split_whitespace();
 let n:usize=p.next().unwrap().parse().unwrap(); let m:usize=p.next().unwrap().parse().unwrap(); let t:usize=p.next().unwrap().parse().unwrap();
 let mut floats=|k| (0..k).map(|_|p.next().unwrap().parse::<f64>().unwrap()).collect::<Vec<_>>();
 let model=Dense{n,m,i:floats(n),a:floats(n*n),e:floats(n*m),end:floats(n)};
 let obs=(0..t).map(|_|p.next().unwrap().parse::<usize>().unwrap()).collect::<Vec<_>>();
 let (pi,a,e,end)=baum_welch(&model,&obs);
 print!("{}",e.ncols());
 for v in pi.iter().chain(a.iter()).chain(e.iter()).chain(end.iter()) {print!(" {}",v.0);}
 println!();
 }
}
