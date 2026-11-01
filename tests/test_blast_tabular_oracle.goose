import bio from "..";
import std;
import bio.io.searchio;
fn main() {
    { let schema = bio::BlastSchema { ["sseqid", "qseqid", "qstart", "qend", "sstart", "send", "qlen", "slen", "qframe", "sframe", "length", "pident", "nident", "mismatch", "gapopen", "gaps", "qseq", "sseq", "evalue", "bitscore", "score"], "translated", "translated" }; let t = bio::parse_blast_table("h\tq\t12\t1\t1\t12\t30\t40\t-1\t1\t4\t75.000\t3\t1\t0\t0\tACGT\tACGA\t0\t12.5\t20\nh\tq\t12\t1\t1\t12\t30\t40\t-1\t1\t4\t75.000\t3\t1\t0\t0\tACGT\tACGA\t0\t12.5\t20\n", copy(schema), false);
        assert(t.error.len == 0);
        let first = t.queries;
        for group in first { for row in group.rows {
            let r = bio::blast_range(copy(row), copy(schema), true);
            assert(r.present && r.start == 0 && r.end == 12 && r.strand == -1);
            assert(!bio::blast_value(copy(row), copy(schema), "ppos").present);
        } }
        let out = bio::write_blast_table(copy(t), copy(schema), true);
        assert(out.error.len == 0); print(out.text);
        let reparsed = bio::parse_blast_table(out.text, copy(schema), true);
        assert(reparsed.error.len == 0 && reparsed.queries.len == t.queries.len);
        let filtered = bio::filter_blast_table(copy(t), "bitscore", 13.0, 100.0);
        assert(filtered.error.len == 0 && filtered.queries.len == t.queries.len);
        for group in filtered.queries { assert(group.rows.len == 0); }
    }
    { let schema = bio::BlastSchema { ["sseqid", "qseqid", "qstart", "qend", "sstart", "send", "qlen", "slen", "qframe", "sframe", "length", "pident", "nident", "mismatch", "gapopen", "gaps", "qseq", "sseq", "evalue", "bitscore", "score"], "translated", "translated" }; let t = bio::parse_blast_table("h\tq\t12\t1\t1\t12\t30\t40\t-1\t1\t4\t75.00\t3\t1\t0\t0\tACGT\tACGA\t0.0\t12.5\t20\nh\tq\t12\t1\t1\t12\t30\t40\t-1\t1\t4\t75.00\t3\t1\t0\t0\tACGT\tACGA\t0.0\t12.5\t20\n", copy(schema), false);
        assert(t.error.len == 0);
        let first = t.queries;
        for group in first { for row in group.rows {
            let r = bio::blast_range(copy(row), copy(schema), true);
            assert(r.present && r.start == 0 && r.end == 12 && r.strand == -1);
            assert(!bio::blast_value(copy(row), copy(schema), "ppos").present);
        } }
        let out = bio::write_blast_table(copy(t), copy(schema), true);
        assert(out.error.len == 0); print(out.text);
        let reparsed = bio::parse_blast_table(out.text, copy(schema), true);
        assert(reparsed.error.len == 0 && reparsed.queries.len == t.queries.len);
        let filtered = bio::filter_blast_table(copy(t), "bitscore", 13.0, 100.0);
        assert(filtered.error.len == 0 && filtered.queries.len == t.queries.len);
        for group in filtered.queries { assert(group.rows.len == 0); }
    }
    { let schema = bio::BlastSchema { ["sseqid", "qseqid", "qstart", "qend", "sstart", "send", "qlen", "slen", "qframe", "sframe", "length", "pident", "nident", "mismatch", "gapopen", "gaps", "qseq", "sseq", "evalue", "bitscore", "score"], "translated", "translated" }; let t = bio::parse_blast_table("# BLASTX 2.0\n# Query: q description\n# Database: offline\n# Fields: subject id, query id, q. start, q. end, s. start, s. end, query length, subject length, query frame, sbjct frame, alignment length, % identity, identical, mismatches, gap opens, gaps, query seq, subject seq, evalue, bit score, score\n# 2 hits found\nh\tq\t12\t1\t1\t12\t30\t40\t-1\t1\t4\t75.000\t3\t1\t0\t0\tACGT\tACGA\t0\t12.5\t20\nh\tq\t12\t1\t1\t12\t30\t40\t-1\t1\t4\t75.000\t3\t1\t0\t0\tACGT\tACGA\t0\t12.5\t20\n# BLASTX 2.0\n# Query: empty\n# Database: offline\n# 0 hits found\n# BLAST processed 2 queries\n", copy(schema), true);
        assert(t.error.len == 0);
        let first = t.queries;
        for group in first { for row in group.rows {
            let r = bio::blast_range(copy(row), copy(schema), true);
            assert(r.present && r.start == 0 && r.end == 12 && r.strand == -1);
            assert(!bio::blast_value(copy(row), copy(schema), "ppos").present);
        } }
        let out = bio::write_blast_table(copy(t), copy(schema), true);
        assert(out.error.len == 0); print(out.text);
        let reparsed = bio::parse_blast_table(out.text, copy(schema), true);
        assert(reparsed.error.len == 0 && reparsed.queries.len == t.queries.len);
        let filtered = bio::filter_blast_table(copy(t), "bitscore", 13.0, 100.0);
        assert(filtered.error.len == 0 && filtered.queries.len == t.queries.len);
        for group in filtered.queries { assert(group.rows.len == 0); }
    }
}
