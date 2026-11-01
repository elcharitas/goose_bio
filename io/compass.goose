// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
struct CompassRecord { query: u8[], hit: u8[], gap_threshold: f64, query_length: i64, query_filtered_length: f64, hit_length: i64, hit_filtered_length: f64, query_nseqs: i64, query_neffseqs: f64, hit_nseqs: i64, hit_neffseqs: f64, sw_score: i64, evalue: f64, query_start: i64, hit_start: i64, query_aln: u8[], hit_aln: u8[], positives: u8[] }
struct CompassError { code: u8[], line: i64, message: u8[] }
struct CompassResult { records: CompassRecord[], error: CompassError }
fn compass_fail(code: u8[:], line: i64, message: u8[:]) -> CompassResult { return CompassResult { [], CompassError { str(code), line, str(message) } }; }
fn compass_space(c: u8) -> bool { return c == 32 || (c >= 9 && c <= 13) || (c >= 28 && c <= 31); }
fn compass_words(s: u8[:], all_space: bool = false) -> const u8[:][] {
    var out: const u8[:][>..] = []; var start = -1;
    for b, i in s { if b == ' ' || b == '\t' || (all_space && compass_space(b)) { if start >= 0 { out.push(s[start..i]); start = -1; } } else if start < 0 { start = i; } }
    if start >= 0 { out.push(s[start..]); } return copy(out);
}
/*
Integers must fit i64; fractional integer fields fail. Comparison records retain integer
lengths/counts/SW score, floating filtered/effective counts and Evalue, names,
threshold, starts, and alignment text.
*/
fn compass_integer(s: u8[:]) -> bool {
    if s.len == 0 { return false; } var i = 0;
    if s[0] == '-' || s[0] == '+' { i = 1; } if i == s.len { return false; }
    for b in s[i..] { if b < '0' || b > '9' { return false; } }
    let n, ok = parse_int(s); return ok;
}
/* Decimal/scientific conversion uses binary64 and need not be correctly rounded. Subnormals survive;
 * smaller values can underflow. NaN, infinity, overflow, and malformed exponents fail. */
fn compass_real(s: u8[:]) -> bool {
    var i = 0; if s.len == 0 { return false; }
    if s[0] == '+' || s[0] == '-' { i += 1; }
    var digits = 0;
    while i < s.len && s[i] >= '0' && s[i] <= '9' { digits += 1; i += 1; }
    if i < s.len && s[i] == '.' { i += 1; while i < s.len && s[i] >= '0' && s[i] <= '9' { digits += 1; i += 1; } }
    if digits == 0 { return false; }
    if i < s.len && (s[i] == 'e' || s[i] == 'E') { i += 1; if i < s.len && (s[i] == '+' || s[i] == '-') { i += 1; } let start = i; while i < s.len && s[i] >= '0' && s[i] <= '9' { i += 1; } if start == i { return false; } }
    if i != s.len { return false; }
    let n, ok = parse_flt(s); return ok && n >= -1.7976931348623157e308 && n <= 1.7976931348623157e308;
}
/*
Starts use the first digit run; numbered continuations overwrite earlier starts. Absent
starts are -1. Alignment bodies begin after exactly 15 bytes and retain positive spaces.
*/
fn compass_start(s: u8[:], previous: i64) -> i64 {
    var i = 0; while i < s.len { if s[i] >= '0' && s[i] <= '9' { let start = i; while i < s.len && s[i] >= '0' && s[i] <= '9' { i += 1; } let n, ok = parse_int(s[start..i]); if !ok { return -2; } return n; } i += 1; } return previous;
}
/* Missing score patterns retain score 0 and Evalue -1. Literal label spacing matters; tabs trigger
 * score 0 and Evalue -1 fallback values. */
fn compass_score_pattern(line: u8[:]) -> bool {
    let prefix = "Smith-Waterman score = ";
    if !starts_with(line, prefix) { return false; }
    var i = prefix.len; let start = i;
    while i < line.len && !compass_space(line[i]) { i += 1; }
    if i == start { return false; }
    while i < line.len && compass_space(line[i]) { i += 1; }
    let suffix = "Evalue = ";
    if !starts_with(line[i..], suffix) || line.len - i <= suffix.len { return false; }
    let capture = line[i + suffix.len];
    return !compass_space(capture);
}
/*
Counts every byte except =, rather than a coordinate span.
*/
fn compass_coverage(alignment: u8[:]) -> i64 { var n = 0; for b in alignment { if b != '=' { n += 1; } } return n; }
/*
Accepts zero or more COMPASS 1.24 comparisons. Errors are atomic with code, one-based
line, and message; count/input-limit errors use line zero. Requires ordered headers,
complete numeric tokens, triplets, one sequence token per line, and equal
query/positive/hit widths.
*/
/*
Blank separators and empty alignments are accepted. Limits: 64 MiB input, 10,000
records, one million columns/alignment. Whole-input lines/builders have no fixed memory
ceiling. Fixed-width prefixes require ASCII; CRLF normalizes even in positive text.
*/
fn parse_compass(text: u8[:]) -> CompassResult {
    if text.len > 67108864 { return compass_fail("limit", 0, "input exceeds 64 MiB"); }
    var lines: const u8[:][>..] = [];
    for raw in split(text, '\n') { var s: const u8[:] = raw; if s.len > 0 && s[s.len - 1] == '\r' { s = s[..s.len - 1]; } lines.push(s); }
    var records: CompassRecord[>..] = []; var p = 0;
    while p < lines.len {
        if trim(lines[p]).len == 0 { p += 1; continue; }
        if records.len >= 10000 { return compass_fail("limit", p + 1, "record limit"); }
        if lines.len - p < 5 { return compass_fail("header", p + 1, "truncated header"); }
        var query: u8[>..] = []; var hit: u8[>..] = []; var gap_threshold: f64 = 0; var query_length: i64 = 0; var query_filtered_length: f64 = 0; var hit_length: i64 = 0; var hit_filtered_length: f64 = 0; var query_nseqs: i64 = 0; var query_neffseqs: f64 = 0; var hit_nseqs: i64 = 0; var hit_neffseqs: f64 = 0; var sw_score: i64 = 0; var evalue: f64 = -1; var query_start: i64 = -1; var hit_start: i64 = -1; var query_aln: u8[>..] = []; var hit_aln: u8[>..] = []; var positives: u8[>..] = [];
        let names = compass_words(lines[p]);
        if names.len != 4 { return compass_fail("header", p + 1, "expected Ali1 and Ali2"); }
        if names[0] != "Ali1:" || names[2] != "Ali2:" { return compass_fail("header", p + 1, "expected Ali1 and Ali2"); }
        query.clear(); query.append(names[1]); hit.clear(); hit.append(names[3]);
        let threshold = "Threshold of effective gap content in columns: ";
        if !starts_with(lines[p + 1], threshold) { return compass_fail("header", p + 2, "expected threshold"); }
        let value = trim(lines[p + 1][threshold.len..]);
        if !compass_real(value) { return compass_fail("numeric", p + 2, "invalid threshold"); }
        let t, _ = parse_flt(value); gap_threshold = t;
        let row2 = compass_words(lines[p + 2]); if row2.len != 4 { return compass_fail("header", p + 3, "expected four profile fields"); }
        if !starts_with(row2[0], "length1=") { return compass_fail("header", p + 3, "invalid profile label"); }
        let v20 = row2[0][8..]; if !compass_integer(v20) { return compass_fail("numeric", p + 3, "invalid profile number"); } let n20, _ = parse_int(v20); query_length = n20;
        if !starts_with(row2[1], "filtered_length1=") { return compass_fail("header", p + 3, "invalid profile label"); }
        let v21 = row2[1][17..]; if !compass_real(v21) { return compass_fail("numeric", p + 3, "invalid profile number"); } let n21, _ = parse_flt(v21); query_filtered_length = n21;
        if !starts_with(row2[2], "length2=") { return compass_fail("header", p + 3, "invalid profile label"); }
        let v22 = row2[2][8..]; if !compass_integer(v22) { return compass_fail("numeric", p + 3, "invalid profile number"); } let n22, _ = parse_int(v22); hit_length = n22;
        if !starts_with(row2[3], "filtered_length2=") { return compass_fail("header", p + 3, "invalid profile label"); }
        let v23 = row2[3][17..]; if !compass_real(v23) { return compass_fail("numeric", p + 3, "invalid profile number"); } let n23, _ = parse_flt(v23); hit_filtered_length = n23;
        let row3 = compass_words(lines[p + 3]); if row3.len != 4 { return compass_fail("header", p + 4, "expected four profile fields"); }
        if !starts_with(row3[0], "Nseqs1=") { return compass_fail("header", p + 4, "invalid profile label"); }
        let v30 = row3[0][7..]; if !compass_integer(v30) { return compass_fail("numeric", p + 4, "invalid profile number"); } let n30, _ = parse_int(v30); query_nseqs = n30;
        if !starts_with(row3[1], "Neff1=") { return compass_fail("header", p + 4, "invalid profile label"); }
        let v31 = row3[1][6..]; if !compass_real(v31) { return compass_fail("numeric", p + 4, "invalid profile number"); } let n31, _ = parse_flt(v31); query_neffseqs = n31;
        if !starts_with(row3[2], "Nseqs2=") { return compass_fail("header", p + 4, "invalid profile label"); }
        let v32 = row3[2][7..]; if !compass_integer(v32) { return compass_fail("numeric", p + 4, "invalid profile number"); } let n32, _ = parse_int(v32); hit_nseqs = n32;
        if !starts_with(row3[3], "Neff2=") { return compass_fail("header", p + 4, "invalid profile label"); }
        let v33 = row3[3][6..]; if !compass_real(v33) { return compass_fail("numeric", p + 4, "invalid profile number"); } let n33, _ = parse_flt(v33); hit_neffseqs = n33;
        let score = compass_words(lines[p + 4], true);
        let pattern = compass_score_pattern(lines[p + 4]);
        if !starts_with(lines[p + 4], "Smith-Waterman") { return compass_fail("header", p + 5, "expected score line"); }
        if pattern && score.len > 7 && score[0] == "Smith-Waterman" && score[1] == "score" && score[2] == "=" && score[4] == "Evalue" && score[5] == "=" { return compass_fail("header", p + 5, "extra score token"); }
        if pattern && score.len == 7 && score[0] == "Smith-Waterman" && score[1] == "score" && score[2] == "=" && score[4] == "Evalue" && score[5] == "=" {
            if !compass_integer(score[3]) || !compass_real(score[6]) { return compass_fail("numeric", p + 5, "invalid score or Evalue"); }
            let sw, _ = parse_int(score[3]); let ev, _ = parse_flt(score[6]); sw_score = sw; evalue = ev;
        }
        p += 5;
        while p < lines.len {
            if trim(lines[p]).len == 0 { p += 1; continue; }
            if starts_with(lines[p], "Ali1:") { break; }
            if lines.len - p < 3 { return compass_fail("alignment", p + 1, "truncated triplet"); }
            let q = lines[p]; let pos = lines[p + 1]; let h = lines[p + 2];
            if q.len <= 15 || pos.len <= 15 || h.len <= 15 { return compass_fail("alignment", p + 1, "short alignment prefix or body"); }
            let qw = compass_words(q[15..]); let hw = compass_words(h[15..]);
            if qw.len != 1 || hw.len != 1 || q[15] <= 32 || h[15] <= 32 || qw[0].len != hw[0].len || qw[0].len != pos.len - 15 { return compass_fail("alignment", p + 1, "unequal or malformed triplet"); }
            if query_aln.len > 1000000 - qw[0].len { return compass_fail("limit", p + 1, "alignment column limit"); }
            query_start = compass_start(q, query_start); hit_start = compass_start(h, hit_start);
            if query_start == -2 || hit_start == -2 { return compass_fail("numeric", p + 1, "start overflow"); }
            query_aln.append(qw[0]);
            hit_aln.append(hw[0]);
            positives.append(pos[15..]);
            p += 3;
        }
        records.push(CompassRecord { copy(query), copy(hit), gap_threshold, query_length, query_filtered_length, hit_length, hit_filtered_length, query_nseqs, query_neffseqs, hit_nseqs, hit_neffseqs, sw_score, evalue, query_start, hit_start, copy(query_aln), copy(hit_aln), copy(positives) });
    }
    return CompassResult { copy(records), CompassError { "", 0, "" } };
}
/* Requires exactly one record. No executable, profile construction, writer, undocumented-version
 * support. Bio.Compass 1.88 source attribution: James Casbon (2004), Biopython/BSD; see
 * docs/BIOPYTHON_LICENSE.rst. */
fn read_compass(text: u8[:]) -> CompassResult {
    let result = parse_compass(text); if result.error.code.len > 0 { return result; }
    if result.records.len != 1 { return compass_fail("count", 0, "expected exactly one record"); } return result;
}
