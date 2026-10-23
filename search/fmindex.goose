namespace bio;

struct FMIndex {
    bwt: u8[], sa: i64[], cumulative: i64[], checkpoints: i64[],
    stride: i64, length: i64, error: u8[]
}
struct FMRange { start: i64, end: i64, error: u8[] }
struct FMLocations { positions: i64[], error: u8[] }

fn fm_pair_less(a: i64, b: i64, ranks: const i64[:], k: i64) -> bool {
    if ranks[a] != ranks[b] { return ranks[a] < ranks[b]; }
    let ar = if a + k < ranks.len { ranks[a + k] } else { -1 };
    let br = if b + k < ranks.len { ranks[b + k] } else { -1 };
    return ar < br;
}
// Merge-sorted prefix doubling: O(n log^2 n) time, O(n) workspace.
fn fm_suffix_array(text: const u8[:]) -> i64[] {
    var sa: i64[>..] = []; var ranks: i64[>..] = [];
    var tmp: i64[>..] = []; var next: i64[>..] = [];
    for c, i in text { sa.push(i); ranks.push(c); tmp.push(0); next.push(0); }
    var k: i64 = 1;
    while k < text.len {
        var width: i64 = 1;
        while width < text.len {
            var left: i64 = 0;
            while left < text.len {
                let mid = if left + width < text.len { left + width } else { text.len };
                let end = if mid + width < text.len { mid + width } else { text.len };
                var a = left; var b = mid; var out = left;
                while a < mid || b < end {
                    if b == end || (a < mid && fm_pair_less(sa[a], sa[b], ranks, k)) {
                        tmp[out] = sa[a]; a += 1;
                    } else { tmp[out] = sa[b]; b += 1; }
                    out += 1;
                }
                left = end;
            }
            for i in text.len { sa[i] = tmp[i]; }
            width *= 2;
        }
        var rank: i64 = 0; next[sa[0]] = 0;
        for i in 1..text.len {
            if fm_pair_less(sa[i - 1], sa[i], ranks, k) { rank += 1; }
            next[sa[i]] = rank;
        }
        for i in text.len { ranks[i] = next[i]; }
        if rank == text.len - 1 { break; }
        k *= 2;
    }
    return copy(sa);
}
// Byte zero is reserved; all other bytes are matched literally.
fn fm_index(text: const u8[:], checkpoint_stride: i64 = 128) -> FMIndex {
    if checkpoint_stride <= 0 { return FMIndex { [], [], [], [], 0, 0, "stride must be positive" }; }
    for c in text { if c == 0 { return FMIndex { [], [], [], [], 0, 0, "reserved sentinel" }; } }
    var terminated: u8[>..] = [];
    for c in text { terminated.push(c); } terminated.push(0);
    let sa = fm_suffix_array(terminated);
    var bwt: u8[>..] = []; var counts: i64[>..] = [];
    var cumulative: i64[>..] = []; var checkpoints: i64[>..] = [];
    for i in 256 { counts.push(0); cumulative.push(0); }
    for pos in sa { bwt.push(terminated[if pos == 0 { text.len } else { pos - 1 }]); }
    for i in bwt.len + 1 {
        if i % checkpoint_stride == 0 { for count in counts { checkpoints.push(count); } }
        if i < bwt.len { counts[bwt[i] as i64] += 1; }
    }
    var total: i64 = 0;
    for i in 256 { cumulative[i] = total; total += counts[i]; }
    return FMIndex { copy(bwt), copy(sa), copy(cumulative), copy(checkpoints), checkpoint_stride, text.len, "" };
}
// Rank counts occurrences in the half-open BWT prefix [0, end).
fn fm_rank(index: const FMIndex&, symbol: u8, end: i64) -> i64 {
    assert(index.error.len == 0 && end >= 0 && end <= index.bwt.len);
    let checkpoint = end / index.stride;
    var count = index.checkpoints[checkpoint * 256 + symbol];
    for i in checkpoint * index.stride..end { if index.bwt[i] == symbol { count += 1; } }
    return count;
}
fn fm_backward_search(index: const FMIndex&, pattern: const u8[:]) -> FMRange {
    if index.error.len > 0 { return FMRange { 0, 0, copy(index.error) }; }
    for c in pattern { if c == 0 { return FMRange { 0, 0, "reserved sentinel" }; } }
    var lo: i64 = 0; var hi = index.bwt.len;
    for j in pattern.len {
        let c = pattern[pattern.len - j - 1];
        lo = index.cumulative[c as i64] + fm_rank(index, c, lo);
        hi = index.cumulative[c as i64] + fm_rank(index, c, hi);
        if lo == hi { break; }
    }
    return FMRange { lo, hi, "" };
}
// Positions are in suffix-array order; empty patterns include n.
fn fm_locate(index: const FMIndex&, pattern: const u8[:]) -> FMLocations {
    let range = fm_backward_search(index, pattern);
    if range.error.len > 0 { return FMLocations { [], copy(range.error) }; }
    var positions: i64[>..] = [];
    for i in range.start..range.end { positions.push(index.sa[i]); }
    return FMLocations { copy(positions), "" };
}
