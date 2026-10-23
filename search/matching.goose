namespace bio;

// Overlapping byte matches; an empty pattern matches every boundary.
fn exact_search(text: const u8[:], pattern: const u8[:]) -> i64[>..] {
    var hits: i64[>..] = [];
    if pattern.len > text.len { return hits; }
    for i in text.len - pattern.len + 1 {
        var equal = true;
        for j in pattern.len { if text[i + j] != pattern[j] { equal = false; break; } }
        if equal { hits.push(i); }
    }
    return hits;
}
// Fixed-length windows with at most max_mismatches substitutions.
fn approximate_search(text: const u8[:], pattern: const u8[:], max_mismatches: i64) -> i64[>..] {
    assert(max_mismatches >= 0);
    var hits: i64[>..] = [];
    if pattern.len > text.len { return hits; }
    for i in text.len - pattern.len + 1 {
        var d: i64 = 0;
        for j in pattern.len { if text[i + j] != pattern[j] { d += 1; } }
        if d <= max_mismatches { hits.push(i); }
    }
    return hits;
}

// Insertion sorting suffixes is intended for small reference strings.
// Worst-case construction is O(n^3); no sentinel is required.
fn suffix_array(text: const u8[:]) -> i64[>..] {
    var sa: i64[>..] = [];
    for i in text.len {
        sa.push(i);
        var j = i;
        while j > 0 {
            var a = sa[j]; var b = sa[j - 1];
            while a < text.len && b < text.len && text[a] == text[b] { a += 1; b += 1; }
            let less = a == text.len || (b < text.len && text[a] < text[b]);
            if !less { break; }
            let tmp = sa[j]; sa[j] = sa[j - 1]; sa[j - 1] = tmp; j -= 1;
        }
    }
    return sa;
}
