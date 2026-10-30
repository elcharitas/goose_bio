use bio::stats::combinatorics::{combinations, combinations_with_repl, scaled_combinations};
use std::io::{self, BufRead};
fn main() {
    for line in io::stdin().lock().lines() {
        let line = line.unwrap();
        let p: Vec<_> = line.split_whitespace().collect();
        let n = p[1].parse::<u64>().unwrap();
        let k = p[2].parse::<u64>().unwrap();
        let v = match p[0] {
            "c" => combinations(n, k),
            "r" => combinations_with_repl(n, k),
            "s" => scaled_combinations(n, k, p[3].parse().unwrap()),
            _ => panic!("unknown operation"),
        };
        println!("{v:.17e}");
    }
}
