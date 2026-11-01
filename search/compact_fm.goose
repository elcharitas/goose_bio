namespace bio;

/* For terminated length N and strides r,s: stores N BWT bytes, 256 cumulative i64s, 256*(floor(N/r)+1)
 * checkpoint i64s, and 2*(floor((N-1)/s)+1) sample i64s, plus array overhead. This is dense byte
 * checkpoint storage, not succinct rank. */
struct CompactFMIndex {
    bwt:           u8[], sample_rows: i64[], sample_values: i64[],
    cumulative:    i64[], checkpoints: i64[], stride: i64,
    sample_stride: i64, length: i64, error: u8[],
}
// Byte zero is reserved; all other bytes are matched literally.

/* Reserves zero as the unique final sentinel; both strides must be positive. Prefix doubling
 * temporarily stores the full SA and O(N) workspace, taking O(N log-squared N) time. No
 * wavelet/suffix tree, persistence, or compressed construction. */
fn compact_fm_index(text: const u8[:], checkpoint_stride: i64 = 128, sample_stride: i64 = 32) -> CompactFMIndex {
    if checkpoint_stride <= 0 || sample_stride <= 0 { return CompactFMIndex { [], [], [], [], [], 0, 0, 0, "stride must be positive" }; }
    for c in text { if c == 0 { return CompactFMIndex { [], [], [], [], [], 0, 0, 0, "reserved sentinel" }; } }
    var terminated: u8[>..] = [];
    for c in text { terminated.push(c); } terminated.push(0);
    let sa = fm_suffix_array(terminated);
    var bwt:        u8[>..]  = []; var counts: i64[>..] = [];
    var cumulative: i64[>..] = []; var checkpoints: i64[>..] = [];
    for i in 256 { counts.push(0); cumulative.push(0); }
    for pos in sa { bwt.push(terminated[if pos == 0 { text.len } else { pos - 1 }]); }
    for i in bwt.len + 1 {
        if i % checkpoint_stride == 0 { for count in counts { checkpoints.push(count); } }
        if i < bwt.len { counts[bwt[i] as i64] += 1; }
    }
    var total: i64 = 0;
    for i in 256 { cumulative[i] = total; total += counts[i]; }
    var rows: i64[>..] = []; var values: i64[>..] = [];
    for pos, row in sa {
        if pos % sample_stride == 0 { rows.push(row); values.push(pos); }
    }
    return CompactFMIndex { copy(bwt), copy(rows), copy(values), copy(cumulative), copy(checkpoints), checkpoint_stride, sample_stride, text.len, "" };
}
// Rank counts occurrences in the half-open BWT prefix [0, end).

/* Scans at most r-1 bytes per rank. Search costs O(mr).
 */
fn compact_fm_rank(index: const CompactFMIndex&, symbol: u8, end: i64) -> i64 {
    assert(index.error.len == 0 && end >= 0 && end <= index.bwt.len);
    let checkpoint = end / index.stride;
    var count = index.checkpoints[checkpoint * 256 + symbol];
    for i in checkpoint * index.stride..end { if index.bwt[i] == symbol { count += 1; } }
    return count;
}
fn compact_fm_search(index: const CompactFMIndex&, pattern: const u8[:]) -> FMRange {
    if index.error.len > 0 { return FMRange { 0, 0, copy(index.error) }; }
    for c in pattern { if c == 0 { return FMRange { 0, 0, "reserved sentinel" }; } }
    var lo: i64 = 0; var hi = index.bwt.len;
    for j in pattern.len {
        let c = pattern[pattern.len - j - 1];
        lo = index.cumulative[c as i64] + compact_fm_rank(index, c, lo);
        hi = index.cumulative[c as i64] + compact_fm_rank(index, c, hi);
        if lo == hi { break; }
    }
    return FMRange { lo, hi, "" };
}

/* Samples rows with suffix values divisible by s. LF walking reaches one in at most min(s-1,n) steps,
 * each using binary search among sampled rows and checkpoint rank. */
fn compact_fm_row(index: const CompactFMIndex&, row: i64) -> i64 {
    assert(index.error.len == 0 && row >= 0 && row < index.bwt.len);
    var current = row; var steps: i64 = 0;
    while steps < index.bwt.len {
        var lo: i64 = 0; var hi = index.sample_rows.len;
        while lo < hi {
            let mid = (lo + hi) / 2;
            if index.sample_rows[mid] < current { lo = mid + 1; }
            else { hi = mid; }
        }
        if lo < index.sample_rows.len && index.sample_rows[lo] == current {
            return (index.sample_values[lo] + steps) % index.bwt.len;
        }
        let c = index.bwt[current];
        current = index.cumulative[c as i64] + compact_fm_rank(index, c, current);
        steps += 1;
    }
    assert(false); return -1;
}

/* Returns SA order without retaining a full SA; empty patterns include the final boundary. Locating k
 * hits costs O(mr+k*min(s,N)*(r+log(1+N/s))). */
fn compact_fm_locate(index: const CompactFMIndex&, pattern: const u8[:]) -> FMLocations {
    let range = compact_fm_search(index, pattern);
    if range.error.len > 0 { return FMLocations { [], copy(range.error) }; }
    var positions: i64[>..] = [];
    for row in range.start..range.end { positions.push(compact_fm_row(index, row)); }
    return FMLocations { copy(positions), "" };
}

/* Indexes text and reversal in two independent compact indexes. Generic reverse-text BiFM is separate
 * from DNA FMD. Keep public index fields unmodified. */
struct ReverseBiFM { forward: CompactFMIndex, reverse: CompactFMIndex }

/* State holds forward/reverse intervals and common size. States must come from the same index; zero
 * symbols and invalid invented states are outside the extension contract. */
struct BiFMInterval { forward: i64, reverse: i64, size: i64 }
fn reverse_bifm(text: const u8[:], rank_stride: i64 = 128, sample_stride: i64 = 32) -> ReverseBiFM {
    var reversed: u8[>..] = [];
    for i in text.len { reversed.push(text[text.len - 1 - i]); }
    return ReverseBiFM { compact_fm_index(text, rank_stride, sample_stride), compact_fm_index(reversed, rank_stride, sample_stride) };
}
fn bifm_empty(index: const ReverseBiFM&) -> BiFMInterval {
    assert(index.forward.error.len == 0 && index.reverse.error.len == 0);
    return BiFMInterval { 0, 0, index.forward.bwt.len };
}
// Intervals must originate from this index and its extension functions.

/* Uses rank counts and ordered smaller-symbol counts, including sentinel, without rebuilding patterns
 * or fresh backward searches. At most 512 ranks per extension gives O(256r) time. */
fn bifm_extend_left(index: const ReverseBiFM&, state: BiFMInterval, c: u8) -> BiFMInterval {
    assert(c != 0 && index.forward.error.len == 0);
    let lo = compact_fm_rank(index.forward, c, state.forward);
    let hi = compact_fm_rank(index.forward, c, state.forward + state.size);
    var offset: i64 = 0;
    for symbol in c as i64 {
        offset += compact_fm_rank(index.forward, symbol as u8, state.forward + state.size) - compact_fm_rank(index.forward, symbol as u8, state.forward);
    }
    return BiFMInterval { index.forward.cumulative[c as i64] + lo, state.reverse + offset, hi - lo };
}

/* Right extension uses the same rank-based state contract as left extension.
 */
fn bifm_extend_right(index: const ReverseBiFM&, state: BiFMInterval, c: u8) -> BiFMInterval {
    assert(c != 0 && index.reverse.error.len == 0);
    let lo = compact_fm_rank(index.reverse, c, state.reverse);
    let hi = compact_fm_rank(index.reverse, c, state.reverse + state.size);
    var offset: i64 = 0;
    for symbol in c as i64 {
        offset += compact_fm_rank(index.reverse, symbol as u8, state.reverse + state.size) - compact_fm_rank(index.reverse, symbol as u8, state.reverse);
    }
    return BiFMInterval { state.forward + offset, index.reverse.cumulative[c as i64] + lo, hi - lo };
}
