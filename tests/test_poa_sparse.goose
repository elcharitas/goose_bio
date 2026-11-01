import std;
import bio from "..";
import bio.alignment.poa;
import bio.alignment.sparse_alignment;
fn main() {
    let s = bio::PoaScoring { 2, -2, 3 };
    let g = bio::poa_sequence("ACGT");
    assert(bio::poa_align(g, "ACGT", s).score == 8);
    for q in ["ACGT", "ATGT", "ACGGT", "AGT", ""] {
        let a = bio::poa_align(g, q, s); assert(a.error.len == 0); assert(a.score == linear_oracle("ACGT", q));
        var next: i64 = 0; var prior: i64 = -1; var score: i64 = 0;
        for v, k in a.nodes {
            let j = a.query_indices[k];
            if v >= 0 { assert(v == prior + 1); prior = v; }
            if j >= 0 { assert(j == next); next += 1; }
            if v < 0 || j < 0 { score -= 3; }
            else { score += if g.bases[v] == q[j] { 2 } else { -2 }; }
        }
        assert(next == q.len && prior == 3 && score == a.score);
        let u = bio::poa_add_read(g, q, s); assert(u.error.len == 0);
        assert(bio::poa_align(u.graph, q, s).score == q.len * 2);
        assert(g.bases.len == 4 && g.weights[0] == 1);
    }
    let inserted = bio::poa_add_read(g, "ACGGT", s);
    assert(bio::poa_order(inserted.graph).error.len == 0);
    let again = bio::poa_add_read(inserted.graph, "ACGGT", s);
    assert(bio::poa_consensus(again.graph).sequence == "ACGGT");
    let cycle = bio::PoaGraph { "AC", [1, 1], [bio::PoaEdge { 0, 1 }, bio::PoaEdge { 1, 0 }], [0], [1], false };
    assert(bio::poa_align(cycle, "A", s).error.len > 0);
    assert(bio::poa_add_read(cycle, "A", s).error.len > 0);
    let empty = bio::poa_sequence(""); assert(bio::poa_align(empty, "AA", s).score == -6);
    assert(bio::poa_consensus(empty).sequence.len == 0);
    let chain = bio::sparse_kmer_chain("ACGT", "ACGT", 2);
    assert(chain.error.len == 0 && chain.score == 4);
    assert(bio::sparse_kmer_chain("AAAA", "AAAA", 1, 2).error.len > 0);
    assert(bio::sparse_chain([bio::SparseAnchor { -1, 0, 1 }]).error.len > 0);
    // Exhaust all four-node forward DAGs with a mandatory backbone.
    for mask in 8 {
        var edges: bio::PoaEdge[>..] = [bio::PoaEdge { 3, 2 }, bio::PoaEdge { 2, 1 }, bio::PoaEdge { 1, 0 }];
        if mask % 2 == 1 { edges.push(bio::PoaEdge { 3, 1 }); }
        if (mask / 2) % 2 == 1 { edges.push(bio::PoaEdge { 3, 0 }); }
        if (mask / 4) % 2 == 1 { edges.push(bio::PoaEdge { 2, 0 }); }
        let dag = bio::PoaGraph { "BABA", [1, 1, 1, 1], copy(edges), [3], [0], false };
        for query in ["", "A", "B", "AA", "AB", "BA", "BB", "ABA", "BAB", "ABAB"] {
            var best: i64 = -1000000;
            for subset in 4 {
                var path: i64[>..] = [3];
                if subset % 2 == 1 { path.push(2); }
                if subset / 2 == 1 { path.push(1); }
                path.push(0);
                var valid = true; var seq: u8[>..] = [];
                for v, i in path {
                    seq.push(dag.bases[v]);
                    if i > 0 { var found = false; for e in edges { if e.from == path[i - 1] && e.to == v { found = true; } } if !found { valid = false; } }
                }
                if valid { let value = linear_oracle(seq, query); if value > best { best = value; } }
            }
            let result = bio::poa_align(dag, query, s); assert(result.error.len == 0 && result.score == best);
            var last: i64 = -1; var next: i64 = 0; var replay: i64 = 0;
            for v, i in result.nodes {
                let j = result.query_indices[i];
                if v >= 0 {
                    if last < 0 { assert(v == 3); }
                    else { var found = false; for e in edges { if e.from == last && e.to == v { found = true; } } assert(found); }
                    last = v;
                }
                if j >= 0 { assert(j == next); next += 1; }
                replay += if v < 0 || j < 0 { -3 } else if dag.bases[v] == query[j] { 2 } else { -2 };
            }
            assert(last == 0 && next == query.len && replay == best);
        }
    }
    // Enumerate subsets independently of the chain recurrence.
    for seed in 64 {
        var anchors: bio::SparseAnchor[>..] = [];
        for i in 4 { anchors.push(bio::SparseAnchor { (seed + i * 3) % 5, (seed / 3 + i * 2) % 5, 1 + (seed + i) % 2 }); }
        var best: i64 = 0;
        for subset in 16 {
            var score: i64 = 0; var valid = true; var bits = subset;
            for a, i in anchors {
                let selected = bits % 2 == 1; bits /= 2;
                if !selected { continue; } score += a.length;
                var other = subset;
                for b, j in anchors {
                    let chosen = other % 2 == 1; other /= 2;
                    if !chosen || i == j { continue; }
                    if !((a.a + a.length <= b.a && a.b + a.length <= b.b) || (b.a + b.length <= a.a && b.b + b.length <= a.b)) { valid = false; }
                }
            }
            if valid && score > best { best = score; }
        }
        assert(bio::sparse_chain(anchors).score == best);
    }
    let tie = bio::PoaGraph { "AB", [2, 2], [], [0, 1], [0, 1], false };
    assert(bio::poa_consensus(tie).sequence == "A");
    let malformed = bio::PoaGraph { "A", [], [], [0], [0], false };
    assert(bio::poa_order(malformed).error.len > 0);
    assert(bio::poa_align(g, "A", bio::PoaScoring { 2, -2, -1 }).error.len > 0);
    assert(bio::sparse_kmer_chain("AAAA", "AAAA", 1, 64, 2).error.len > 0);
    print("POA and sparse checks pass");
}

fn linear_oracle(a: const u8[:], b: const u8[:]) -> i64 {
    var row: i64[>..] = []; for j in b.len + 1 { row.push(-3 * j); }
    for c, i in a {
        var diagonal = row[0]; row[0] = -3 * (i + 1);
        for d, j in b {
            let above = row[j + 1];
            var value = diagonal + (if c == d { 2 } else { -2 });
            if above - 3 > value { value = above - 3; }
            if row[j] - 3 > value { value = row[j] - 3; }
            row[j + 1] = value; diagonal = above;
        }
    }
    return row[b.len];
}
