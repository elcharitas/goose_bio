// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import math;
struct XpkRow { raw: u8[], fields: u8[][] }
struct Xpk { headers: u8[][], labels: u8[][], rows: XpkRow[] }
struct XpkResult { peaklist: Xpk, error: u8[] }
struct XpkGroup { residue: i64, rows: i64[] }
struct XpkGroups { groups: XpkGroup[], minimum: i64, maximum: i64, error: u8[] }
struct XpkText { text: u8[], error: u8[] }
struct XpkPrediction { found: bool, row: XpkRow, error: u8[] }
fn xpk_words(s: u8[:]) -> u8[][] {
    var out: u8[][>..] = []; var start = -1;
    for c,i in s { if c == ' ' || c == '\t' || c == '\r' { if start >= 0 { out.push(str(s[start..i])); start = -1; } } else if start < 0 { start = i; } }
    if start >= 0 { out.push(str(s[start..])); } return copy(out);
}
fn xpk_field(fields: u8[][]&, at: i64) -> u8[] { for f,i in fields { if i == at { return copy(f); } } return ""; }
fn xpk_row(p: Xpk&, at: i64) -> XpkRow { for r,i in p.rows { if i == at { return copy(r); } } return XpkRow { "",[] }; }
/*
Entry number is column zero; unknown extra fields retain their original text.
*/
fn xpk_column(p: Xpk&, label: u8[:]) -> i64 { for l,i in p.labels { if l == label { return i+1; } } return -1; }
fn xpk_label(n: u8[:], suffix: u8[:]) -> u8[] { var s: u8[>..] = []; s.append(n); s.append(suffix); return copy(s); }
fn xpk_residue(s: u8[:]) -> i64,bool {
    let parts = split(s,'.'); if parts.len < 2 || parts[1].len == 0 { return 0,false; }
    let t = parts[0]; var start = 0; if t.len > 0 && (t[0] == '-' || t[0] == '+') { start = 1; }
    if t.len == start { return 0,false; }
    for c in t[start..] { if c < '0' || c > '9' { return 0,false; } }
    for c in s { if c == '{' || c == '}' || c == ',' || c == ';' { return 0,false; } }
    return parse_int(t);
}
fn xpk_number(text: u8[:]) -> f64, bool {
    if text.len == 0 || text.len > 768 { return 0.0, false; }
    var p = 0; if text[p] == '+' || text[p] == '-' { p += 1; }
    var digits = 0;
    while p < text.len && text[p] >= '0' && text[p] <= '9' { digits += 1; p += 1; }
    if p < text.len && text[p] == '.' { p += 1; while p < text.len && text[p] >= '0' && text[p] <= '9' { digits += 1; p += 1; } }
    if digits == 0 { return 0.0, false; }
    if p < text.len && (text[p] == 'e' || text[p] == 'E') {
        p += 1; if p < text.len && (text[p] == '+' || text[p] == '-') { p += 1; }
        var exponent_digits = 0;
        while p < text.len && text[p] >= '0' && text[p] <= '9' { exponent_digits += 1; p += 1; }
        if exponent_digits == 0 { return 0.0, false; }
    }
    if p != text.len { return 0.0, false; }
    let x,ok = parse_flt(text); return x, ok && !is_nan(x) && !is_inf(x);
}
fn xpk_fail(s: u8[:]) -> XpkResult { return XpkResult { Xpk { [],[],[] },str(s) }; }
/*
Retains six ordered headers (firstline, axislabels, dataset, sw, sf, datalabels),
labels, entry strings, raw rows, and extra fields. .P values are finite ppm shifts, not
sequence coordinates. Matching .L/.P pairs are required; residue prefixes before the
first dot are signed integers.
*/
/* Rejects duplicate labels, wrong widths, missing assignment columns, invalid numbers, and grouped
 * assignments. Caps: 64 MiB, 100,000 rows, 256 labels. Whole-input parsing/grouping and repeated
 * lookups may be quadratic. No compressed files, spectral processing or distance inference. */
fn parse_xpk(text: u8[:]) -> XpkResult {
    if text.len > 67108864 { return xpk_fail("XPK byte limit"); }
    let lines = split(text,'\n'); if lines.len < 6 { return xpk_fail("six header lines required"); }
    var headers: u8[][>..] = []; for i in 0..6 { headers.push(str(lines[i])); }
    let labels = xpk_words(lines[5]); if labels.len == 0 || labels.len > 256 { return xpk_fail("label limit"); }
    var assignments = 0;
    for l,i in labels { for old,j in labels { if j < i && l == old { return xpk_fail("duplicate label"); } }
        if l.len > 2 && l[l.len-2..] == ".L" { assignments += 1; var found = false; let want = xpk_label(l[..l.len-2],".P"); for other in labels { if other == want { found = true; } } if !found { return xpk_fail("missing ppm label"); } }
        if l.len > 2 && l[l.len-2..] == ".P" { var found = false; let want = xpk_label(l[..l.len-2],".L"); for other in labels { if other == want { found = true; } } if !found { return xpk_fail("missing assignment label"); } }
    }
    if assignments == 0 { return xpk_fail("missing assignment labels"); }
    var rows: XpkRow[>..] = [];
    for i in 6..lines.len { let raw = lines[i]; if i == lines.len-1 && raw.len == 0 { continue; }
        if rows.len >= 100000 { return xpk_fail("row limit"); } let fields = xpk_words(raw);
        if fields.len != labels.len+1 { return xpk_fail("wrong row width"); }
        for l,j in labels { if l.len > 2 && l[l.len-2..] == ".L" { let r,ok = xpk_residue(xpk_field(fields,j+1)); if !ok { return xpk_fail("invalid or grouped assignment"); } }
            if l.len > 2 && l[l.len-2..] == ".P" { let v,ok = xpk_number(xpk_field(fields,j+1)); if !ok { return xpk_fail("invalid finite ppm"); } }
        }
        rows.push(XpkRow { str(raw),copy(fields) });
    } return XpkResult { Xpk { copy(headers),copy(labels),copy(rows) },"" };
}
/*
Groups retain first-seen and input-row order. Empty bounds are -1/-1; nonempty signed
extrema initialize separately, including actual residue -1. Empty spectra do not extend
nonempty ranges.
*/
fn xpk_group(p: Xpk&, nucleus: u8[:]) -> XpkGroups {
    let col = xpk_column(p,xpk_label(nucleus,".L")); if col < 0 { return XpkGroups { [],-1,-1,"missing nucleus" }; }
    var groups: XpkGroup[>..] = []; var lo = -1; var hi = -1;
    for row,i in p.rows { let r,ok = xpk_residue(xpk_field(row.fields,col)); if !ok { return XpkGroups { [],-1,-1,"invalid residue" }; }
        if i == 0 || r < lo { lo = r; } if i == 0 || r > hi { hi = r; }
        var at = -1; for g,j in groups { if g.residue == r { at = j; } }
        if at < 0 { groups.push(XpkGroup { r,[i] }); } else { var ids: i64[>..] = []; for g,j in groups { if j == at { ids.append(g.rows); } } ids.push(i); var rebuilt: XpkGroup[>..] = []; for g,j in groups { if j == at { rebuilt.push(XpkGroup { g.residue,copy(ids) }); } else { rebuilt.push(copy(g)); } } groups.clear(); groups.append(rebuilt); }
    } return XpkGroups { copy(groups),lo,hi,"" };
}
/* Emits raw headers/rows, normalizing terminators to one LF while retaining trailing spaces and CR
 * bytes. Rebuild rows after field edits; structs must be parser-valid. Unchanged numeric strings are
 * not reformatted. Bio.NMR source attribution: Bob Bussell (2004), Biopython license. */
fn write_xpk(p: Xpk&) -> u8[] { var s: u8[>..] = []; for h in p.headers { s.append(h); s.push('\n'); } for r in p.rows { s.append(r.raw); s.push('\n'); } return copy(s); }
/*
Emits the inclusive global nonempty range, using the first row per residue/spectrum.
Missing cells are *; zero keeps its numeric spelling; all- empty input emits no rows.
Span/cell bounds are positive and at most one million, with at most 256 spectra.
*/
/*
A conservative million-work cap includes squared row counts and span times accumulated
work before grouping. Sparse requests can reject even when cells would fit.
*/
fn xpk_table(ps: Xpk[:], label: u8[:], nucleus: u8[:], max_span: i64, max_cells: i64) -> XpkText {
    if ps.len == 0 || ps.len > 256 || max_span < 1 || max_span > 1000000 || max_cells < 1 || max_cells > 1000000 { return XpkText { "","table bounds" }; }
    var gs: XpkGroups[>..] = []; var cols: i64[>..] = []; var lo = 0; var hi = 0; var any = false; var work = 0;
    for p in ps { work += p.rows.len*p.rows.len; if work > 1000000 { return XpkText { "","table work limit" }; } let col = xpk_column(p,label); let g = xpk_group(p,nucleus); if col < 0 || g.error.len > 0 { return XpkText { "","missing table labels" }; }

        if p.rows.len > 0 { if !any || g.minimum < lo { lo = g.minimum; } if !any || g.maximum > hi { hi = g.maximum; } any = true; } gs.push(copy(g)); cols.push(col);
    }
    if !any { return XpkText { "","" }; }
    if lo <= 9223372036854775807-max_span && hi >= lo+max_span { return XpkText { "","table span limit" }; }
    let span = hi-lo+1; if span > max_cells/ps.len || span > 1000000/(work+1) { return XpkText { "","table cell/work limit" }; }
    var s: u8[>..] = []; for offset in 0..span { let r = lo+offset; s.append(str(r)); for g,j in gs { s.push('\t'); var first = -1; for group in g.groups { if group.residue == r { first = group.rows[0]; } } if first < 0 { s.push('*'); } else { for p,k in ps { if k == j { let row = xpk_row(p,first); s.append(xpk_field(row.fields,cols[j])); } } } } s.push('\n'); } return XpkText { copy(s),"" };
}
fn xpk_replace(raw: u8[:], column: i64, value: u8[:]) -> u8[] {
    var field = 0; var start = -1; var out: u8[>..] = [];
    for i in 0..raw.len+1 { let space = i == raw.len || raw[i] == ' ' || raw[i] == '\t' || raw[i] == '\r';
        if space && start >= 0 { if field == column { out.append(raw[..start]); out.append(value); out.append(raw[i..]); return copy(out); } field += 1; start = -1; } else if !space && start < 0 { start = i; }
    } return str(raw);
}
/* Uses compensated summation then division, with scaled fallback on overflow. Scaling loss,
 * underflow to zero, and nonfinite results fail without prediction. Finite means are binary64
 * approximations; conversion and formatting can introduce rounding error. */
fn xpk_mean(values: const f64[:]) -> f64, bool {
    if values.len == 0 { return 0.0, false; }
    var maximum = 0.0;
    for value in values {
        if is_nan(value) || is_inf(value) { return 0.0, false; }
        maximum = max(maximum,abs(value));
    }
    if maximum == 0.0 { return 0.0, true; }
    for pass in 0..2 {
        let scale = if pass == 0 { 1.0 } else { maximum };
        var total = 0.0; var correction = 0.0; var finite = true;
        for value in values {
            let v = value/scale;
            if value != 0.0 && v == 0.0 { return 0.0, false; }
            let next = total+v;
            if is_inf(next) { finite = false; break; }
            correction += if abs(total) >= abs(v) { (total-next)+v } else { (v-next)+total };
            total = next;
        }
        let sum = total+correction;
        if !finite || is_inf(sum) || is_nan(sum) { continue; }
        let divided = sum/(values.len as f64);
        let mean = divided*scale;
        if is_inf(mean) || is_nan(mean) || (sum != 0.0 && (divided == 0.0 || mean == 0.0)) { return 0.0, false; }
        return mean, true;
    }
    return 0.0, false;
}
/*
Indexes both residues through the detected nucleus. Copies the first destination row,
replaces origin assignment with the first source assignment and origin ppm with the
source mean. Detected ppm, other fields, and spacing retain destination values.
*/
/* Checks equal origin/detected residue prefixes on every row unless assert_diagonal=true. Self-
 * assignment does not prove experimental suitability. Missing residues return found=false without
 * error; missing labels/invalid assumptions fail. */
fn predict_xpk_noe(p: Xpk&, origin: u8[:], detected: u8[:], from_res: i64, to_res: i64, assert_diagonal: bool) -> XpkPrediction {
    let empty = XpkRow { "",[] }; let a = xpk_column(p,xpk_label(origin,".L")); let b = xpk_column(p,xpk_label(origin,".P")); let d = xpk_column(p,xpk_label(detected,".L")); let dp = xpk_column(p,xpk_label(detected,".P"));
    if a < 0 || b < 0 || d < 0 || dp < 0 { return XpkPrediction { false,empty,"missing prediction labels" }; }
    if !assert_diagonal { for row in p.rows { let r,ok = xpk_residue(xpk_field(row.fields,a)); let s,valid = xpk_residue(xpk_field(row.fields,d)); if !ok || !valid || r != s { return XpkPrediction { false,empty,"diagonal assumption fails" }; } } }
    let groups = xpk_group(p,detected); var src: i64[>..] = []; var dst = -1;
    for g in groups.groups { if g.residue == from_res { src.append(g.rows); } if g.residue == to_res { dst = g.rows[0]; } }
    if src.len == 0 || dst < 0 { return XpkPrediction { false,empty,"" }; }
    var values: f64[>..] = [];
    for id in src {
        let row = xpk_row(p,id); let v,ok = xpk_number(xpk_field(row.fields,b));
        if !ok { return XpkPrediction { false,empty,"invalid source ppm" }; }
        values.push(v);
    }
    let mean, representable = xpk_mean(values);
    if !representable { return XpkPrediction { false,empty,"mean precision or range limit" }; }
    let dest = xpk_row(p,dst); let source = xpk_row(p,src[0]); let raw = xpk_replace(dest.raw,a,xpk_field(source.fields,a)); let fixed = xpk_replace(raw,b,str(mean));
    return XpkPrediction { true,XpkRow { fixed,xpk_words(fixed) },"" };
}
