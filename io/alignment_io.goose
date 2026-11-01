// Strict single-block CLUSTAL and relaxed sequential PHYLIP.
// No interleaving, wrapped rows, descriptions, or alignment annotations.
// CLUSTAL header text and consensus lines are not retained.
// Consensus requires >=2 rows, shared columns, full width, and EOF.
// Import bio.io.alignment_io explicitly; APIs consume whole text.
// Bytes retain case; PHYLIP rejects dots, CLUSTAL allows dot gaps.
namespace bio;
import std;
import .formats;

fn alignment_words(line: u8[:]) -> TextRow {
    var fields: u8[][>..] = []; var start = -1;
    for c, i in line {
        if c == ' ' || c == '\t' {
            if start >= 0 { fields.push(str(line[start..i])); start = -1; }
        } else if start < 0 { start = i; }
    }
    if start >= 0 { fields.push(str(line[start..])); }
    return TextRow { copy(fields) };
}
fn validate_aligned_records(records: SequenceRecord[:]) -> u8[] {
    if records.len == 0 { return "empty alignment"; }
    var length = -1;
    for r, i in records {
        if r.header.len == 0 || r.sequence.len == 0 || r.quality.len > 0 { return "invalid aligned record"; }
        for c in r.header { if c <= 32 || c > 126 { return "alignment identifier must be one token"; } }
        if length < 0 { length = r.sequence.len; }
        if r.sequence.len != length { return "unequal aligned lengths"; }
        for c in r.sequence {
            if !((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '-' || c == '.') { return "invalid aligned residue"; }
        }
        for other, j in records { if j < i && r.header == other.header { return "duplicate alignment identifier or unsupported interleaving"; } }
    }
    return "";
}
/* Text codecs buffer complete input and return error strings. Check errors before using data.
 */
fn parse_alignment_io(text: u8[:], phylip: bool) -> RecordsResult {
    var records: SequenceRecord[>..] = []; var active = false;
    var expected = 0; var length = 0;
    var column = -1; var consensus_seen = false;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if trim(line).len == 0 { continue; }
        if !active {
            if phylip {
                let row = alignment_words(line);
                if row.fields.len != 2 { return RecordsResult { [], "expected PHYLIP dimensions" }; }
                var count = 0;
                for w in row.fields {
                    let n, ok = parse_int(w);
                    if !ok || n <= 0 { return RecordsResult { [], "invalid PHYLIP dimensions" }; }
                    if count == 0 { expected = n; } else { length = n; } count += 1;
                }
            } else if !starts_with(line, "CLUSTAL ") && line != "CLUSTAL" { return RecordsResult { [], "expected CLUSTAL header" }; }
            active = true; continue;
        }
        if consensus_seen { return RecordsResult { [], "rows after CLUSTAL consensus unsupported" }; }
        if !phylip && (line[0] == ' ' || line[0] == '\t') {
            var consensus = true;
            for c in line { if c != ' ' && c != '*' && c != ':' && c != '.' { consensus = false; } }
            if consensus && records.len >= 2 && column >= 0 && line.len == column + length {
                var placed = true;
                for c, i in line { if i < column && c != ' ' { placed = false; } }
                if placed { consensus_seen = true; continue; }
            }
        }
        let row = alignment_words(line);
        if row.fields.len != 2 { return RecordsResult { [], "expected unwrapped alignment row; counts unsupported" }; }
        var name: u8[>..] = []; var seq: u8[>..] = [];
        for w, i in row.fields { if i == 0 { name.append(w); } else { seq.append(w); } }
        if phylip && seq.len != length { return RecordsResult { [], "PHYLIP length mismatch or unsupported wrapping" }; }
        if phylip {
            for c in seq { if c == '.' { return RecordsResult { [], "PHYLIP dot residues unsupported" }; } }
        } else {
            var start = 0;
            while start < line.len && (line[start] == ' ' || line[start] == '\t') { start += 1; }
            while start < line.len && line[start] != ' ' && line[start] != '\t' { start += 1; }
            while start < line.len && (line[start] == ' ' || line[start] == '\t') { start += 1; }
            if column < 0 { column = start; length = seq.len; }
            if start != column { return RecordsResult { [], "inconsistent CLUSTAL sequence columns" }; }
        }
        records.push(SequenceRecord { copy(name), copy(seq), "" });
    }
    let error = validate_aligned_records(records);
    if error.len > 0 { return RecordsResult { [], copy(error) }; }
    if phylip && records.len != expected { return RecordsResult { [], "PHYLIP row count mismatch" }; }
    return RecordsResult { copy(records), "" };
}
fn parse_clustal(text: u8[:]) -> RecordsResult { return parse_alignment_io(text, false); }
fn parse_phylip(text: u8[:]) -> RecordsResult { return parse_alignment_io(text, true); }
fn write_alignment_io(records: SequenceRecord[:], phylip: bool) -> FormatTextResult {
    let error = validate_aligned_records(records);
    if error.len > 0 { return FormatTextResult { "", copy(error) }; }
    var out: u8[>..] = [];
    if phylip {
        out.append(str(records.len)); out.push(' ');
        for r, i in records { if i == 0 { out.append(str(r.sequence.len)); } }
        out.push('\n');
    } else { out.append("CLUSTAL W\n\n"); }
    var width = 0;
    for r in records { if r.header.len > width { width = r.header.len; } }
    for r in records {
        if phylip { for c in r.sequence { if c == '.' { return FormatTextResult { "", "PHYLIP dot residues unsupported" }; } } }
        out.append(r.header);
        for i in (if phylip { 1 } else { width - r.header.len + 1 }) { out.push(' '); }
        out.append(r.sequence); out.push('\n');
    }
    return FormatTextResult { copy(out), "" };
}
fn write_clustal(records: SequenceRecord[:]) -> FormatTextResult { return write_alignment_io(records, false); }
fn write_phylip(records: SequenceRecord[:]) -> FormatTextResult { return write_alignment_io(records, true); }
