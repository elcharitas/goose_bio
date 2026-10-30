import bio from "..";
import bio.search.fmindex;

import bio.search.myers_bom;
import bio.search.compact_fm;
fn check_myers(t: const u8[:], p: const u8[:]) {
    let expected = bio::exact_search(t, p);
    let oracle = bio::backward_oracle_search(t, p);
    assert(expected.len == oracle.len);
    for v, i in expected { assert(v == oracle[i]); }
    let actual = bio::myers_end_distances(t, p);
    assert(actual.error.len == 0 && actual.distances.len == t.len + 1);
    var row: i64[>..] = [];
    for j in p.len + 1 { row.push(j); }
    assert(actual.distances[0] == p.len);
    for c, i in t {
        var diagonal = row[0]; row[0] = 0;
        for j in 1..p.len + 1 {
            let old = row[j];
            var best = diagonal + (if c == p[j - 1] { 0 } else { 1 });
            if old + 1 < best { best = old + 1; }
            if row[j - 1] + 1 < best { best = row[j - 1] + 1; }
            row[j] = best; diagonal = old;
        }
        assert(actual.distances[i + 1] == row[p.len]);
    }
}
fn check_index(t: const u8[:]) {
    for stride in [1, 2, 7, 128] { for sample in [1, 2, 5, 200] {
        let full = bio::fm_index(t, stride);
        let compact = bio::compact_fm_index(t, stride, sample);
        assert(compact.sample_rows.len == t.len / sample + 1);
        for row in full.sa.len { assert(bio::compact_fm_row(compact, row) == full.sa[row]); }
        for a in t.len + 1 { for b in a..t.len + 1 {
            let p = t[a..b];
            let x = bio::fm_locate(full, p); let y = bio::compact_fm_locate(compact, p);
            assert(x.positions.len == y.positions.len);
            for v, i in x.positions { assert(v == y.positions[i]); }
        } }
    } }
    let bi = bio::reverse_bifm(t, 3, 2);
    for c in [1, 65, 255] {
        let initial = bio::bifm_empty(bi);
        let l = bio::bifm_extend_left(bi, initial, c as u8);
        let r = bio::bifm_extend_right(bi, initial, c as u8);
        var p: u8[>..] = []; p.push(c as u8);
        let f = bio::compact_fm_search(bi.forward, p);
        assert(l.size == f.end - f.start && r.size == l.size);
        if l.size > 0 { assert(l.forward == f.start && r.forward == f.start); }
    }
    for a in t.len + 1 { for b in a..t.len + 1 {
        var right = bio::bifm_empty(bi); var left = right;
        var reverse: u8[>..] = [];
        for i in b - a {
            right = bio::bifm_extend_right(bi, right, t[a + i]);
            left = bio::bifm_extend_left(bi, left, t[b - i - 1]);
            reverse.push(t[b - i - 1]);
        }
        var mixed = bio::bifm_empty(bi);
        let mid = (a + b) / 2;
        for i in b - mid { mixed = bio::bifm_extend_right(bi, mixed, t[mid + i]); }
        for i in mid - a { mixed = bio::bifm_extend_left(bi, mixed, t[mid - i - 1]); }
        let f = bio::compact_fm_search(bi.forward, t[a..b]);
        assert(mixed.forward == f.start && mixed.size == f.end - f.start);
        let r = bio::compact_fm_search(bi.reverse, reverse);
        assert(right.forward == f.start && right.size == f.end - f.start);
        assert(left.forward == f.start && left.size == f.end - f.start);
        assert(right.reverse == r.start && left.reverse == r.start);
    } }
}
fn main() {
    for n in 7 { for m in 6 { for a in (1 << n) { for b in (1 << m) {
        var t: u8[>..] = []; var p: u8[>..] = [];
        for i in n { t.push(((a >> i) & 1) as u8); }
        for i in m { p.push(((b >> i) & 1) as u8); }
        check_myers(t, p);
    } } } }
    var seed: i64 = 7919;
    for trial in 100 {
        var t: u8[>..] = []; var p: u8[>..] = [];
        for i in 180 { seed = seed * 48271 % 2147483647; t.push((seed % 256) as u8); }
        for i in trial % 65 { p.push(t[40 + i]); }
        check_myers(t, p);
    }
    for m in [0, 1, 63, 64] {
        var t: u8[>..] = []; var p: u8[>..] = [];
        for i in 256 { t.push(i as u8); }
        for i in m { p.push(255); }
        check_myers(t, p);
    }
    var too_long: u8[>..] = []; for i in 65 { too_long.push(1); }
    assert(bio::myers_end_distances("", too_long).error.len > 0);
    assert(bio::compact_fm_index("a\0b").error.len > 0);
    assert(bio::compact_fm_index("", 0).error.len > 0);
    assert(bio::compact_fm_index("", 1, 0).error.len > 0);
    for t in ["", "a", "banana", "AAAAAAA", "ACGTACGT", "\x01\xff\x01"] { check_index(t); }
    print("compact patterns: passed");
}
