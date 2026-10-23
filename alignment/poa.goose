namespace bio;
import std;

struct PoaEdge { from: i64, to: i64 }

/* Byte nodes have nonnegative support, directed edges, start/end sets, and an optional empty path.
 * Every node belongs to a start-to-end path. IDs are storage indexes, not topological ranks; duplicate
 * endpoints are harmless. Graphs can encode recombinant paths and retain neither edge counts nor read
 * provenance. */
struct PoaGraph {
    bases: u8[], weights: i64[], edges: PoaEdge[],
    starts: i64[], ends: i64[], empty: bool
}
struct PoaOrder { nodes: i64[], error: u8[] }

/* Equal bytes earn match_score; unequal bytes earn mismatch; insertions/deletions cost nonnegative
 * gap. Both ends are penalized. Magnitudes and gap cost cap at one million. No
 * affine/local/clipping/matrix/callback policy. */
struct PoaScoring { match_score: i64, mismatch: i64, gap: i64 }

/* Trace arrays have equal length: node -1 means query insertion; query index -1 means graph deletion;
 * other pairs consume both. Graph nodes follow start-to-end edges and query indexes run 0..length-1.
 * Reachability tags distinguish unreachable cells from negative scores. */
struct PoaAlignment {
    score: i64, nodes: i64[], query_indices: i64[], error: u8[]
}

/* Errors preserve the input and return an empty placeholder graph; check error. Updates copy graphs,
 * scan duplicate new edges, and validate again. */
struct PoaUpdate { graph: PoaGraph, error: u8[] }

/* Maximizes summed node support, not per-column majority, edge support, or probability. Longer paths
 * can beat more frequent shorter reads. Empty paths score zero; ties follow topological traversal and
 * stored edge/end order. */
struct PoaConsensus { sequence: u8[], weight: i64, error: u8[] }

/* Copies a single path with unit support; validation occurs before alignment, update, or consensus.
 */
fn poa_sequence(s: const u8[:]) -> PoaGraph {
    var bases: u8[>..] = []; var weights: i64[>..] = []; var edges: PoaEdge[>..] = [];
    var starts: i64[>..] = []; var ends: i64[>..] = [];
    for c, i in s {
        bases.push(c); weights.push(1);
        if i > 0 { edges.push(PoaEdge { i-1, i }); }
    }
    if s.len > 0 { starts.push(0); ends.push(s.len-1); }
    return PoaGraph { copy(bases), copy(weights), copy(edges), copy(starts), copy(ends), s.len == 0 };
}

/* Checks shape, endpoints, duplicate edges, weights, reachability, and cycles using deterministic Kahn
 * order. Cycles and self-edges reject. Caps: 4,096 nodes, 65,536 edges, 4,096 entries per endpoint
 * list, and weights <=one billion. Explicit scans cost O(E²+VE+V²). */
fn poa_order(g: const PoaGraph&) -> PoaOrder {
    let bad = PoaOrder { [], "invalid DAG, counts, or resource bound" };
    let n = g.bases.len;
    if n > 4096 || g.weights.len != n || g.edges.len > 65536 || g.starts.len > 4096 || g.ends.len > 4096 { return bad; }
    var degree: i64[>..] = []; var seen: bool[>..] = [];
    for i in n {
        if g.weights[i] < 0 || g.weights[i] > 1000000000 { return bad; }
        degree.push(0); seen.push(false);
    }
    for e, i in g.edges {
        if e.from < 0 || e.to < 0 || e.from >= n || e.to >= n { return bad; }
        for p, j in g.edges { if j < i && e.from == p.from && e.to == p.to { return bad; } }
        degree[e.to] += 1;
    }
    for v in g.starts { if v < 0 || v >= n { return bad; } }
    for v in g.ends { if v < 0 || v >= n { return bad; } }
    var order: i64[>..] = [];
    for step in n {
        var v: i64 = -1;
        for i in n { if !seen[i] && degree[i] == 0 && v < 0 { v = i; } }
        if v < 0 { return bad; }
        seen[v] = true; order.push(v);
        for e in g.edges { if e.from == v { degree[e.to] -= 1; } }
    }
    var reach: bool[>..] = []; var finish: bool[>..] = [];
    for i in n { reach.push(false); finish.push(false); }
    for v in g.starts { reach[v] = true; }
    for v in order { for e in g.edges { if e.from == v && reach[v] { reach[e.to] = true; } } }
    for v in g.ends { finish[v] = true; }
    for k in n { let v = order[n-1-k]; for e in g.edges { if e.from == v && finish[e.to] { finish[v] = true; } } }
    for i in n { if !reach[i] || !finish[i] { return bad; } }
    if n == 0 && !g.empty { return bad; }
    return PoaOrder { order, "" };
}

/* Maximizes global score over allowed paths. Caps: 100,000 query bytes and two million cells. Ties
 * retain deletion before diagonal per predecessor, then insertion; start precedes stored edges, and
 * end ties follow end-list order. Costs O(VE(Q+1)+V(Q+1)) time plus validation and O(V(Q+1)) space.
 * No banding, SIMD, or alternate terminal policies. */
fn poa_align(g: const PoaGraph&, q: const u8[:], s: PoaScoring) -> PoaAlignment {
    let bad = PoaAlignment { 0, [], [], "invalid graph, scoring, or cell bound" };
    let order = poa_order(g);
    if order.error.len > 0 || q.len > 100000 || (g.bases.len+1)*(q.len+1) > 2000000
        || s.match_score < -1000000 || s.match_score > 1000000
        || s.mismatch < -1000000 || s.mismatch > 1000000 || s.gap < 0 || s.gap > 1000000 { return bad; }
    let w = q.len+1; let cells = (g.bases.len+1)*w;
    var d: i64[>..] = []; var prev: i64[>..] = []; var op: i64[>..] = [];
    for k in cells { d.push(0); prev.push(-1); op.push(-1); }
    prev[0] = 0;
    for j in 1..w { d[j] = -j*s.gap; prev[j] = j-1; op[j] = 2; }
    for v in order.nodes {
        let row = (v+1)*w;
        for j in w {
            for pass in 0..g.edges.len+1 {
                var p: i64 = -2;
                if pass == 0 { for start in g.starts { if start == v { p = -1; } } }
                else { let e = g.edges[pass-1]; if e.to == v { p = e.from; } }
                if p == -2 { continue; }
                let before = (p+1)*w+j;
                if prev[before] >= 0 {
                    let value = d[before]-s.gap;
                    if prev[row+j] < 0 || value > d[row+j] { d[row+j] = value; prev[row+j] = before; op[row+j] = 1; }
                }
                if j > 0 && prev[before-1] >= 0 {
                    let value = d[before-1]+(if g.bases[v] == q[j-1] { s.match_score } else { s.mismatch });
                    if prev[row+j] < 0 || value > d[row+j] { d[row+j] = value; prev[row+j] = before-1; op[row+j] = 0; }
                }
            }
            if j > 0 && prev[row+j-1] >= 0 {
                let value = d[row+j-1]-s.gap;
                if prev[row+j] < 0 || value > d[row+j] { d[row+j] = value; prev[row+j] = row+j-1; op[row+j] = 2; }
            }
        }
    }
    var end: i64 = if g.empty { q.len } else { -1 };
    for v in g.ends { let cell = (v+1)*w+q.len; if end < 0 || d[cell] > d[end] { end = cell; } }
    if end < 0 { return bad; }
    let score = d[end]; var rn: i64[>..] = []; var rq: i64[>..] = [];
    while end != 0 {
        let action = op[end];
        rn.push(if action == 2 { -1 } else { end/w-1 });
        rq.push(if action == 1 { -1 } else { end%w-1 }); end = prev[end];
    }
    var ns: i64[>..] = []; var qs: i64[>..] = [];
    for k in rn.len { ns.push(rn[rn.len-1-k]); qs.push(rq[rq.len-1-k]); }
    return PoaAlignment { score, ns, qs, "" };
}

/* Computes an alignment: equal pairs reuse nodes and add one support; mismatches/insertions create
 * unit nodes; deletions skip nodes. Consecutive read nodes gain edges; endpoints retain old paths and
 * add the new one. Empty reads add the empty path. Revalidation includes new edges to lower IDs. */
fn poa_add_read(g: const PoaGraph&, q: const u8[:], s: PoaScoring) -> PoaUpdate {
    var bases: u8[>..] = []; var weights: i64[>..] = []; var edges: PoaEdge[>..] = [];
    var starts: i64[>..] = []; var ends: i64[>..] = []; var empty = g.empty;
    let a = poa_align(g,q,s);
    if a.error.len > 0 { return PoaUpdate { PoaGraph { [], [], [], [], [], true }, copy(a.error) }; }
    for c in g.bases { bases.push(c); }
    for weight in g.weights { weights.push(weight); }
    for e in g.edges { edges.push(e); }
    for v in g.starts { starts.push(v); }
    for v in g.ends { ends.push(v); }
    var last: i64 = -1;
    for node, k in a.nodes {
        let j = a.query_indices[k]; if j < 0 { continue; }
        var v = node;
        if v < 0 || bases[v] != q[j] {
            v = bases.len; bases.push(q[j]); weights.push(0);
        }
        weights[v] += 1;
        if last < 0 {
            var found = false; for start in starts { if start == v { found = true; } }
            if !found { starts.push(v); }
        } else {
            var found = false; for e in edges { if e.from == last && e.to == v { found = true; } }
            if !found { edges.push(PoaEdge { last, v }); }
        }
        last = v;
    }
    if last < 0 { empty = true; }
    else { var found = false; for v in ends { if v == last { found = true; } } if !found { ends.push(last); } }
    let out = PoaGraph { copy(bases), copy(weights), copy(edges), copy(starts), copy(ends), empty };
    let valid = poa_order(out);
    if valid.error.len > 0 { return PoaUpdate { PoaGraph { [], [], [], [], [], true }, copy(valid.error) }; }
    return PoaUpdate { out, "" };
}

/* Uses O(VE) time plus validation and O(V) extra space. These explicit validation and traversal
 * methods favor checks over throughput. */
fn poa_consensus(g: const PoaGraph&) -> PoaConsensus {
    let order = poa_order(g);
    if order.error.len > 0 { return PoaConsensus { "", 0, copy(order.error) }; }
    var d: i64[>..] = []; var prev: i64[>..] = [];
    for v in g.bases.len { d.push(-1); prev.push(-1); }
    for v in g.starts { d[v] = g.weights[v]; }
    for v in order.nodes {
        for e in g.edges { if e.to == v && d[e.from] >= 0 {
            let value = d[e.from]+g.weights[v];
            if value > d[v] { d[v] = value; prev[v] = e.from; }
        } }
    }
    var end: i64 = -1; var best: i64 = if g.empty { 0 } else { -1 };
    for v in g.ends { if d[v] > best { best = d[v]; end = v; } }
    var rev: u8[>..] = []; while end >= 0 { rev.push(g.bases[end]); end = prev[end]; }
    var seq: u8[>..] = []; for k in rev.len { seq.push(rev[rev.len-1-k]); }
    return PoaConsensus { copy(seq), best, "" };
}
