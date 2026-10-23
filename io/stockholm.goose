// Whole alignment model retains generic Stockholm annotation tags.
namespace bio;
import std;
import .alignment_io;
import .genbank;

struct StockholmField { scope: u8[], id: u8[], tag: u8[], value: u8[] }
/*
Aligned sequences accept letters, dash, and dot. Ordered GF/GS fields retain repeated
and unknown tags. Annotation values are ASCII, retain internal spaces, and reject
trailing padding/control bytes; separator whitespace is structural.
*/
struct StockholmAlignment { records: SequenceRecord[], fields: StockholmField[] }
struct StockholmResult { alignment: StockholmAlignment, error: u8[] }
fn stockholm_error(message: u8[:]) -> StockholmResult {
    return StockholmResult { StockholmAlignment { [], [] }, str(message) };
}
/*
Reads one alignment. GR/GC segments concatenate by ID/tag across blocks; final lengths
must match sequences and GS/GR IDs must exist. Individual blocks need not be complete.
Unstructured comments fail; block layout is not retained. Continuations may copy repeatedly.
*/
fn parse_stockholm(text: u8[:]) -> StockholmResult {
    var records: SequenceRecord[>..] = []; var fields: StockholmField[>..] = [];
    var state = 0;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if trim(line).len == 0 { continue; }
        if state == 0 {
            if line != "# STOCKHOLM 1.0" { return stockholm_error("expected Stockholm header"); }
            state = 1; continue;
        }
        if state == 2 { return stockholm_error("multiple alignments or trailing data"); }
        if line == "//" { state = 2; continue; }
        if starts_with(line, "#=") {
            if line.len < 5 || line[4] != ' ' { return stockholm_error("invalid annotation prefix"); }
            let scope = line[2..4]; let words = alignment_words(line[5..]);
            let per_id = scope == "GS" || scope == "GR";
            if scope != "GF" && scope != "GC" && !per_id { return stockholm_error("unsupported Stockholm annotation scope"); }
            let need = if per_id { 3 } else { 2 };
            if words.fields.len < need { return stockholm_error("incomplete annotation"); }
            var id: u8[>..] = []; var tag: u8[>..] = [];
            for w, i in words.fields { if per_id && i == 0 { id.append(w); } if i == (if per_id { 1 } else { 0 }) { tag.append(w); } }
            var pos = 5; var count = 0;
            while count < need-1 {
                while pos < line.len && (line[pos] == ' ' || line[pos] == '\t') { pos += 1; }
                while pos < line.len && line[pos] != ' ' && line[pos] != '\t' { pos += 1; }
                count += 1;
            }
            while pos < line.len && (line[pos] == ' ' || line[pos] == '\t') { pos += 1; }
            let value = line[pos..]; var found = false;
            if value.len == 0 || trim(value) != value { return stockholm_error("empty or padded annotation value"); }
            for c in value { if c < 32 || c > 126 { return stockholm_error("invalid annotation value"); } }
            if scope == "GR" || scope == "GC" {
                for c in value { if c <= 32 || c > 126 { return stockholm_error("invalid per-letter annotation"); } }
                var updated: StockholmField[>..] = [];
                for f in fields {
                    if f.scope == scope && f.id == id && f.tag == tag {
                        var joined: u8[>..] = []; joined.append(f.value); joined.append(value);
                        updated.push(StockholmField { str(scope), copy(id), copy(tag), copy(joined) }); found = true;
                    } else { updated.push(copy(f)); }
                }
                fields.clear(); fields.append(updated);
            }
            if !found { fields.push(StockholmField { str(scope), copy(id), copy(tag), str(value) }); }
        } else if starts_with(line, "#") { return stockholm_error("unstructured comments unsupported");
        } else {
            let row = alignment_words(line);
            if row.fields.len != 2 { return stockholm_error("expected identifier and aligned sequence"); }
            var id: u8[>..] = []; var seq: u8[>..] = []; var found = false;
            for w, i in row.fields { if i == 0 { id.append(w); } else { seq.append(w); } }
            var updated: SequenceRecord[>..] = [];
            for r in records {
                if r.header == id {
                    var joined: u8[>..] = []; joined.append(r.sequence); joined.append(seq);
                    updated.push(SequenceRecord { copy(id), copy(joined), "" }); found = true;
                } else { updated.push(copy(r)); }
            }
            records.clear(); records.append(updated);
            if !found { records.push(SequenceRecord { copy(id), copy(seq), "" }); }
        }
    }
    if state != 2 { return stockholm_error("truncated Stockholm alignment"); }
    let error = validate_aligned_records(records);
    if error.len > 0 { return stockholm_error(error); }
    for f in fields {
        var found = f.id.len == 0;
        for r in records {
            if f.scope == "GC" && f.value.len != r.sequence.len { return stockholm_error("GC length mismatch"); }
            if r.header == f.id {
                found = true;
                if f.scope == "GR" && f.value.len != r.sequence.len { return stockholm_error("GR length mismatch"); }
            }
        }
        if !found { return stockholm_error("annotation refers to absent sequence"); }
    }
    return StockholmResult { StockholmAlignment { copy(records), copy(fields) }, "" };
}
/*
Emits one block. Duplicate GR/GC, quality data, and invalid annotations fail instead of
being discarded.
*/
fn write_stockholm(alignment: StockholmAlignment) -> FormatTextResult {
    var out: u8[>..] = []; out.append("# STOCKHOLM 1.0\n");
    for f in alignment.fields {
        if (f.scope != "GF" && f.scope != "GC" && f.scope != "GS" && f.scope != "GR") || !genbank_token(f.tag) { return FormatTextResult { "", "invalid annotation scope or tag" }; }
        if (f.scope == "GF" || f.scope == "GC") && f.id.len > 0 { return FormatTextResult { "", "unexpected annotation identifier" }; }
        if (f.scope == "GS" || f.scope == "GR") && !genbank_token(f.id) { return FormatTextResult { "", "missing annotation identifier" }; }
        if f.value.len == 0 || trim(f.value) != f.value { return FormatTextResult { "", "empty or padded annotation value" }; }
        for c in f.value { if c < 32 || c > 126 { return FormatTextResult { "", "invalid annotation value" }; } }
        out.append("#="); out.append(f.scope); out.push(' ');
        if f.id.len > 0 { out.append(f.id); out.push(' '); }
        out.append(f.tag); out.push(' '); out.append(f.value); out.push('\n');
    }
    let error = validate_aligned_records(alignment.records);
    if error.len > 0 { return FormatTextResult { "", copy(error) }; }
    for r in alignment.records { if r.header[0] == '#' || r.header == "//" { return FormatTextResult { "", "reserved sequence identifier" }; } out.append(r.header); out.push(' '); out.append(r.sequence); out.push('\n'); }
    out.append("//\n"); let parsed = parse_stockholm(out);
    if parsed.error.len > 0 { return FormatTextResult { "", copy(parsed.error) }; }
    if parsed.alignment.fields.len != alignment.fields.len { return FormatTextResult { "", "duplicate per-letter annotation" }; }
    return FormatTextResult { copy(out), "" };
}
