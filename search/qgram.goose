namespace bio;

/* Owns text, dense offsets, and stable position buckets. Keep fields as immutable constructor output.
 * Literal equality has no IUPAC matching, reverse complements, spaced seeds, approximate filtering, or
 * configurable alphabet. */
struct DnaQgramIndex { text: u8[], q: i64, offsets: i64[], positions: i64[] }
fn dna_qgram_base(c: u8) -> i64 {
    if c == 'A' { return 0; } if c == 'C' { return 1; }
    if c == 'G' { return 2; } if c == 'T' { return 3; }
    return -1;
}
fn dna_qgram_code(text: const u8[:]) -> i64 {
    var code: i64 = 0;
    for c in text { let b = dna_qgram_base(c); assert(b >= 0); code = code * 4 + b; }
    return code;
}
// Uppercase A/C/G/T only; q in 1..10 bounds the dense directory.

/* Uppercase A/C/G/T only; other bytes assert. q is 1..10, with 4^q <= 1,048,576 buckets. There is no
 * mismatch k parameter. Construction takes O(nq+4^q) time and O(n+4^q) memory. */
fn dna_qgram_index(text: const u8[:], q: i64) -> DnaQgramIndex {
    assert(q >= 1 && q <= 10);
    for c in text { assert(dna_qgram_base(c) >= 0); }
    let dimension = (1 as i64) << (2 * q);
    var offsets: i64[>..] = [];
    for i in dimension + 1 { offsets.push(0); }
    let count = if text.len >= q { text.len - q + 1 } else { 0 };
    for i in count { offsets[dna_qgram_code(text[i..i + q]) + 1] += 1; }
    for i in 1..dimension + 1 { offsets[i] += offsets[i - 1]; }
    var cursors = copy(offsets); var positions: i64[>..] = [];
    for i in count { positions.push(0); }
    for i in count {
        let code = dna_qgram_code(text[i..i + q]);
        positions[cursors[code]] = i; cursors[code] += 1;
    }
    var owned: u8[>..] = []; for c in text { owned.push(c); }
    return DnaQgramIndex { copy(owned), q, copy(offsets), copy(positions) };
}
// Prefix bucket candidates receive complete literal verification.

/* Validates the same alphabet, selects the prefix q-gram bucket, and verifies complete candidates.
 * Positions are sorted. Cost is O(m+q+cm) for c candidates plus output; patterns shorter than q use
 * O(nm) scanning. Empty patterns match every boundary. */
fn dna_qgram_search(index: const DnaQgramIndex&, pattern: const u8[:]) -> i64[] {
    for c in pattern { assert(dna_qgram_base(c) >= 0); }
    var hits: i64[>..] = [];
    if pattern.len > index.text.len { return copy(hits); }
    if pattern.len < index.q {
        for i in index.text.len - pattern.len + 1 {
            var equal = true;
            for j in pattern.len { if index.text[i + j] != pattern[j] { equal = false; break; } }
            if equal { hits.push(i); }
        }
    } else {
        let code = dna_qgram_code(pattern[0..index.q]);
        for k in index.offsets[code]..index.offsets[code + 1] {
            let i = index.positions[k];
            if i > index.text.len - pattern.len { continue; }
            var equal = true;
            for j in pattern.len { if index.text[i + j] != pattern[j] { equal = false; break; } }
            if equal { hits.push(i); }
        }
    }
    return copy(hits);
}
