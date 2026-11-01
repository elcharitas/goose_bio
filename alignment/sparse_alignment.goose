namespace bio;
import std;

/* Positive-length matching fragments use coordinates and ends within one billion. Caller-provided
 * fragments are trusted to match. */
struct SparseAnchor { a: i64, b: i64, length: i64 }

/* An exact increasing, nonoverlapping seed-chain objective, without mismatch/gap interpolation or DP
 * traceback. Overlapping seeds cannot extend the score: k=2 on identical length-three strings scores
 * two, not three. */
struct SparseChain { anchors: SparseAnchor[], score: i64, error: u8[] }

/* Sorts and maximizes total fragment length. Ties retain the first candidate. Accepts at most 4,096
 * anchors; sorting and chaining use O(A²) time and O(A) extra space. */
fn sparse_chain(anchors: const SparseAnchor[:]) -> SparseChain {
    let bad = SparseChain { [], 0, "invalid anchor or resource bound" };
    if anchors.len > 4096 { return bad; }
    var sorted: SparseAnchor[>..] = [];
    for a in anchors {
        if a.a < 0 || a.b < 0 || a.length <= 0 || a.a > 1000000000 - a.length || a.b > 1000000000 - a.length { return bad; }
        sorted.push(a);
    }
    for i in sorted.len { for j in i + 1..sorted.len {
        if sorted[j].a < sorted[i].a || (sorted[j].a == sorted[i].a && sorted[j].b < sorted[i].b) {
            let t = sorted[i]; sorted[i] = sorted[j]; sorted[j] = t;
        }
    } }
    var d: i64[>..] = []; var prev: i64[>..] = []; var end: i64 = -1; var best: i64 = 0;
    for a, i in sorted {
        d.push(a.length); prev.push(-1);
        for j in i { let p = sorted[j];
            if p.a + p.length <= a.a && p.b + p.length <= a.b && d[j] + a.length > d[i] {
                d[i] = d[j] + a.length; prev[i] = j;
            }
        }
        if d[i] > best { best = d[i]; end = i; }
    }
    var rev:    SparseAnchor[>..] = []; while end >= 0 { rev.push(sorted[end]); end = prev[end]; }
    var result: SparseAnchor[>..] = []; for k in rev.len { result.push(rev[rev.len - 1 - k]); }
    return SparseChain { result, best, "" };
}

/* Generates every exact length-k pair, then chains. Sequence lengths cap at 4,096 bytes; defaults
 * are 64 occurrences per seed and 4096 total anchors. Exceeding either cap errors, without silently
 * truncating repetitive seeds. Generation is O(|a||b|k) plus chaining, with bounded
 * anchor/occurrence storage. No seed index, banded alignment, or SIMD. */
fn sparse_kmer_chain(a: const u8[:], b: const u8[:], k: i64,
    max_occurrences: i64 = 64, max_anchors: i64 = 4096) -> SparseChain {
    let bad = SparseChain { [], 0, "invalid seed bounds or seed cap exceeded" };
    if k <= 0 || a.len > 4096 || b.len > 4096 || max_occurrences <= 0
        || max_occurrences > 4096 || max_anchors <= 0 || max_anchors > 4096 { return bad; }
    var anchors: SparseAnchor[>..] = [];
    if k > a.len || k > b.len { return SparseChain { [], 0, "" }; }
    for i in 0..a.len - k + 1 {
        var matches: i64[>..] = [];
        for j in 0..b.len - k + 1 {
            var equal = true; for t in k { if a[i + t] != b[j + t] { equal = false; } }
            if equal { matches.push(j); if matches.len > max_occurrences { return bad; } }
        }
        for j in matches {
            if anchors.len == max_anchors { return bad; }
            anchors.push(SparseAnchor { i, j, k });
        }
    }
    return sparse_chain(anchors);
}
