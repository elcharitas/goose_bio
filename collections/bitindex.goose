namespace bio;

// Packed bits with prefix counts: O(n) build, O(1) rank, O(log n) select.
// Prefix counts cost O(n) words; this is not a succinct representation.
struct BitIndex { words: u64[], prefix: i64[], length: i64 }
fn bit_index(bits: const u8[:]) -> BitIndex {
    assert(bits.len < 9223372036854775807);
    var words: u64[>..] = []; var prefix: i64[>..] = [0];
    var count: i64      = 0;
    for b, i in bits {
        assert(b <= 1);
        if i % 64 == 0 { words.push(0); }
        if b == 1 { words[i / 64] |= (1 as u64) << (i % 64); count += 1; }
        prefix.push(count);
    }
    return BitIndex { copy(words), copy(prefix), bits.len };
}
fn bit_access(index: const BitIndex&, position: i64) -> u8 {
    assert(position >= 0 && position < index.length);
    return ((index.words[position / 64] >> (position % 64)) & 1) as u8;
}
fn bit_rank(index: const BitIndex&, bit: u8, end: i64) -> i64 {
    assert(bit <= 1 && end >= 0 && end <= index.length);
    return if bit == 1 { index.prefix[end] } else { end - index.prefix[end] };
}
// Select uses zero-based occurrence numbers; missing occurrences return -1.
fn bit_select(index: const BitIndex&, bit: u8, occurrence: i64) -> i64 {
    assert(bit <= 1 && occurrence >= 0);
    if occurrence >= bit_rank(index, bit, index.length) { return -1; }
    var lo: i64 = 0; var hi = index.length;
    while lo < hi {
        let mid = lo + (hi - lo) / 2;
        if bit_rank(index, bit, mid + 1) > occurrence { hi = mid; }
        else { lo = mid + 1; }
    }
    return lo;
}

// Byte wavelet matrix: eight stable partitions, O(8n) build/storage.
// Access, rank and half-open value range counts take O(8) time.
struct WaveletMatrix { levels: BitIndex[], zeros: i64[], length: i64 }
fn wavelet_matrix(values: const u8[:]) -> WaveletMatrix {
    var current: u8[>..]       = []; for v in values { current.push(v); }
    var levels:  BitIndex[>..] = []; var zeros: i64[>..] = [];
    for level in 8 {
        var bits: u8[>..] = []; var next: u8[>..] = []; var zero: i64 = 0;
        for v in current { let b = (v >> (7 - level)) & 1; bits.push(b); if b == 0 { zero += 1; } }
        for v in current { if ((v >> (7 - level)) & 1) == 0 { next.push(v); } }
        for v in current { if ((v >> (7 - level)) & 1) == 1 { next.push(v); } }
        levels.push(bit_index(bits)); zeros.push(zero); current = copy(next);
    }
    return WaveletMatrix { copy(levels), copy(zeros), values.len };
}
fn wavelet_access(matrix: const WaveletMatrix&, position: i64) -> u8 {
    assert(position >= 0 && position < matrix.length);
    var p = position; var value: u8 = 0;
    for index, level in matrix.levels {
        let b = bit_access(index, p); value = (value << 1) | b;
        p = bit_rank(index, b, p) + (if b == 1 { matrix.zeros[level] } else { 0 });
    }
    return value;
}
fn wavelet_less(matrix: const WaveletMatrix&, start: i64, end: i64, value: i64) -> i64 {
    assert(start >= 0 && start <= end && end <= matrix.length && value >= 0 && value <= 256);
    if value == 256 { return end - start; }
    var lo = start; var hi = end; var count: i64 = 0;
    for index, level in matrix.levels {
        let a = bit_rank(index, 0, lo); let b = bit_rank(index, 0, hi);
        if ((value >> (7 - level)) & 1) == 1 {
            count += b - a; lo = matrix.zeros[level] + lo - a; hi = matrix.zeros[level] + hi - b;
        } else { lo = a; hi = b; }
    }
    return count;
}
fn wavelet_range_count(matrix: const WaveletMatrix&, start: i64, end: i64, lower: i64, upper: i64) -> i64 {
    assert(lower >= 0 && lower <= upper && upper <= 256);
    return wavelet_less(matrix, start, end, upper) - wavelet_less(matrix, start, end, lower);
}
fn wavelet_rank(matrix: const WaveletMatrix&, value: u8, end: i64) -> i64 {
    let symbol: i64 = value;
    return wavelet_range_count(matrix, 0, end, symbol, symbol + 1);
}

// Width 1..64; packed words can straddle element boundaries.
struct PackedIntegers { words: u64[], width: i64, length: i64 }
fn packed_integers(values: const u64[:], width: i64) -> PackedIntegers {
    assert(width >= 1 && width <= 64);
    assert(values.len <= (9223372036854775807 - 63) / width);
    var words: u64[>..] = [];
    for i in (values.len * width + 63) / 64 { words.push(0); }
    for v, i in values {
        if width < 64 { assert((v >> width) == 0); }
        let offset = i * width; let shift = offset % 64;
        words[offset / 64] |= v << shift;
        if shift + width > 64 { words[offset / 64 + 1] |= v >> (64 - shift); }
    }
    return PackedIntegers { copy(words), width, values.len };
}
fn packed_get(packed: const PackedIntegers&, position: i64) -> u64 {
    assert(position >= 0 && position < packed.length);
    let offset = position * packed.width; let shift = offset % 64;
    var value = packed.words[offset / 64] >> shift;
    if shift + packed.width > 64 { value |= packed.words[offset / 64 + 1] << (64 - shift); }
    if packed.width < 64 { value &= ((1 as u64) << packed.width) - 1; }
    return value;
}
