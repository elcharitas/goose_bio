import bio from "..";
import bio.io.compass;
fn main() {
    let text = "Ali1: query Ali2: hit\nThreshold of effective gap content in columns: 0.5\nlength1=4 filtered_length1=3.5 length2=4 filtered_length2=3\nNseqs1=2 Neff1=1.5 Nseqs2=2 Neff2=1.25\nSmith-Waterman score = 8 Evalue = 1e-9\n1              A=CD\n               + ++\n2              ABCD\n";
    let result = bio::read_compass(text);
    assert(result.error.code.len == 0);
    for r in result.records {
        print(r.query); print(r.hit); print(r.positives);
        print(bio::compass_coverage(r.query_aln));
    }
}
