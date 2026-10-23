namespace bio;
import .intervals;

// Fenwick storage has n+1 cells, with zero in cell zero.
// Build O(n); in-place updates and prefix queries O(log n).
// Sum weights and max values must be nonnegative. Max only increases.
// Keep sum and maximum storage separate; additions check i64 overflow.
fn fenwick(length: i64) -> i64[] {
    assert(length >= 0 && length < 9223372036854775807);
    var nodes: i64[>..] = []; for i in length + 1 { nodes.push(0); }
    return copy(nodes);
}
fn fenwick_update(nodes: i64[:], position: i64, value: i64, maximum: bool = false) {
    assert(nodes.len > 0 && position >= 0 && position < nodes.len - 1 && value >= 0);
    var i = position + 1;
    // Validate every sum node before changing any node.
    if !maximum {
        while i < nodes.len {
            assert(nodes[i] <= 9223372036854775807 - value);
            let step = i & -i; if step > nodes.len - 1 - i { break; } i += step;
        }
    }
    i = position + 1;
    while i < nodes.len {
        if maximum { if value > nodes[i] { nodes[i] = value; } }
        else { nodes[i] += value; }
        let step = i & -i; if step > nodes.len - 1 - i { break; } i += step;
    }
}
// Prefix [0,end); max identity is zero for nonnegative values.
fn fenwick_query(nodes: const i64[:], end: i64, maximum: bool = false) -> i64 {
    assert(end >= 0 && end < nodes.len);
    var i = end; var result: i64 = 0;
    while i > 0 {
        if maximum { if nodes[i] > result { result = nodes[i]; } }
        else { assert(result <= 9223372036854775807 - nodes[i]); result += nodes[i]; }
        i -= i & -i;
    }
    return result;
}

// Balanced start-sorted implicit tree with subtree maximum ends.
// O(n log n) build, O(n) space; pruned query worst case O(n).
// IDs are original input positions; duplicates stay distinct.
struct IntervalTree { starts: i64[], ends: i64[], ids: i64[], maxima: i64[] }
recursive fn interval_tree_fill(ends: const i64[:], lo: i64, hi: i64, maxima: i64[:]) -> i64 {
    if lo == hi { return 0; }
    let mid = lo + (hi - lo) / 2;
    let left = interval_tree_fill(ends, lo, mid, maxima);
    let right = interval_tree_fill(ends, mid + 1, hi, maxima);
    var value = ends[mid]; if left > value { value = left; } if right > value { value = right; }
    maxima[mid] = value; return value;
}
fn interval_tree(intervals: const Interval[:]) -> IntervalTree {
    var ids: i64[>..] = []; var temp: i64[>..] = [];
    var starts: i64[>..] = []; var ends: i64[>..] = []; var maxima: i64[>..] = [];
    for a, i in intervals { assert(interval_valid(a)); ids.push(i); temp.push(0); }
    var raw_starts: i64[>..] = []; var raw_ends: i64[>..] = [];
    for a in intervals { raw_starts.push(a.start); raw_ends.push(a.end); }
    var width: i64 = 1;
    while width < ids.len {
        var lo: i64 = 0;
        while lo < ids.len {
            let mid = if width < ids.len - lo { lo + width } else { ids.len };
            let hi = if width < ids.len - mid { mid + width } else { ids.len };
            var a = lo; var b = mid; var out = lo;
            while a < mid || b < hi {
                if b == hi || (a < mid && raw_starts[ids[a]] <= raw_starts[ids[b]]) {
                    temp[out] = ids[a]; a += 1;
                } else { temp[out] = ids[b]; b += 1; }
                out += 1;
            }
            lo = hi;
        }
        for i in ids.len { ids[i] = temp[i]; }
        if width > ids.len / 2 { break; } width *= 2;
    }
    for id in ids { starts.push(raw_starts[id]); ends.push(raw_ends[id]); maxima.push(0); }
    interval_tree_fill(ends, 0, ids.len, maxima);
    return IntervalTree { copy(starts), copy(ends), copy(ids), copy(maxima) };
}
recursive fn interval_tree_visit(tree: const IntervalTree&, query: Interval, lo: i64, hi: i64, hits: i64[>..]&) {
    if lo == hi { return; }
    let mid = lo + (hi - lo) / 2;
    if tree.maxima[mid] <= query.start { return; }
    interval_tree_visit(tree, query, lo, mid, hits);
    if tree.starts[mid] >= query.end { return; }
    if tree.starts[mid] < tree.ends[mid] && tree.ends[mid] > query.start { hits.push(tree.ids[mid]); }
    interval_tree_visit(tree, query, mid + 1, hi, hits);
}
// Output is start-sorted; empty half-open queries have no hits.
fn interval_tree_query(tree: const IntervalTree&, query: Interval) -> i64[] {
    assert(interval_valid(query)); var hits: i64[>..] = [];
    if query.start < query.end { interval_tree_visit(tree, query, 0, tree.ids.len, hits); }
    return copy(hits);
}
