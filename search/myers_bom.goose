namespace bio;

/* Distances include boundary zero. Text prefixes are free: each distance is the minimum to a substring
 * ending there. Empty patterns give zero at every boundary; patterns above 64 bytes return an error.
 * All 256 bytes are literal symbols. */
struct MyersEnds { distances: i64[], error: u8[] }
// Semi-global distance at every end boundary, including zero.

/* Unsigned 64-bit Myers vectors use O(text length+256+pattern length) time and 256 words of workspace,
 * excluding the returned O(text length) array. No multiword Myers or traceback. */
fn myers_end_distances(text: const u8[:], pattern: const u8[:]) -> MyersEnds {
    if pattern.len > 64 { return MyersEnds { [], "pattern exceeds 64 bytes" }; }
    var result: i64[>..] = []; result.push(pattern.len);
    if pattern.len == 0 {
        for c in text { result.push(0); }
        return MyersEnds { copy(result), "" };
    }
    var masks: u64[>..] = [];
    for i in 256 { masks.push(0); }
    for c, i in pattern { masks[c] |= (1 as u64) << i; }
    var positive: u64 = 18446744073709551615;
    var negative: u64 = 0;
    var score = pattern.len;
    let high = (1 as u64) << (pattern.len - 1);
    for c in text {
        let eq = masks[c];
        let vertical = eq | negative;
        let horizontal = (((eq & positive) + positive) ^ positive) | eq;
        var plus = negative | ~(horizontal | positive);
        var minus = positive & horizontal;
        if (plus & high) != 0 { score += 1; }
        if (minus & high) != 0 { score -= 1; }
        plus <<= 1; minus <<= 1;
        positive = minus | ~(vertical | plus);
        negative = plus & vertical;
        result.push(score);
    }
    return MyersEnds { copy(result), "" };
}

// Backward factor oracle; exact verification rejects oracle false paths.

/* Builds a factor oracle on the reversed pattern, scans windows backward, and verifies surviving
 * paths exactly. Empty patterns match all boundaries; all bytes are accepted. Advances one window at
 * a time, without optimized BOM shifts. Construction takes O(256m) time/space; search is O(nm) worst
 * case. */
fn backward_oracle_search(text: const u8[:], pattern: const u8[:]) -> i64[] {
    var hits: i64[>..] = [];
    if pattern.len == 0 {
        for i in text.len + 1 { hits.push(i); } return copy(hits);
    }
    if pattern.len > text.len { return copy(hits); }
    var transitions: i64[>..] = []; var supply: i64[>..] = [];
    for i in (pattern.len + 1) * 256 { transitions.push(-1); }
    supply.push(-1);
    for i in 1..pattern.len + 1 {
        let c = pattern[pattern.len - i];
        transitions[(i - 1) * 256 + c] = i;
        var k = supply[i - 1];
        while k >= 0 && transitions[k * 256 + c] == -1 {
            transitions[k * 256 + c] = i; k = supply[k];
        }
        supply.push(if k == -1 { 0 } else { transitions[k * 256 + c] });
    }
    for start in text.len - pattern.len + 1 {
        var state: i64 = 0; var j = pattern.len;
        while j > 0 && state >= 0 {
            j -= 1; state = transitions[state * 256 + text[start + j]];
        }
        if state >= 0 {
            var equal = true;
            for i in pattern.len {
                if text[start + i] != pattern[i] { equal = false; break; }
            }
            if equal { hits.push(start); }
        }
    }
    return copy(hits);
}
