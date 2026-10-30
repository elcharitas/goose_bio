import bio from "..";
import bio.search.approximate;
fn main() {
    for n in 6 { for m in 5 { for a in (1 << n) { for b in (1 << m) {
        var text: u8[>..] = []; var pattern: u8[>..] = [];
        for i in n { text.push(if ((a >> i) & 1) == 0 { 'A' } else { 'C' }); }
        for i in m { pattern.push(if ((b >> i) & 1) == 0 { 'A' } else { 'C' }); }
        let matches = bio::approximate_matches(text, pattern, m);
        assert(matches.len == n + 1);
        for hit, end in matches {
            var best = m;
            for start in end + 1 {
                let distance = bio::edit_distance(pattern, text[start..end]);
                if distance < best { best = distance; }
            }
            assert(hit.end == end && hit.distance == best);
            assert(hit.start >= 0 && hit.start <= hit.end);
            assert(bio::edit_distance(pattern, text[hit.start..end]) == best);
            var pi: i64 = 0; var ti = hit.start; var cost: i64 = 0;
            for op in hit.operations {
                if op == 'M' || op == 'X' {
                    assert(pi < m && ti < end);
                    assert((op == 'M') == (pattern[pi] == text[ti]));
                    pi += 1; ti += 1;
                } else if op == 'D' { pi += 1; } else { assert(op == 'I'); ti += 1; }
                if op != 'M' { cost += 1; }
            }
            assert(pi == m && ti == end && cost == best);
        }
        for threshold in m + 1 {
            let filtered = bio::approximate_matches(text, pattern, threshold);
            var count: i64 = 0; for hit in matches { if hit.distance <= threshold { count += 1; } }
            assert(filtered.len == count);
            for hit in filtered { assert(hit.distance <= threshold); }
        }
    } } } }
    var seed: i64 = 971;
    for trial in 100 {
        var text: u8[>..] = []; var pattern: u8[>..] = [];
        for i in 15 { seed = seed * 48271 % 2147483647; text.push((seed % 256) as u8); }
        for i in trial % 10 { seed = seed * 48271 % 2147483647; pattern.push((seed % 256) as u8); }
        let matches = bio::approximate_matches(text, pattern, pattern.len);
        assert(matches.len == text.len + 1);
        for hit in matches {
            var best = pattern.len;
            for start in hit.end + 1 {
                let distance = bio::edit_distance(pattern, text[start..hit.end]);
                if distance < best { best = distance; }
            }
            assert(hit.distance == best);
            assert(bio::edit_distance(pattern, text[hit.start..hit.end]) == best);
        }
    }
    print("approximate: passed");
}
