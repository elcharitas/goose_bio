import bio from "..";
import bio.search.pattern_algorithms;
import bio.search.qgram;
fn check_matchers(text: const u8[:], pattern: const u8[:]) {
    let expected = bio::exact_search(text, pattern);
    let distance = bio::edit_distance(text, pattern);
    for k in 0..5 {
        assert(bio::ukkonen_distance(text, pattern, k) == (if distance <= k { distance } else { -1 }));
    }
    let a = bio::kmp_search(text, pattern);
    let b = bio::horspool_search(text, pattern);
    let c = bio::shift_and_search(text, pattern);
    assert(a.len == expected.len && b.len == expected.len && c.len == expected.len);
    if pattern.len <= 64 {
        let d = bio::bndm_search(text, pattern); assert(d.len == expected.len);
        for v, i in expected { assert(d[i] == v); }
    }
    for v, i in expected { assert(a[i] == v && b[i] == v && c[i] == v); }
}
fn main() {
    for n in 7 { for m in 6 { for a in (1 << n) { for b in (1 << m) {
        var t: u8[>..] = []; var p: u8[>..] = [];
        for i in n { t.push(if ((a >> i) & 1) == 0 { 'A' } else { 'C' }); }
        for i in m { p.push(if ((b >> i) & 1) == 0 { 'A' } else { 'C' }); }
        check_matchers(t, p);
        for q in 1..4 {
            let index = bio::dna_qgram_index(t, q);
            let actual = bio::dna_qgram_search(index, p); let expected = bio::exact_search(t, p);
            assert(actual.len == expected.len);
            for v, i in expected { assert(actual[i] == v); }
        }
    } } } }
    var seed: i64 = 7919;
    for trial in 300 {
        var t: u8[>..] = []; var p: u8[>..] = [];
        for i in 180 { seed = seed * 48271 % 2147483647; t.push((seed % 256) as u8); }
        for i in trial % 100 { p.push(t[40 + i]); }
        check_matchers(t, p);
    }
    for m in [1, 63, 64, 65, 127, 128, 129, 300] {
        var t: u8[>..] = []; var p: u8[>..] = [];
        for i in 700 { t.push(255); }
        for i in m { p.push(255); }
        check_matchers(t, p); p[m - 1] = 0; check_matchers(t, p);
    }
    for q in [1, 2, 3, 10] {
        let t = "ACGTACGTACGTACGTTTTTACGT";
        let index = bio::dna_qgram_index(t, q);
        for start in t.len + 1 { for end in start..t.len + 1 {
            let p = t[start..end];
            let expected = bio::exact_search(t, p);
            let actual = bio::dna_qgram_search(index, p);
            assert(actual.len == expected.len);
            for v, i in expected { assert(actual[i] == v); }
        } }
    }
    print("pattern algorithms: passed");
}
