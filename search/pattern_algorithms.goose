namespace bio;

// All exact matchers return overlapping zero-based byte starts.

/* Exact byte matchers return ascending overlapping starts; empty patterns match all n+1 boundaries,
 * including NUL and 255. KMP uses a prefix failure function: O(m+n) time and O(m) work memory. Each
 * call prepares its pattern; returned copies add O(hits) storage. No reusable matchers, streaming
 * state, SIMD, or two-way matching. */
fn kmp_search(text: const u8[:], pattern: const u8[:]) -> i64[] {
    var hits: i64[>..] = [];
    if pattern.len == 0 { for i in text.len + 1 { hits.push(i); } return copy(hits); }
    var prefix: i64[>..] = [];
    for i in pattern.len { prefix.push(0); }
    var j: i64 = 0;
    for i in 1..pattern.len {
        while j > 0 && pattern[i] != pattern[j] { j = prefix[j - 1]; }
        if pattern[i] == pattern[j] { j += 1; }
        prefix[i] = j;
    }
    j = 0;
    for c, i in text {
        while j > 0 && c != pattern[j] { j = prefix[j - 1]; }
        if c == pattern[j] { j += 1; }
        if j == pattern.len { hits.push(i + 1 - j); j = prefix[j - 1]; }
    }
    return copy(hits);
}

/* Scans backward using a 256-entry bad-character table: O(m+256) preparation, O(nm) worst-case search,
 * O(256) workspace. Byte and empty-pattern rules match KMP. */
fn horspool_search(text: const u8[:], pattern: const u8[:]) -> i64[] {
    var hits: i64[>..] = [];
    if pattern.len == 0 { for i in text.len + 1 { hits.push(i); } return copy(hits); }
    if pattern.len > text.len { return copy(hits); }
    var shifts: i64[>..] = [];
    for i in 256 { shifts.push(pattern.len); }
    for i in pattern.len - 1 { shifts[pattern[i]] = pattern.len - 1 - i; }
    var start: i64 = 0;
    while start <= text.len - pattern.len {
        var j = pattern.len;
        while j > 0 && pattern[j - 1] == text[start + j - 1] { j -= 1; }
        if j == 0 { hits.push(start); }
        let step = shifts[text[start + pattern.len - 1]];
        if step > text.len - pattern.len - start { break; }
        start += step;
    }
    return copy(hits);
}
// Multiword Shift-And propagates carries before masking each word.

/* Uses 256 masks per 64-bit word with inter-word carries: O(m+256w+nw) time, O(256w) workspace,
 * w=ceil(m/64). Patterns accept at most 1,048,576 bytes across all word boundaries. Byte and
 * empty-pattern rules match KMP. */
fn shift_and_search(text: const u8[:], pattern: const u8[:]) -> i64[] {
    var hits: i64[>..] = [];
    if pattern.len == 0 { for i in text.len + 1 { hits.push(i); } return copy(hits); }
    assert(pattern.len <= 1048576);
    let words = (pattern.len + 63) / 64;
    var masks: u64[>..] = []; var state: u64[>..] = [];
    for i in 256 * words { masks.push(0); }
    for i in words { state.push(0); }
    for c, i in pattern { masks[c * words + i / 64] |= (1 as u64) << (i % 64); }
    for c, i in text {
        var carry: u64 = 1;
        for w in words {
            let next = state[w] >> 63;
            state[w] = ((state[w] << 1) | carry) & masks[c * words + w];
            carry = next;
        }
        if (state[(pattern.len - 1) / 64] & ((1 as u64) << ((pattern.len - 1) % 64))) != 0 {
            hits.push(i + 1 - pattern.len);
        }
    }
    return copy(hits);
}

// Backward nondeterministic DAWG matching, one word, 1..64 bytes.

/* Reversed masks and backward automaton transitions use safe shifts: O(m+256+nm) worst-case time,
 * O(256) workspace. Patterns above 64 bytes assert; empty patterns match all boundaries. All bytes are
 * literal. No average-case or benchmark speed guarantee. */
fn bndm_search(text: const u8[:], pattern: const u8[:]) -> i64[] {
    assert(pattern.len <= 64);
    var hits: i64[>..] = [];
    if pattern.len == 0 { for i in text.len + 1 { hits.push(i); } return copy(hits); }
    if pattern.len > text.len { return copy(hits); }
    var masks: u64[>..] = [];
    for i in 256 { masks.push(0); }
    for c, i in pattern { masks[c] |= (1 as u64) << (pattern.len - 1 - i); }
    var start: i64 = 0;
    while start <= text.len - pattern.len {
        var j = pattern.len; var last = pattern.len;
        var state: u64 = 18446744073709551615;
        while j > 0 && state != 0 {
            state &= masks[text[start + j - 1]]; j -= 1;
            if state != 0 {
                if j == 0 { hits.push(start); } else { last = j; }
            }
            state <<= 1;
        }
        if last > text.len - pattern.len - start { break; }
        start += last;
    }
    return copy(hits);
}

// Ukkonen diagonal band for global unit-cost Levenshtein distance.
// Return -1 above k; this does not search substrings or emit a trace.

/* Global unit-cost Levenshtein distance returns -1 above nonnegative k; equal bytes cost zero. Inputs
 * accept at most 1,048,576 bytes; k caps at m+n. Only the diagonal band is evaluated:
 * O(n+m*min(n+1,2k+1)) time and O(n) workspace, m=a.len, n=b.len. Length differences above k return
 * immediately. No traceback or substring positions. approximate_matches remains separate full-grid DP
 * with its best-per-end M/X/D/I trace and diagonal/deletion/insertion ties; banded substring traceback
 * is unsupported. */
fn ukkonen_distance(a: const u8[:], b: const u8[:], k: i64) -> i64 {
    assert(k >= 0 && a.len <= 1048576 && b.len <= 1048576);
    let limit = if k < a.len + b.len { k } else { a.len + b.len };
    if a.len - b.len > limit || b.len - a.len > limit { return -1; }
    let infinity = limit + 1;
    let width = b.len + 1;
    var rows: i64[>..] = [];
    for j in width { rows.push(if j <= limit { j } else { infinity }); }
    for j in width { rows.push(infinity); }
    for i in 1..a.len + 1 {
        let previous = ((i - 1) % 2) * width;
        let current = (i % 2) * width;
        let low = if i > limit { i - limit } else { 0 };
        let high = if i + limit < b.len { i + limit } else { b.len };
        if low > 0 { rows[current + low - 1] = infinity; }
        if high < b.len { rows[current + high + 1] = infinity; }
        for j in low..high + 1 {
            if j == 0 { rows[current + j] = i; continue; }
            var best = rows[previous + j - 1] + (if a[i - 1] == b[j - 1] { 0 } else { 1 });
            if rows[previous + j] + 1 < best { best = rows[previous + j] + 1; }
            if rows[current + j - 1] + 1 < best { best = rows[current + j - 1] + 1; }
            rows[current + j] = if best > infinity { infinity } else { best };
        }
    }
    let result = rows[(a.len % 2) * width + b.len];
    return if result <= limit { result } else { -1 };
}
