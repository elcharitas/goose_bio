// Copyright (c) 2026 Jonathan Irhodia. MIT license.
use bio::stats::{LogProb, pairhmm::{PairHMM, GapParameters, EmissionParameters, StartEndGapParameters, XYEmission}};
use std::io::{self, BufRead};
struct Input { m: usize, n: usize, fs: bool, fe: bool, g: Vec<f64>, p: Vec<f64>, x: Vec<f64>, y: Vec<f64>, s: Vec<f64>, labels: Vec<f64> }
impl GapParameters for Input {
 fn prob_gap_x(&self)->LogProb {LogProb(self.g[0])}
 fn prob_gap_y(&self)->LogProb {LogProb(self.g[1])}
 fn prob_gap_x_extend(&self)->LogProb {LogProb(self.g[2])}
 fn prob_gap_y_extend(&self)->LogProb {LogProb(self.g[3])}
}
impl EmissionParameters for Input {
 fn len_x(&self)->usize {self.m} fn len_y(&self)->usize {self.n}
 fn prob_emit_xy(&self,i:usize,j:usize)->XYEmission {if self.labels[i*self.n+j] == 0.0 {XYEmission::Match(LogProb(self.p[i*self.n+j]))} else {XYEmission::Mismatch(LogProb(self.p[i*self.n+j]))}}
 fn prob_emit_x(&self,i:usize)->LogProb {LogProb(self.x[i])}
 fn prob_emit_y(&self,j:usize)->LogProb {LogProb(self.y[j])}
}
impl StartEndGapParameters for Input {
 fn free_start_gap_x(&self)->bool {self.fs} fn free_end_gap_x(&self)->bool {self.fe}
 fn prob_start_gap_x(&self,i:usize)->LogProb {LogProb(if self.s.is_empty() {if self.fs {0.0} else {f64::NEG_INFINITY}} else {self.s[i]})}
}
fn main() {
 let mut reused: Option<PairHMM> = None;
 for line in io::stdin().lock().lines() {
 let line=line.unwrap(); let mut it=line.split_whitespace();
 let budget:i64=it.next().unwrap().parse().unwrap();
 let m:usize=it.next().unwrap().parse().unwrap(); let n:usize=it.next().unwrap().parse().unwrap();
 let fs=it.next().unwrap()=="1"; let fe=it.next().unwrap()=="1";
 let v:Vec<f64>=it.map(|s|s.parse().unwrap()).collect();
 let a=4+m*n; let b=a+m; let c=b+n;
 let e=Input{m,n,fs,fe,g:v[..4].to_vec(),p:v[4..a].to_vec(),x:v[a..b].to_vec(),y:v[b..c].to_vec(),s:v[c..v.len()-m*n].to_vec(),labels:v[v.len()-m*n..].to_vec()};
 let limit=if budget<0 {None} else {Some(budget as usize)};
 let hmm=reused.get_or_insert_with(||PairHMM::new(&e));
 let value=hmm.prob_related(&e,&e,limit);
 assert_eq!(value,PairHMM::new(&e).prob_related(&e,&e,limit));
 println!("{:.17e}",*value);
 }
}
