import bio from "..";
import bio.io.searchio;
fn main() {
    let schema = bio::BlastSchema { ["qseqid", "sseqid", "qstart", "qend", "sstart", "send", "length", "nident", "pident", "evalue"], "nucleotide", "protein" };
    let good = "q\th\t3\t1\t1\t3\t3\t2\t66.667\t0\n";
    let table = bio::parse_blast_table(good, copy(schema), false);
    assert(table.error.len == 0);
    for group in table.queries { for row in group.rows {
        let q = bio::blast_range(copy(row), copy(schema), true);
        let h = bio::blast_range(copy(row), copy(schema), false);
        assert(q.start == 0 && q.end == 3 && q.strand == -1);
        assert(h.strand == 0 && h.unit == "protein");
        let zero = bio::blast_value(copy(row), copy(schema), "evalue");
        assert(zero.present && zero.text == "0");
    } }
    for bad in [
        "q\th\t3\t1\t1\t3\t3\t2\t66.667",
        "q\th\t0\t1\t1\t3\t3\t2\t66.667\t0",
        "q\th\t3\t1\t1\t3\t3\t4\t66.667\t0",
        "q\th\t3\t1\t1\t3\t3\t2\t99\t0",
        "q\th\t3\t1\t1\t3\t3\t2\t66.667\tnan",
    ] { assert(bio::parse_blast_table(bad, copy(schema), false).error.len > 0); }
    let singleton_schema = bio::BlastSchema { ["qseqid", "sseqid", "qstart", "qend", "qframe", "sstart", "send", "sframe"], "nucleotide", "translated" };
    let singleton = bio::parse_blast_table("q\th\t5\t5\t-1\t8\t8\t-2", copy(singleton_schema), false);
    assert(singleton.error.len == 0);
    for group in singleton.queries { for row in group.rows {
        assert(bio::blast_range(copy(row), copy(singleton_schema), true).strand == -1);
        assert(bio::blast_range(copy(row), copy(singleton_schema), false).strand == -1);
    } }
    let no_query = bio::BlastSchema { ["sseqid", "evalue"], "nucleotide", "protein" };
    assert(bio::write_blast_table(copy(table), copy(no_query), false).error.len > 0);
    let commented = bio::write_blast_table(copy(table), copy(no_query), true);
    assert(commented.error.len == 0 && bio::parse_blast_table(commented.text, copy(no_query), true).error.len == 0);
    let absent = bio::BlastSchema { ["qseqid", "sseqid", "score"], "nucleotide", "protein" };
    assert(bio::write_blast_table(copy(table), copy(absent), false).error.len > 0);
    assert(bio::filter_blast_table(copy(table), "bitscore", 0.0, 1.0).error.len > 0);
    let output = bio::BlastSchema { ["evalue", "sseqid", "qseqid"], "nucleotide", "protein" };
    let written = bio::write_blast_table(copy(table), copy(output), false);
    assert(written.error.len == 0 && written.text == "0\th\tq\n");
    for bad in ["# Query: q\n# 1 hits found\n", "# Query: q\n", "# Query: q\n# Fields: query id\n# 0 hits found\n"] {
        assert(bio::parse_blast_table(bad, copy(schema), true).error.len > 0);
    }
}
