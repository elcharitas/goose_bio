import bio from "..";
import bio.collections.bitindex;
fn main() {
    for n in 9 { for mask in (1 << n) {
        var bits: u8[>..] = []; for i in n { bits.push(((mask >> i) & 1) as u8); }
        let index = bio::bit_index(bits);
        for b in 2 {
            var count: i64 = 0;
            for end in n + 1 {
                assert(bio::bit_rank(index, b as u8, end) == count);
                if end < n {
                    assert(bio::bit_access(index, end) == bits[end]);
                    if bits[end] == b { assert(bio::bit_select(index, b as u8, count) == end); count += 1; }
                }
            }
            assert(bio::bit_select(index, b as u8, count) == -1);
        }
    } }
    for n in 3 { for encoded in (1 << (n * 2)) {
        var values: u8[>..] = [];
        for i in n { values.push(((encoded >> (2 * i)) & 3) as u8); }
        let matrix = bio::wavelet_matrix(values);
        for start in n + 1 { for end in start..n + 1 {
            for lower in 5 { for upper in lower..5 {
                var count: i64 = 0;
                for i in start..end { if values[i] >= lower && values[i] < upper { count += 1; } }
                assert(bio::wavelet_range_count(matrix, start, end, lower, upper) == count);
            } }
        } }
    } }
    var long_bits: u8[>..] = [];
    for i in 193 { long_bits.push((i % 2) as u8); }
    let long_index = bio::bit_index(long_bits);
    for i in 193 {
        assert(bio::bit_access(long_index, i) == i % 2);
        assert(bio::bit_select(long_index, (i % 2) as u8, i / 2) == i);
    }
    let full = bio::packed_integers([18446744073709551615 as u64, 0], 64);
    assert(bio::packed_get(full, 0) == 18446744073709551615);
    assert(bio::packed_get(full, 1) == 0);
    var seed: i64 = 731;
    for n in 70 {
        var values: u8[>..] = [];
        for i in n { seed = (seed * 48271) % 2147483647; values.push((seed % 256) as u8); }
        let matrix = bio::wavelet_matrix(values);
        for v, i in values { assert(bio::wavelet_access(matrix, i) == v); }
        for lo in n + 1 { for hi in lo..n + 1 {
            var count: i64 = 0; for i in lo..hi { if values[i] >= 50 && values[i] < 201 { count += 1; } }
            assert(bio::wavelet_range_count(matrix, lo, hi, 50, 201) == count);
            assert(bio::wavelet_range_count(matrix, lo, hi, 0, 256) == hi - lo);
        } }
        for v in 256 {
            var count: i64 = 0; for end in n + 1 {
                assert(bio::wavelet_rank(matrix, v as u8, end) == count);
                if end < n && values[end] == v { count += 1; }
            }
        }
    }
    for width in 1..65 {
        var values: u64[>..] = [];
        for i in 140 {
            var v = (i as u64) * 123456789012345;
            if width < 64 { v &= ((1 as u64) << width) - 1; }
            values.push(v);
        }
        let packed = bio::packed_integers(values, width);
        for v, i in values { assert(bio::packed_get(packed, i) == v); }
        assert(bio::packed_integers([], width).words.len == 0);
    }
    print("bitindex: passed");
}
