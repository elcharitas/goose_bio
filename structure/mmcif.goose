namespace bio;
import std;

// Token kind: 0 = value, 1 = unknown (?), 2 = inapplicable (.).
/*
Unknown ?, inapplicable ., and quoted literals remain distinct. Tags/control words match
without case sensitivity. PDB Atom remains a separate model.
*/
struct CifToken { text: u8[], kind: i64, quoted: bool }
struct CifTokens { tokens: CifToken[], error: u8[] }
struct CifItem { tags: u8[][], values: CifToken[], looped: bool }
/*
Whole documents are buffered. Atom-loop cells and column indices are resolved once for
constant-time access; duplicate-tag checks and residue grouping can be quadratic. No
assembly, symmetry, dictionary, bond, disorder-selection, or streaming API.
*/
struct CifDocument { name: u8[], items: CifItem[] }
struct CifResult { document: CifDocument, error: u8[] }
struct CifText { text: u8[], error: u8[] }

fn cif_space(c: u8) -> bool { c == ' ' || c == '\t' || c == '\n' || c == '\r' }
fn cif_lower(s: const u8[:]) -> u8[] {
    var out: u8[>..] = [];
    for c in s { out.push(if c >= 'A' && c <= 'Z' { c + 32 } else { c }); }
    copy(out)
}
fn cif_control(t: const CifToken&) -> bool {
    if t.quoted { return false; }
    let s = cif_lower(t.text);
    s == "loop_" || s == "stop_" || s == "global_" ||
        starts_with(s, "data_") || starts_with(s, "save_") ||
        (s.len > 0 && s[0] == '_')
}
/*
Supports CIF 1.x scalars, loops, comments, quoted values, and column-one semicolon
fields. LF, CRLF, and bare CR normalize to LF, including text fields; quoted single-line
values reject line breaks. Bare initial $, [, and ] fail.
*/
fn tokenize_mmcif(input: const u8[:]) -> CifTokens {
    if input.len > 67108864 { return CifTokens { [], "CIF input exceeds 64 MiB" }; }
    var normalized: u8[>..] = [];
    var pos = 0;
    while pos < input.len {
        if input[pos] == '\r' {
            normalized.push('\n');
            if pos + 1 < input.len && input[pos+1] == '\n' { pos += 1; }
        } else { normalized.push(input[pos]); }
        pos += 1;
    }
    let text = copy(normalized);
    for c in text {
        if (c < 32 && !cif_space(c)) || c > 126 {
            return CifTokens { [], "unsupported CIF byte" };
        }
    }
    var out: CifToken[>..] = [];
    var i = 0;
    while i < text.len {
        if cif_space(text[i]) { i += 1; continue; }
        if text[i] == '#' {
            while i < text.len && text[i] != '\n' { i += 1; }
            continue;
        }
        var value: u8[>..] = [];
        var quoted = false;
        if text[i] == ';' && (i == 0 || text[i-1] == '\n') {
            quoted = true; i += 1;
            var closed = false;
            while i < text.len {
                if text[i] == ';' && text[i-1] == '\n' {
                    if value.len > 0 && value[value.len-1] == '\n' { value.pop(); }
                    i += 1; closed = true; break;
                }
                value.push(text[i]); i += 1;
            }
            if !closed { return CifTokens { [], "unterminated CIF text field" }; }
            if i < text.len && !cif_space(text[i]) {
                return CifTokens { [], "characters after CIF text delimiter" };
            }
        } else if text[i] == '\'' || text[i] == '"' {
            quoted = true;
            let quote = text[i]; i += 1;
            var closed = false;
            while i < text.len {
                if text[i] == '\n' || text[i] == '\r' {
                    return CifTokens { [], "newline in CIF quoted token" };
                }
                if text[i] == quote && (i+1 == text.len || cif_space(text[i+1])) {
                    i += 1; closed = true; break;
                }
                value.push(text[i]); i += 1;
            }
            if !closed { return CifTokens { [], "unterminated CIF quoted token" }; }
        } else {
            if text[i] == '$' || text[i] == '[' || text[i] == ']' || text[i] == ';' {
                return CifTokens { [], "reserved initial CIF character" };
            }
            while i < text.len && !cif_space(text[i]) {
                if text[i] < 32 || text[i] > 126 {
                    return CifTokens { [], "unsupported CIF byte" };
                }
                value.push(text[i]); i += 1;
            }
        }
        let kind = if !quoted && value == "?" { 1 } else if !quoted && value == "." { 2 } else { 0 };
        out.push(CifToken { copy(value), kind, quoted });
    }
    CifTokens { copy(out), "" }
}
/*
Requires one named data block. Save/global frames, multiple blocks, stop_, duplicate
tags, empty loops, and incomplete rows fail. CIF 2.0 Unicode, lists, and tables are
unsupported.
*/
fn parse_mmcif(text: const u8[:]) -> CifResult {
    let lex = tokenize_mmcif(text);
    let empty = CifDocument { "", [] };
    if lex.error.len > 0 { return CifResult { empty, copy(lex.error) }; }
    var ts: const CifToken&[>..] = [];
    for t in lex.tokens { ts.push(t); }
    if ts.len == 0 || ts[0].quoted || !starts_with(cif_lower(ts[0].text), "data_") || ts[0].text.len <= 5 {
        return CifResult { empty, "expected one named CIF data block" };
    }
    var items: CifItem[>..] = [];
    var seen: u8[][>..] = [];
    var i = 1;
    while i < ts.len {
        let looped = !ts[i].quoted && cif_lower(ts[i].text) == "loop_";
        if looped { i += 1; }
        var tags: u8[][>..] = [];
        while i < ts.len && !ts[i].quoted && starts_with(ts[i].text, "_") {
            let tag = cif_lower(ts[i].text);
            for old in seen { if old == tag { return CifResult { empty, "duplicate CIF tag" }; } }
            tags.push(copy(tag)); seen.push(copy(tag)); i += 1;
            if !looped { break; }
        }
        if tags.len == 0 { return CifResult { empty, "unsupported CIF control or multiple blocks" }; }
        var values: CifToken[>..] = [];
        while i < ts.len && !cif_control(ts[i]) {
            values.push(CifToken { copy(ts[i].text), ts[i].kind, ts[i].quoted }); i += 1;
            if !looped { break; }
        }
        if values.len == 0 || values.len % tags.len != 0 {
            return CifResult { empty, "CIF value count does not match tags" };
        }
        items.push(CifItem { copy(tags), copy(values), looped });
    }
    CifResult { CifDocument { ts[0].text[5..], copy(items) }, "" }
}
fn cif_encode(t: const CifToken&) -> CifText {
    if t.kind == 1 { return CifText { "?", "" }; }
    if t.kind == 2 { return CifText { ".", "" }; }
    if t.kind != 0 { return CifText { "", "invalid CIF missing kind" }; }
    var bare = t.text.len > 0 && t.text != "." && t.text != "?";
    if t.text.len > 0 && (t.text[0] == '$' || t.text[0] == '[' || t.text[0] == ']') { bare = false; }
    var single = false; var double_quote = false; var multiline = false;
    for c in t.text {
        if cif_space(c) || c == '#' || c == ';' || c == '\'' || c == '"' { bare = false; }
        if c == '\'' { single = true; }
        if c == '"' { double_quote = true; }
        if c == '\n' || c == '\r' { multiline = true; }
        if (c < 32 && !cif_space(c)) || c > 126 { return CifText { "", "unsupported CIF byte" }; }
    }
    let raw = CifToken { copy(t.text), 0, false };
    if cif_control(raw) { bare = false; }
    if bare { return CifText { copy(t.text), "" }; }
    if !multiline && !single { return CifText { str("'", t.text, "'"), "" }; }
    if !multiline && !double_quote { return CifText { str("\"", t.text, "\""), "" }; }
    for c, i in t.text {
        if c == ';' && (i == 0 || t.text[i-1] == '\n') {
            return CifText { "", "CIF value cannot use text delimiter" };
        }
    }
    CifText { str(";", t.text, "\n;"), "" }
}
fn cif_output_tag(tag: const u8[:]) -> u8[] {
    for canonical in ["_atom_site.Cartn_x", "_atom_site.Cartn_y", "_atom_site.Cartn_z",
        "_atom_site.B_iso_or_equiv", "_atom_site.group_PDB",
        "_atom_site.pdbx_PDB_ins_code", "_atom_site.pdbx_PDB_model_num"] {
        if cif_lower(canonical) == tag { return str(canonical); }
    }
    str(tag)
}
/*
Preserves stored values, token states, tags, row order, unknown categories, and extra
atom columns. Tag case, spacing, quoting, and comments normalize. Output is reparsed to
reject changed values; literal CR and values without usable CIF delimiters fail.
*/
fn write_mmcif(doc: const CifDocument&) -> CifText {
    if doc.name.len == 0 { return CifText { "", "empty CIF block name" }; }
    for c in doc.name { if cif_space(c) || c < 33 || c > 126 { return CifText { "", "invalid CIF block name" }; } }
    var out: u8[>..] = [];
    out.append(str("data_", doc.name, "\n"));
    for item in doc.items {
        if item.tags.len == 0 || item.values.len == 0 || item.values.len % item.tags.len != 0 ||
           (!item.looped && (item.tags.len != 1 || item.values.len != 1)) {
            return CifText { "", "invalid CIF item dimensions" };
        }
        if item.looped { out.append("loop_\n"); }
        for tag in item.tags {
            if tag.len < 2 || tag[0] != '_' { return CifText { "", "invalid CIF tag" }; }
            for c in tag { if c <= 32 || c > 126 { return CifText { "", "invalid CIF tag byte" }; } }
            out.append(str(cif_output_tag(tag), "\n"));
        }
        for t in item.values {
            let v = cif_encode(t);
            if v.error.len > 0 { return v; }
            out.append(str(v.text, "\n"));
        }
    }
    let valid = parse_mmcif(out);
    if valid.error.len > 0 { return CifText { "", copy(valid.error) }; }
    var original: const CifToken&[>..] = [];
    for item in doc.items { for t in item.values { original.push(t); } }
    var index = 0;
    for item in valid.document.items { for t in item.values {
        if index >= original.len || t.text != original[index].text || t.kind != original[index].kind {
            return CifText { "", "CIF serialization would change a value" };
        }
        index += 1;
    } }
    if index != original.len { return CifText { "", "CIF serialization would lose values" }; }
    CifText { copy(out), "" }
}
