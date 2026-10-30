// Copyright (c) 2026 Jonathan Irhodia. MIT license.
use bio::{alphabets::dna,data_structures::{suffix_array::suffix_array,bwt::{bwt,less,Occ},fmindex::{FMIndex,FMDIndex}}};
use std::io::{self,BufRead};

fn main() {
 for line in io::stdin().lock().lines() {
  let line=line.unwrap(); let parts:Vec<_>=line.split('\t').collect();
  let text=parts[0].as_bytes(); let query=parts[1].as_bytes(); let ops=parts[2].as_bytes();
  let alphabet=dna::n_alphabet(); let sa=suffix_array(text); let bw=bwt(text,&sa);
  let le=less(&bw,&alphabet); let occ=Occ::new(&bw,3,&alphabet);
  let fmd=FMDIndex::from(FMIndex::new(&bw,&le,&occ));
  let mut s=fmd.init_interval(); let mut states=vec![];
  for (&c,&op) in query.iter().zip(ops) {
   s=if op==b'L' {fmd.backward_ext(&s,c)} else {fmd.forward_ext(&s,c)};
   states.push((s.forward().lower,s.revcomp().lower,s.forward().upper-s.forward().lower,s.forward().occ(&sa)));
  }
  let sm:Vec<_>=fmd.all_smems(query,1).iter().map(|(s,p,l)|(*p,*l,s.forward().lower,s.revcomp().lower,s.forward().upper-s.forward().lower)).collect();
  let anchors:Vec<_>=(0..query.len()).map(|i| fmd.smems(query,i,1).iter().map(|(_,p,l)|(*p,*l)).collect::<Vec<_>>()).collect();
  println!("{:?}",(sa,states,sm,anchors));
 }
}
