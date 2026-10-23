namespace bio;

struct EditMatch { start: i64, end: i64, distance: i64, operations: u8[] }
// Unit-cost Levenshtein search, one best substring per end boundary.
// Equal-cost traceback prefers diagonal, deletion, then insertion.
// M/X consume both, D consumes pattern, I consumes text. Bytes literal.
// O(mn) time/space plus O(n(m+n)) worst-case traceback output.
// Empty pattern yields an empty match at every boundary.
// Does not enumerate tied starts; no transpositions or affine gaps.
fn approximate_matches(text: const u8[:], pattern: const u8[:], max_distance: i64) -> EditMatch[] {
    assert(max_distance >= 0);
    assert(text.len < 9223372036854775807 && pattern.len < 9223372036854775807);
    let width = text.len + 1;
    assert(pattern.len + 1 <= 9223372036854775807 / width);
    var scores: i64[>..] = [];
    for k in (pattern.len + 1) * width { scores.push(0); }
    for i in 1..pattern.len + 1 {
        scores[i * width] = i;
        for j in 1..width {
            var best = scores[(i - 1) * width + j - 1] + (if pattern[i - 1] == text[j - 1] { 0 } else { 1 });
            let deletion = scores[(i - 1) * width + j] + 1;
            let insertion = scores[i * width + j - 1] + 1;
            if deletion < best { best = deletion; }
            if insertion < best { best = insertion; }
            scores[i * width + j] = best;
        }
    }
    var matches: EditMatch[>..] = [];
    for end in width {
        let distance = scores[pattern.len * width + end];
        if distance > max_distance { continue; }
        var i = pattern.len; var j = end; var reverse: u8[>..] = [];
        while i > 0 {
            let score = scores[i * width + j];
            if j > 0 && score == scores[(i - 1) * width + j - 1] + (if pattern[i - 1] == text[j - 1] { 0 } else { 1 }) {
                reverse.push(if pattern[i - 1] == text[j - 1] { 'M' } else { 'X' }); i -= 1; j -= 1;
            } else if score == scores[(i - 1) * width + j] + 1 { reverse.push('D'); i -= 1; }
            else { assert(j > 0); reverse.push('I'); j -= 1; }
        }
        var operations: u8[>..] = [];
        for k in reverse.len { operations.push(reverse[reverse.len - 1 - k]); }
        matches.push(EditMatch { j, end, distance, copy(operations) });
    }
    return copy(matches);
}
