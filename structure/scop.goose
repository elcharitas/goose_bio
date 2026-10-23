// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
struct ScopFragment { chain: u8[], start: u8[], end: u8[] }
struct ScopLink { kind: u8[], sunid: i64 }
struct ScopDomain { sid: u8[], pdb: u8[], residues: u8[], sccs: u8[], sunid: i64, hierarchy: ScopLink[], fragments: ScopFragment[] }
struct ScopNode { sunid: i64, kind: u8[], sccs: u8[], name: u8[], description: u8[], has_parent: bool, parent: i64, children: i64[] }
/*
Owns text, records, and fixed-element source-position indexes; do not mutate parsed
fields. Indexes contain positions, not builder pointers. Fixed indexes precede packed
variable records to avoid scanning prior records on field access. Caller-built graphs
must meet parser invariants.
*/
struct ScopGraph { error: u8[], id_order: i64[], sid_order: i64[], domain_at: i64[], keys: i64[], parents: i64[], offsets: i64[], edges: i64[], sid_bytes: u8[], sid_offsets: i64[], nodes: ScopNode[], domains: ScopDomain[] }
struct ScopFragments { items: ScopFragment[], error: u8[] }
struct ScopIDs { ids: i64[], error: u8[] }
fn scop_num(s: u8[:]) -> i64 { if s.len == 0 || s.len > 10 { return -1; } for c in s { if c < '0' || c > '9' { return -1; } } let n, ok = parse_int(s); return if ok { n } else { -1 }; }
fn scop_id(s: u8[:]) -> bool {
    if s.len == 0 || s.len > 5 { return false; }
    var i = 0; if s[0] == '-' { i = 1; } let first = i;
    while i < s.len && s[i] >= '0' && s[i] <= '9' { i += 1; }
    if i == first { return false; }
    return i == s.len || (i+1 == s.len && ((s[i] >= 'A' && s[i] <= 'Z') || (s[i] >= 'a' && s[i] <= 'z')));
}
/*
Accepts comma-separated chain ranges, optional parentheses, signed PDB residue numbers
and one insertion letter. Empty bounds extend to chain ends; - selects unnamed _. PDB ID
comes from CLA, never fragment text. Unbounded single IDs without a separator fail; text
caps at 65,536 bytes.
*/
fn scop_fragments(text: u8[:]) -> ScopFragments {
    var s = trim(text); if s.len > 65536 { return ScopFragments { [], "fragment limit" }; }
    if s.len >= 2 && s[0] == '(' && s[s.len-1] == ')' { s = s[1..s.len-1]; }
    var out: ScopFragment[>..] = [];
    if s == "-" || s.len == 0 { out.push(ScopFragment { "_", "", "" }); return ScopFragments { copy(out), "" }; }
    for part in split(s, ',') {
        var r = part; var chain: u8[>..] = []; chain.append("_");
        if r.len >= 2 && r[1] == ':' { chain.clear(); chain.append(r[..1]); r = r[2..]; }
        var a: u8[>..] = []; var b: u8[>..] = [];
        if r.len > 0 {
            var dash = -1; for c, i in r { if c == '-' && i > 0 && dash < 0 { dash = i; } }
            if dash < 0 { return ScopFragments { [], "expected residue range" }; }
            a.append(r[..dash]); b.append(r[dash+1..]);
            if (a.len > 0 && !scop_id(a)) || (b.len > 0 && !scop_id(b)) { return ScopFragments { [], "invalid PDB residue ID" }; }
        }
        out.push(ScopFragment { copy(chain), copy(a), copy(b) });
    }
    return ScopFragments { copy(out), "" };
}
// Indexes contain source-order positions, never owned graph copies.
fn scop_less(a: u8[:], b: u8[:]) -> bool {
    var i = 0; while i < a.len && i < b.len { if a[i] != b[i] { return a[i] < b[i]; } i += 1; } return a.len < b.len;
}
fn scop_sort(nr: ScopNode&[:], dr: const ScopDomain&[:], sid: bool) -> i64[] {
    let n = if sid { dr.len } else { nr.len };
    var order: i64[>..] = []; var temp: i64[>..] = [];
    var i = 0; while i < n { order.push(i); temp.push(0); i += 1; }
    var width = 1;
    while width < n {
        var start = 0;
        while start < n {
            let mid = min(start+width, n); let end = min(start+2*width, n);
            var l = start; var r = mid; var k = start;
            while k < end {
                var left = r >= end;
                if l < mid && r < end { left = if sid { scop_less(dr[order[l]].sid, dr[order[r]].sid) } else { nr[order[l]].sunid < nr[order[r]].sunid }; }
                if l >= mid { left = false; }
                if left { temp[k] = order[l]; l += 1; } else { temp[k] = order[r]; r += 1; } k += 1;
            }
            start = end;
        }
        i = 0; while i < n { order[i] = temp[i]; i += 1; } width *= 2;
    }
    return copy(order);
}
/*
Returns an index or -1, using O(log N) ID comparisons. Queries borrow const references
and expect a valid graph; traversal caps do not repeat validation.
*/
fn scop_node(g: const ScopGraph&, id: i64) -> i64 {
    var lo = 0; var hi = g.id_order.len;
    while lo < hi { let mid = lo+(hi-lo)/2; let i = g.id_order[mid]; if i < 0 || i >= g.keys.len { return -1; } let v = g.keys[i]; if v == id { return i; } if v < id { lo = mid+1; } else { hi = mid; } } return -1;
}
/*
Returns a domain index or -1 in O(log N) SID comparisons.
*/
fn scop_sid(g: const ScopGraph&, sid: u8[:]) -> i64 {
    var lo = 0; var hi = g.sid_order.len;
    while lo < hi { let mid = lo+(hi-lo)/2; let i = g.sid_order[mid]; if i < 0 || i+1 >= g.sid_offsets.len { return -1; } if g.sid_bytes[g.sid_offsets[i]..g.sid_offsets[i+1]] == sid { return i; } if scop_less(g.sid_bytes[g.sid_offsets[i]..g.sid_offsets[i+1]], sid) { lo = mid+1; } else { hi = mid; } } return -1;
}
fn scop_bad(s: u8[:]) -> ScopGraph { return ScopGraph { str(s), [], [], [], [], [], [], [], [], [], [], [] }; }
/*
Joins CLA/DES/HIE, adding DES root 0; HIE must supply root 0 with absent parent,
distinct from parent 0. Rejects duplicate IDs, missing links, cycles, contradictory
parents, and CLA paths differing from complete root- to-domain ancestry. Errors return
no partial graph.
*/
/* Caps: 64 MiB total input, 100,000 DES nodes plus root, CLA domains, edges, and depth; ten million
 * CLA path links. Buffers and owned output can exceed the input cap in memory. No database, SQL,
 * Astral, getAtoms, or coordinate mutation. */
/*
Merge-sorted position indexes, binary ID searches, reciprocal edges, and one root
traversal validate the tree. CLA ancestry uses precomputed parents; SID duplicates use
sorted bytes. Construction is O((N+E) log N + P), plus byte/text work; records rebuild
once, not per lookup/edge.
*/
fn parse_scop(cla: u8[:], des: u8[:], hie: u8[:]) -> ScopGraph {
    if cla.len+des.len+hie.len > 67108864 { return scop_bad("input limit"); }
    var nodes: ScopNode[>..] = [];
    for raw in split(des, '\n') {
        let s = trim(raw); if s.len == 0 || s[0] == '#' { continue; }
        let f = split(s, '\t'); if f.len != 5 || nodes.len >= 100000 { return scop_bad("DES fields or node limit"); }
        let id = scop_num(f[0]); if id <= 0 { return scop_bad("invalid DES id"); }
        nodes.push(ScopNode { id, str(f[1]), str(f[2]), if f[3] == "-" { "" } else { str(f[3]) }, str(f[4]), false, 0, [] });
    }
    nodes.push(ScopNode { 0, "ro", "", "", "root", false, 0, [] });
    var nr: ScopNode&[>..] = []; var keys: i64[>..] = [];
    for n in nodes { nr.push(n); keys.push(n.sunid); }
    let order = scop_sort(nr, [], false);
    let g = ScopGraph { "", copy(order), [], [], copy(keys), [], [], [], [], [], [], [] };
    var j = 1; while j < g.id_order.len { if nr[g.id_order[j-1]].sunid == nr[g.id_order[j]].sunid { return scop_bad("duplicate DES"); } j += 1; }
    var seen: bool[>..] = []; var child_seen: bool[>..] = []; var domain_at: i64[>..] = [];
    for n in nodes { seen.push(false); child_seen.push(false); domain_at.push(-1); }
    var edges = 0; var edge_data: i64[>..] = []; var starts: i64[>..] = []; var ends: i64[>..] = [];
    for n in nodes { starts.push(0); ends.push(0); }
    for raw in split(hie, '\n') {
        let s = trim(raw); if s.len == 0 || s[0] == '#' { continue; } let f = split(s, '\t');
        if f.len != 3 { return scop_bad("HIE fields"); } let id = scop_num(f[0]); let idx = scop_node(g, id);
        if idx < 0 { return scop_bad("dangling HIE"); } if seen[idx] { return scop_bad("duplicate HIE"); } seen[idx] = true;
        let parent = scop_num(f[1]); if f[1] != "-" && parent < 0 { return scop_bad("invalid parent"); }
        nr[idx].has_parent = f[1] != "-"; nr[idx].parent = parent;
        var children: i64[>..] = [];
        if f[2] != "-" { for c in split(f[2], ',') {
            let v = scop_num(c); if v < 0 { return scop_bad("invalid child"); }
            let ci = scop_node(g, v); if ci < 0 { return scop_bad("dangling child"); }
            if child_seen[ci] { return scop_bad("duplicate child or parent child contradiction"); }
            child_seen[ci] = true; children.push(v); edges += 1;
            if edges > 100000 { return scop_bad("edge limit"); }
        } }
        starts[idx] = edge_data.len; edge_data.append(children); ends[idx] = edge_data.len;
    }
    var joined: ScopNode[>..] = [];
    for n, i in nodes { var cs: i64[>..] = []; cs.append(edge_data[starts[i]..ends[i]]); joined.push(ScopNode { n.sunid, copy(n.kind), copy(n.sccs), copy(n.name), copy(n.description), n.has_parent, n.parent, copy(cs) }); }
    nr.clear(); for n in joined { nr.push(n); }

    for n, i in joined {
        if !seen[i] { return scop_bad("missing HIE"); }
        if (n.sunid == 0 && n.has_parent) || (n.sunid != 0 && !n.has_parent) { return scop_bad("root parent contradiction"); }
        if n.has_parent && scop_node(g, n.parent) < 0 { return scop_bad("dangling parent"); }
        if n.sunid != 0 && !child_seen[i] { return scop_bad("parent child contradiction"); }
        for c in n.children { let ci = scop_node(g, c); if !nr[ci].has_parent || nr[ci].parent != n.sunid { return scop_bad("child parent contradiction"); } }
    }
    // A unique incoming edge plus root reachability excludes cycles.
    var queue: i64[>..] = [scop_node(g, 0)]; var depths: i64[>..] = [];
    for n in nodes { depths.push(-1); } depths[queue[0]] = 0; var at = 0;
    while at < queue.len { let i = queue[at]; at += 1;
        for c in nr[i].children { let ci = scop_node(g, c); if depths[ci] >= 0 { return scop_bad("cycle"); } depths[ci] = depths[i]+1; if depths[ci] > 100000 { return scop_bad("depth limit"); } queue.push(ci); }
    }
    if queue.len != g.keys.len { return scop_bad("cycle"); }
    var parent_pos: i64[>..] = []; for n in joined { parent_pos.push(if n.has_parent { scop_node(g, n.parent) } else { -1 }); }
    var domains: ScopDomain[>..] = []; var work = 0;
    for raw in split(cla, '\n') {
        let s = trim(raw); if s.len == 0 || s[0] == '#' { continue; } let f = split(s, '\t');
        if f.len != 6 || domains.len >= 100000 { return scop_bad("CLA fields or limit"); }
        let id = scop_num(f[4]); let idx = scop_node(g, id);
        if idx < 0 { return scop_bad("CLA DES contradiction"); }
        if nr[idx].kind != "px" || nr[idx].name != f[0] || nr[idx].sccs != f[3] || f[1].len != 4 { return scop_bad("CLA DES contradiction"); }
        if domain_at[idx] >= 0 { return scop_bad("duplicate CLA"); } domain_at[idx] = domains.len;
        let fragments = scop_fragments(f[2]); if fragments.error.len > 0 { return scop_bad(fragments.error); }
        var links: ScopLink[>..] = []; var path: i64[>..] = []; var cur = idx;
        while cur >= 0 && nr[cur].sunid != 0 { path.push(cur); cur = parent_pos[cur]; }
        var k = path.len;
        for item in split(f[5], ',') {
            work += 1; if work > 10000000 { return scop_bad("CLA path work limit"); }
            let kv = split(item, '='); if kv.len != 2 { return scop_bad("CLA hierarchy"); }
            if k == 0 { return scop_bad("CLA ancestry length"); } k -= 1;
            let v = scop_num(kv[1]); let ni = path[k];
            if nr[ni].sunid != v || nr[ni].kind != kv[0] { return scop_bad("CLA ancestry order or hierarchy node"); }
            links.push(ScopLink { str(kv[0]), v });
        }
        if k != 0 { return scop_bad("CLA ancestry length"); }
        domains.push(ScopDomain { str(f[0]), str(f[1]), str(f[2]), str(f[3]), id, copy(links), copy(fragments.items) });
    }
    var dr: const ScopDomain&[>..] = []; var bytes: u8[>..] = []; var so: i64[>..] = [0];
    for d in domains { dr.push(d); bytes.append(d.sid); so.push(bytes.len); }
    let sid_order = scop_sort(nr, dr, true);
    j = 1; while j < sid_order.len { if dr[sid_order[j-1]].sid == dr[sid_order[j]].sid { return scop_bad("duplicate CLA"); } j += 1; }
    var parents: i64[>..] = []; var offsets: i64[>..] = [0]; var child_ids: i64[>..] = [];
    for n in joined { parents.push(if n.has_parent { scop_node(g, n.parent) } else { -1 }); for c in n.children { child_ids.push(scop_node(g, c)); } offsets.push(child_ids.len); }
    return ScopGraph { "", copy(g.id_order), copy(sid_order), copy(domain_at), copy(keys), copy(parents), copy(offsets), copy(child_ids), copy(bytes), copy(so), copy(joined), copy(domains) };
}
/*
Returns parent-to-root order using direct parent positions after initial lookup. At most
100,000 ancestors.
*/
fn scop_ancestors(g: const ScopGraph&, id: i64) -> ScopIDs {
    var out: i64[>..] = []; var cur = scop_node(g, id);
    if cur < 0 { return ScopIDs { [], "unknown id" }; }
    while true { if cur >= g.parents.len || out.len > 100000 { return ScopIDs { [], "traversal limit" }; } cur = g.parents[cur]; if cur < 0 { break; } if cur >= g.keys.len { return ScopIDs { [], "invalid parent index" }; } out.push(g.keys[cur]); }
    return ScopIDs { copy(out), "" };
}
/*
Uses breadth-first HIE child order and direct adjacency after initial lookup. Queue caps
at 100,001 nodes.
*/
fn scop_descendant_domains(g: const ScopGraph&, id: i64) -> ScopIDs {
    let first = scop_node(g, id); if first < 0 { return ScopIDs { [], "unknown id" }; }
    var queue: i64[>..] = [first]; var out: i64[>..] = []; var at = 0;
    while at < queue.len { let i = queue[at]; at += 1; if queue.len > 100001 || i < 0 || i >= g.domain_at.len || i+1 >= g.offsets.len { return ScopIDs { [], "traversal limit or invalid index" }; } if g.domain_at[i] >= 0 { out.push(g.keys[i]); } for k in g.offsets[i]..g.offsets[i+1] { queue.push(g.edges[k]); } }
    return ScopIDs { copy(out), "" };
}
/* Canonical cla/des/hie visits each record once, dropping comments/trailing whitespace and original
 * HIE placement; root emits last. Source attribution credits Gavin E. Crooks, Jeffrey Chang, and
 * Jeffrey Finkelstein; see docs/BIOPYTHON_LICENSE.rst. */
fn scop_write(g: const ScopGraph&, kind: u8[:]) -> u8[] {
    var out: u8[>..] = [];
    if kind == "cla" { for d in g.domains { out.append(d.sid); out.push('\t'); out.append(d.pdb); out.push('\t'); out.append(d.residues); out.push('\t'); out.append(d.sccs); out.push('\t'); out.append(str(d.sunid)); out.push('\t'); for l, i in d.hierarchy { if i > 0 { out.push(','); } out.append(l.kind); out.push('='); out.append(str(l.sunid)); } out.push('\n'); } }
    for n in g.nodes {
        if kind == "des" && n.sunid != 0 { out.append(str(n.sunid)); out.push('\t'); out.append(n.kind); out.push('\t'); out.append(n.sccs); out.push('\t'); out.append(if n.name.len == 0 { "-" } else { n.name }); out.push('\t'); out.append(n.description); out.push('\n'); }
        if kind == "hie" { out.append(str(n.sunid)); out.push('\t'); if n.has_parent { out.append(str(n.parent)); } else { out.push('-'); } out.push('\t'); if n.children.len == 0 { out.push('-'); } for c, i in n.children { if i > 0 { out.push(','); } out.append(str(c)); } out.push('\n'); }
    }
    return copy(out);
}

/*
Linear source-order lookup copies only one result. Prefer index/traversal queries for
repeated operations.
*/
fn scop_get(g: const ScopGraph&, index: i64) -> ScopNode { for n, i in g.nodes { if i == index { return copy(n); } } return ScopNode { -1, "", "", "", "", false, 0, [] }; }
