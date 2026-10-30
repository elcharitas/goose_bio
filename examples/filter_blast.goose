import bio from "..";

fn main() {
    let schema = bio::BlastSchema {
        ["qseqid", "sseqid", "qstart", "qend", "sstart", "send", "evalue", "bitscore"],
        "nucleotide", "nucleotide"
    };
    let input = "q1\thit1\t1\t10\t20\t11\t1e-12\t50\nq1\thit2\t1\t10\t1\t10\t0.1\t8\n";
    let parsed = bio::parse_blast_table(input, copy(schema), false);
    assert(parsed.error.len == 0);
    let selected = bio::filter_blast_table(copy(parsed), "evalue", 0.0, 1e-5);
    assert(selected.error.len == 0);
    for query in selected.queries { for hit in query.rows {
        let range = bio::blast_range(copy(hit), copy(schema), false);
        assert(range.start == 10 && range.end == 20 && range.strand == -1);
    } }
    let output = bio::write_blast_table(copy(selected), copy(schema), true);
    assert(output.error.len == 0);
    print(output.text);
}
