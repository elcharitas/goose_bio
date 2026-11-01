// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import .genbank;
import sequence.records;

fn rich_position_text(p: RecordPosition, start: bool) -> u8[] {
    var out: u8[>..] = [];
    if p.kind == 1 { out.push('<'); } if p.kind == 2 { out.push('>'); }
    out.append(str(p.value + (if start { 1 } else { 0 }))); return copy(out);
}
fn rich_logical_lines(text: u8[:]) -> FormatTextResult {
    var out: u8[>..] = []; var pending: u8[>..] = []; var quoted = false;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if quoted {
            if line.len < 21 || trim(line[5..21]).len != 0 { return FormatTextResult { "", "invalid qualifier continuation" }; }
            let value = trim(line[21..]);
            if !starts_with(trim(pending[21..]), "/translation=") { pending.push(' '); }
            pending.append(value);
        } else { pending.clear(); pending.append(line); }
        var quotes = 0;
        if pending.len >= 21 && starts_with(trim(pending[21..]), "/") {
            for c in pending[21..] { if c == '"' { quotes += 1; } }
        }
        quoted = quotes % 2 != 0;
        if !quoted { out.append(pending); out.push('\n'); }
    }
    if quoted { return FormatTextResult { "", "unterminated quoted qualifier" }; }
    return FormatTextResult { copy(out), "" };
}
struct RichRecordsResult { records: RichRecord[], error: u8[] }
struct RichLocationResult { parts: RecordLocationPart[], error: u8[] }

recursive fn rich_genbank_location_parts(text: u8[:], parts: RecordLocationPart[>..]&, depth: i64) -> bool {
    if depth > 64 || text.len == 0 { return false; }
    if starts_with(text, "complement(") && text[text.len - 1] == ')' {
        let begin = parts.len;
        if !rich_genbank_location_parts(text[11..text.len - 1], parts, depth + 1) { return false; }
        var ordered: RecordLocationPart[>..] = [];
        for p, j in parts { if j < begin { ordered.push(copy(p)); } }
        for i in parts.len - begin { for p, j in parts {
            if j == parts.len - 1 - i { ordered.push(RecordLocationPart { copy(p.start), copy(p.end), -p.strand, "" }); }
        } }
        parts.clear(); parts.append(ordered);
        return true;
    }
    if starts_with(text, "join(") && text[text.len - 1] == ')' {
        var level = 0; var begin = 5;
        for i in text.len {
            if i < 5 || i == text.len - 1 { continue; }
            if text[i] == '(' { level += 1; }
            if text[i] == ')' { level -= 1; }
            if level < 0 { return false; }
            if text[i] == ',' && level == 0 {
                if !rich_genbank_location_parts(text[begin..i], parts, depth + 1) { return false; }
                begin = i + 1;
            }
        }
        if level != 0 { return false; }
        return rich_genbank_location_parts(text[begin..text.len - 1], parts, depth + 1);
    }
    let dots = split(text, '.');
    if dots.len != 1 && (dots.len != 3 || dots[1].len != 0) { return false; }
    let left = dots[0]; let right = if dots.len == 1 { dots[0] } else { dots[2] };
    let a = rich_position(left, true); let b = rich_position(right, false);
    if a.kind < 0 || b.kind < 0 || a.value >= b.value { return false; }
    parts.push(RecordLocationPart { copy(a), copy(b), 1, "" }); return true;
}
fn rich_position(text: u8[:], start: bool) -> RecordPosition {
    if text.len == 0 { return RecordPosition { -1, 0 }; }
    let kind = if text[0] == '<' { 1 } else if text[0] == '>' { 2 } else { 0 };
    let digits = if kind == 0 { text } else { text[1..] };
    for c in digits { if c < '0' || c > '9' { return RecordPosition { -1, 0 }; } }
    let n, ok = parse_int(digits);
    if !ok || n < 1 { return RecordPosition { -1, 0 }; }
    return RecordPosition { kind, if start { n - 1 } else { n } };
}

/*
Supports recursive join/complement to depth 64, representing joins only. Order, between-
base, remote, unknown, one-of, and other position classes fail. Nonempty ORIGIN metadata
fails. Whole-record buffering has no allocation cap; complement reordering can be
quadratic.
*/
fn rich_genbank_location(text: u8[:]) -> RichLocationResult {
    var parts: RecordLocationPart[>..] = [];
    if !rich_genbank_location_parts(text, parts, 0) { return RichLocationResult { [], "unsupported or invalid exact location" }; }
    return RichLocationResult { copy(parts), "" };
}

fn rich_io_token(text: u8[:]) -> bool {
    if text.len == 0 { return false; }
    for c in text { if c <= 32 || c > 126 || c == '=' || c == '"' { return false; } }
    return true;
}

/*
RichRecord retains extraction order, exact/before/after bounds, repeated qualifiers,
doubled quotes, multiline text/descriptions, and linear/circular topology. Translation
continuations concatenate; other continuations join with one space. Sequence normalizes
uppercase; wholly undefined sequence keeps length.
*/
fn rich_parse_genbank(text: u8[:]) -> RichRecordsResult {
    var records:    RichRecord[>..]       = [];
    var id:         u8[>..]               = []; var description: u8[>..] = [];
    var headers:    u8[][>..]             = []; var sequence: u8[>..] = [];
    var features:   RecordFeature[>..]    = [];
    var kind:       u8[>..]               = []; var location: u8[>..] = [];
    var qualifiers: FeatureQualifier[>..] = [];
    var definition = false; var definition_seen = false;
    var state = 0; var length = 0; var rna = false; var topology = 0;
    let logical = rich_logical_lines(text);
    if logical.error.len > 0 { return RichRecordsResult { [], copy(logical.error) }; }
    for raw in split(logical.text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if starts_with(line, "LOCUS ") && state == 0 {
            let words = split(trim(line[5..]), ' ');
            var tokens: u8[][>..] = [];
            for w in words { if w.len > 0 { tokens.push(str(w)); } }
            var name: u8[>..] = []; var size: u8[>..] = []; var unit: u8[>..] = [];
            for t, i in tokens { if i == 0 { name.clear(); name.append(t); } if i == 1 { size.clear(); size.append(t); } if i == 2 { unit.clear(); unit.append(t); } }
            if tokens.len != 7 || unit != "bp" { return RichRecordsResult { [], "unsupported LOCUS" }; }
            let n, ok = parse_int(size);
            if !ok || n < 0 { return RichRecordsResult { [], "invalid LOCUS length" }; }
            id.clear(); id.append(name); length = n; rna = false; topology = 0;
            for t, i in tokens { if i == 4 && t == "circular" { topology = 1; } }
            for t, i in tokens { if i == 3 { if t != "DNA" && t != "RNA" { return RichRecordsResult { [], "unsupported molecule" }; } rna = t == "RNA"; } if i == 4 && t != "linear" && t != "circular" { return RichRecordsResult { [], "unsupported topology" }; } }
            headers.clear(); headers.push(str(line)); sequence.clear(); features.clear();
            kind.clear(); location.clear(); qualifiers.clear(); description.clear(); definition = false; definition_seen = false; state = 1;
        } else if line == "//" && state == 3 {
            let normalized = normalize_sequence(sequence, rna);
            if (sequence.len != 0 && sequence.len != length) || normalized.error.len > 0 { return RichRecordsResult { [], "invalid sequence or LOCUS length mismatch" }; }
            var segments: DefinedSegment[>..] = [];
            if sequence.len > 0 { segments.push(DefinedSegment { 0, copy(normalized.value) }); }
            let record = RichRecord { copy(id), copy(description), length, copy(segments),
                [FeatureQualifier { "genbank_header", copy(headers) }], copy(features), [], rna, topology };
            let error = validate_rich_record(copy(record));
            if error.len > 0 { return RichRecordsResult { [], copy(error) }; }
            records.push(copy(record)); state = 0;
        } else if starts_with(line, "FEATURES ") && state == 1 { state = 2;
        } else if line == "ORIGIN" || starts_with(line, "ORIGIN ") {
            if state != 1 && state != 2 { return RichRecordsResult { [], "unexpected ORIGIN" }; }
            if trim(line[6..]).len > 0 { return RichRecordsResult { [], "ORIGIN metadata unsupported" }; }
            if kind.len > 0 {
                let loc = rich_genbank_location(location);
                if loc.error.len > 0 { return RichRecordsResult { [], copy(loc.error) }; }
                features.push(RecordFeature { copy(kind), copy(loc.parts), copy(qualifiers) });
            }
            state = 3;
        } else if state == 1 {
            if starts_with(line, "DEFINITION ") {
                if definition_seen { return RichRecordsResult { [], "duplicate DEFINITION" }; }
                if line.len < 12 { return RichRecordsResult { [], "short DEFINITION" }; }
                definition_seen = true;
                description.clear(); description.append(trim(line[12..])); definition = true;
            } else {
                if line.len < 12 { return RichRecordsResult { [], "short header" }; }
                if definition && starts_with(line, "            ") { description.push(' '); description.append(trim(line)); continue; }
                definition = false; headers.push(str(line));
            }
        } else if state == 2 {
            if line.len < 21 || line[..5] != "     " { return RichRecordsResult { [], "invalid feature line" }; }
            let name = trim(line[5..21]); let value = trim(line[21..]);
            if name.len > 0 {
                if kind.len > 0 {
                    let loc = rich_genbank_location(location);
                    if loc.error.len > 0 { return RichRecordsResult { [], copy(loc.error) }; }
                    features.push(RecordFeature { copy(kind), copy(loc.parts), copy(qualifiers) });
                }
                if !rich_io_token(name) { return RichRecordsResult { [], "invalid feature key" }; }
                kind.clear(); kind.append(name); location.clear(); location.append(value); qualifiers.clear();
            } else if value.len > 0 && value[0] == '/' {
                if kind.len == 0 { return RichRecordsResult { [], "qualifier without feature" }; }
                var eq = -1;
                for c, i in value { if c == '=' && eq < 0 { eq = i; } }
                let key = if eq < 0 { value[1..] } else { value[1..eq] };
                if !rich_io_token(key) { return RichRecordsResult { [], "invalid qualifier key" }; }
                if eq < 0 { qualifiers.push(FeatureQualifier { str(key), [] }); }
                else {
                    let v = value[eq + 1..];
                    if v.len == 0 { return RichRecordsResult { [], "empty unquoted qualifier" }; }
                    var decoded: u8[>..] = [];
                    if v[0] == '"' {
                        if v.len < 2 || v[v.len - 1] != '"' { return RichRecordsResult { [], "multiline qualifier unsupported" }; }
                        var i = 1;
                        while i < v.len - 1 {
                            if v[i] == '"' {
                                if i + 1 >= v.len - 1 || v[i + 1] != '"' { return RichRecordsResult { [], "invalid quoted qualifier" }; }
                                i += 1;
                            }
                            decoded.push(v[i]); i += 1;
                        }
                    } else { decoded.append(v); }
                    if key == "translation" {
                        var compact: u8[>..] = [];
                        for c in decoded { if c != ' ' && (c < 9 || c > 13) { compact.push(c); } }
                        decoded.clear(); decoded.append(compact);
                    }
                    qualifiers.push(FeatureQualifier { str(key), [copy(decoded)] });
                }
            } else {
                if qualifiers.len > 0 || kind.len == 0 { return RichRecordsResult { [], "multiline qualifier unsupported" }; }
                location.append(value);
            }
        } else if state == 3 {
            for c in line {
                if c == ' ' || c == '\t' || (c >= '0' && c <= '9') { continue; }
                sequence.push(c);
            }
        } else { return RichRecordsResult { [], "expected LOCUS or terminator" }; }
    }
    if state != 0 { return RichRecordsResult { [], "truncated GenBank record" }; }
    return RichRecordsResult { copy(records), "" };
}

// Canonical joins retain extraction order and each part's strand.
/*
Regenerates identifier/length/molecule/topology, retaining GenBank division/date.
Rejects partial sequences, tracks, remote/unknown/empty locations, unsupported metadata,
and EMBL raw headers. Map headers explicitly across formats; update stale coordinate-
bearing metadata after transforms.
*/
fn rich_write_genbank(records: RichRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        let error = validate_rich_record(copy(r));
        let selected = rich_sequence_slice(copy(r), 0, r.length);
        if r.tracks.len > 0 || (r.segments.len > 0 && selected.error.len > 0) { return FormatTextResult { "", "tracks or partial sequence cannot be represented" }; }
        let sequence = selected.value;
        if error.len > 0 || !rich_io_token(r.id) { return FormatTextResult { "", "invalid annotated record" }; }
        var headers: u8[][>..] = [];
        for q in r.metadata {
            if q.key != "genbank_header" { return FormatTextResult { "", "unsupported metadata key" }; }
            headers.append(q.values);
        }
        var division: u8[>..] = []; division.append("UNK"); var date: u8[>..] = []; date.append("01-JAN-1980");
        for h, i in headers { if i == 0 && starts_with(h, "LOCUS ") {
            var tokens: u8[][>..] = [];
            for t in split(h, ' ') { if t.len > 0 { tokens.push(str(t)); } }
            if tokens.len != 8 { return FormatTextResult { "", "unsupported LOCUS metadata" }; }
            for t, j in tokens { if j == 6 { division.clear(); division.append(t); } if j == 7 { date.clear(); date.append(t); } }
        } }
        if r.id.len > 16 { return FormatTextResult { "", "LOCUS name too long" }; }
        out.append("LOCUS       "); out.append(r.id);
        for i in 16 - r.id.len { out.push(' '); }
        let size = str(r.length);
        if size.len > 11 { return FormatTextResult { "", "LOCUS length too large" }; }
        for i in 12 - size.len { out.push(' '); } out.append(size);
        out.append(if r.rna { " bp    RNA     " } else { " bp    DNA     " });
        out.append(if r.topology == 1 { "circular " } else { "linear   " });
        out.append(division); out.push(' '); out.append(date); out.push('\n');
        for h, i in headers {
            if i == 0 && starts_with(h, "LOCUS ") { continue; }
            for c in h { if c < 32 || c > 126 { return FormatTextResult { "", "invalid raw header byte" }; } }
            if h.len < 12 || starts_with(h, "LOCUS") || starts_with(h, "FEATURES") || starts_with(h, "ORIGIN") || starts_with(h, "DEFINITION") || starts_with(h, "//") { return FormatTextResult { "", "reserved raw header" }; }
            out.append(h); out.push('\n');
        }
        for c in r.description { if c < 32 || c > 126 { return FormatTextResult { "", "invalid description byte" }; } }
        if r.description.len > 0 { out.append("DEFINITION  "); out.append(r.description); out.push('\n'); }
        out.append("FEATURES             Location/Qualifiers\n");
        for f in r.features {
            if !rich_io_token(f.kind) || f.kind.len > 15 { return FormatTextResult { "", "invalid feature key" }; }
            out.append("     "); out.append(f.kind);
            for i in 16 - f.kind.len { out.push(' '); }
            if f.parts.len > 1 { out.append("join("); }
            for p, i in f.parts {
                if i > 0 { out.push(','); }
                if p.strand == -1 { out.append("complement("); }
                if p.start.kind == 3 || p.end.kind == 3 || p.start.value == p.end.value { return FormatTextResult { "", "unsupported output position" }; }
                out.append(rich_position_text(copy(p.start), true));
                out.append(".."); out.append(rich_position_text(copy(p.end), false));
                if p.strand == -1 { out.push(')'); }
            }
            if f.parts.len > 1 { out.push(')'); } out.push('\n');
            for q in f.qualifiers {
                if !rich_io_token(q.key) { return FormatTextResult { "", "invalid qualifier key" }; }
                if q.values.len == 0 { out.append("                     /"); out.append(q.key); out.push('\n'); }
                for v in q.values {
                    out.append("                     /"); out.append(q.key); out.append("=\"");
                    for c in v {
                        if c < 32 || c > 126 { return FormatTextResult { "", "invalid qualifier byte" }; }
                        out.push(c); if c == '"' { out.push(c); }
                    }
                    out.append("\"\n");
                }
            }
        }
        out.append("ORIGIN\n");
        for c, i in sequence {
            if i % 60 == 0 { out.append("        "); out.append(str(i + 1)); }
            if i % 10 == 0 { out.push(' '); }
            out.push(c);
            if (i + 1) % 60 == 0 || i + 1 == sequence.len { out.push('\n'); }
        }
        out.append("//\n");
    }
    // Reparse to reject raw-header injection and stale LOCUS metadata.
    let parsed = rich_parse_genbank(out);
    if parsed.error.len > 0 || parsed.records.len != records.len { return FormatTextResult { "", "invalid or stale GenBank headers" }; }
    for r, i in records {
        for p, j in parsed.records {
            if i != j { continue; }
            if p.id != r.id || p.description != r.description || p.rna != r.rna || p.features.len != r.features.len {
                return FormatTextResult { "", "header changes record semantics" };
            }
        }
    }
    return FormatTextResult { copy(out), "" };
}

/*
Requires seven ID fields; GenBank requires seven standard LOCUS values and DNA/RNA.
Other header shapes fail. Ordered opaque lines use embl_header/genbank_header. Strict
adapters remain separate; no full INSDC claim.
*/
fn rich_parse_embl(text: u8[:]) -> RichRecordsResult {
    var result:          RichRecord[>..] = [];
    var gb:              u8[>..]         = []; var headers: u8[][>..] = [];
    var declared_length: i64             = 0;
    var description_seen = false;
    var active = false; var sequence = false; var features = false;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if !active {
            if !starts_with(line, "ID   ") { return RichRecordsResult { [], "expected EMBL ID" }; }
            let fields = split(line[5..], ';');
            if fields.len != 7 { return RichRecordsResult { [], "expected seven EMBL ID fields" }; }
            let id = trim(fields[0]); let molecule = trim(fields[3]);
            let size = trim(fields[6]);
            if !ends_with(size, " BP.") || (molecule != "genomic DNA" && molecule != "DNA" && molecule != "RNA") { return RichRecordsResult { [], "unsupported EMBL molecule or size" }; }
            let size_number, size_ok = parse_int(size[..size.len - 4]);
            if !size_ok || size_number < 0 { return RichRecordsResult { [], "invalid EMBL ID length" }; }
            declared_length = size_number;
            gb.clear(); gb.append("LOCUS       "); gb.append(id); gb.push(' '); gb.append(size[..size.len - 4]);
            gb.append(if molecule == "RNA" { " bp RNA " } else { " bp DNA " });
            let topology = trim(fields[2]);
            if topology != "linear" && topology != "circular" { return RichRecordsResult { [], "unsupported topology" }; }
            gb.append(topology); gb.append(" UNK 01-JAN-1980\n");
            description_seen = false; headers.clear(); headers.push(str(line)); active = true; sequence = false; features = false;
        } else if line == "//" {
            if !sequence { return RichRecordsResult { [], "missing SQ" }; }
            gb.append("//\n"); let parsed = rich_parse_genbank(gb);
            if parsed.error.len > 0 || parsed.records.len != 1 { return RichRecordsResult { [], copy(parsed.error) }; }
            for r in parsed.records { result.push(RichRecord { copy(r.id), copy(r.description), r.length, copy(r.segments), [FeatureQualifier { "embl_header", copy(headers) }], copy(r.features), [], r.rna, r.topology }); }
            active = false;
        } else if starts_with(line, "SQ   ") && !sequence {
            if trim(line).len == 2 { gb.append("ORIGIN\n"); sequence = true; continue; }
            let sq = split(line[5..], ';');
            if sq.len < 2 { return RichRecordsResult { [], "malformed EMBL SQ summary" }; }
            let summary = trim(sq[0]);
            if summary.len < 13 || !starts_with(summary, "Sequence ") || !ends_with(summary, " BP") { return RichRecordsResult { [], "malformed EMBL SQ length" }; }
            let sq_length, sq_ok = parse_int(summary[9..summary.len - 3]);
            if !sq_ok || sq_length != declared_length { return RichRecordsResult { [], "EMBL SQ and ID lengths differ" }; }
            gb.append("ORIGIN\n"); sequence = true;
        } else if sequence {
            if starts_with(line, "SQ") { return RichRecordsResult { [], "duplicate EMBL SQ" }; }
            gb.append(line); gb.push('\n');
        } else if starts_with(line, "FT   ") {
            if !features { gb.append("FEATURES             Location/Qualifiers\n"); features = true; }
            gb.append("     "); gb.append(line[5..]); gb.push('\n');
        } else if starts_with(line, "FH   ") || line == "FH" || line == "XX" { continue;
        } else {
            if features || line.len < 5 || line[2..5] != "   " || starts_with(line, "ID") { return RichRecordsResult { [], "invalid EMBL header order" }; }
            if starts_with(line, "DE   ") { gb.append(if description_seen { "            " } else { "DEFINITION  " }); gb.append(line[5..]); gb.push('\n'); description_seen = true; }
            else { headers.push(str(line)); }
        }
    }
    if active { return RichRecordsResult { [], "truncated EMBL" }; }
    return RichRecordsResult { copy(result), "" };
}
/* Regenerates identifier/length/molecule/topology and retains EMBL version/class/division. Rejects
 * GenBank raw headers and the same unsupported content as rich_write_genbank. Header layout is
 * canonical; qualifier occurrence order remains stored. */
fn rich_write_embl(records: RichRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        let selected = rich_sequence_slice(copy(r), 0, r.length);
        var headers: u8[][>..] = [];
        for q in r.metadata {
            if q.key != "embl_header" { return FormatTextResult { "", "unsupported EMBL metadata" }; }
            headers.append(q.values);
        }
        out.append("ID   "); out.append(r.id);
        var sv: u8[>..] = []; sv.append("SV 1"); var cls: u8[>..] = []; cls.append("STD"); var div: u8[>..] = []; div.append("UNC");
        for h, i in headers { if i == 0 && starts_with(h, "ID   ") {
            for field, j in split(h[5..], ';') { if j == 1 { sv.clear(); sv.append(trim(field)); } if j == 4 { cls.clear(); cls.append(trim(field)); } if j == 5 { div.clear(); div.append(trim(field)); } }
        } }
        out.append("; "); out.append(sv); out.append("; ");
        out.append(if r.topology == 1 { "circular; " } else { "linear; " });
        out.append(if r.rna { "RNA" } else { "genomic DNA" });
        out.append("; "); out.append(cls); out.append("; "); out.append(div); out.append("; "); out.append(str(r.length)); out.append(" BP.\n");
        for h, i in headers {
            if i == 0 && starts_with(h, "ID   ") { continue; }
            for c in h { if c < 32 || c > 126 { return FormatTextResult { "", "invalid header byte" }; } }
            if h.len < 5 || h[2..5] != "   " || starts_with(h, "ID") || starts_with(h, "DE") || starts_with(h, "FT") || starts_with(h, "SQ") || starts_with(h, "FH") { return FormatTextResult { "", "reserved EMBL header" }; }
            out.append(h); out.push('\n');
        }
        let plain = [RichRecord { copy(r.id), copy(r.description), r.length, copy(r.segments), [], copy(r.features), copy(r.tracks), r.rna, r.topology }];
        let encoded = rich_write_genbank(plain);
        if encoded.error.len > 0 { return copy(encoded); }
        var state = 0;
        for line in split(encoded.text, '\n') {
            if starts_with(line, "DEFINITION  ") { out.append("DE   "); out.append(line[12..]); out.push('\n'); }
            else if starts_with(line, "FEATURES ") { state = 1; out.append("FH   Key             Location/Qualifiers\nFH\n"); }
            else if line == "ORIGIN" { state = 2; out.append("SQ   Sequence "); out.append(str(r.length)); out.append(" BP;\n"); }
            else if line == "//" {
                for c, i in selected.value {
                    if i % 60 == 0 { out.append("     "); }
                    out.push(c);
                    if (i + 1) % 10 == 0 { out.push(' '); }
                    if (i + 1) % 60 == 0 || i + 1 == selected.value.len { out.push(' '); out.append(str(i + 1)); out.push('\n'); }
                }
                out.append("//\n");
            }
            else if state == 1 { out.append("FT   "); out.append(line[5..]); out.push('\n'); }
        }
    }
    let parsed = rich_parse_embl(out);
    if parsed.error.len > 0 || parsed.records.len != records.len { return FormatTextResult { "", "invalid or stale EMBL headers" }; }
    for r, i in records { for p, j in parsed.records { if i == j && (r.id != p.id || r.rna != p.rna || r.description != p.description) { return FormatTextResult { "", "EMBL header changes semantics" }; } } }
    return FormatTextResult { copy(out), "" };
}
