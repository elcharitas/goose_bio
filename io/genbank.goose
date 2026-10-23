// Strict exact-location GenBank subset; unsupported fields fail explicitly.
// id maps to LOCUS name, not the accession or version identifier.
// ACCESSION and VERSION remain distinct raw genbank_header lines.
// No fuzzy, remote, between-base, order(), or multiline qualifiers.
// Sequences normalize to uppercase; layout is canonical, not byte exact.
// Multiline DEFINITION is rejected; other header lines remain opaque.
// Import bio.io.genbank explicitly; APIs consume and return whole text.
namespace bio;
import std;
import sequence.annotations;
import .formats;

struct AnnotatedRecordsResult { records: AnnotatedRecord[], error: u8[] }
struct GenbankLocationResult { parts: LocationPart[], error: u8[] }

recursive fn genbank_location_parts(text: u8[:], parts: LocationPart[>..]&, depth: i64) -> bool {
    if depth > 64 || text.len == 0 { return false; }
    if starts_with(text, "complement(") && text[text.len-1] == ')' {
        let begin = parts.len;
        if !genbank_location_parts(text[11..text.len-1], parts, depth+1) { return false; }
        let count = parts.len-begin;
        for i in (count+1)/2 {
            let a = parts[begin+i]; let b = parts[begin+count-1-i];
            parts[begin+i] = LocationPart { b.start, b.end, -b.strand, false };
            parts[begin+count-1-i] = LocationPart { a.start, a.end, -a.strand, false };
        }
        return true;
    }
    if starts_with(text, "join(") && text[text.len-1] == ')' {
        var level = 0; var begin = 5;
        for i in text.len {
            if i < 5 || i == text.len-1 { continue; }
            if text[i] == '(' { level += 1; }
            if text[i] == ')' { level -= 1; }
            if level < 0 { return false; }
            if text[i] == ',' && level == 0 {
                if !genbank_location_parts(text[begin..i], parts, depth+1) { return false; }
                begin = i+1;
            }
        }
        if level != 0 { return false; }
        return genbank_location_parts(text[begin..text.len-1], parts, depth+1);
    }
    var dot = -1;
    for c, i in text {
        if c == '.' { if dot == -1 { dot = i; } }
        else if c < '0' || c > '9' { return false; }
    }
    let first, ok = parse_int(if dot < 0 { text } else { text[..dot] });
    let last, end_ok = parse_int(if dot < 0 { text } else if dot+2 <= text.len { text[dot+2..] } else { "" });
    if !ok || !end_ok || first < 1 || last < first || (dot >= 0 && (dot+1 >= text.len || text[dot+1] != '.')) { return false; }
    parts.push(LocationPart { first-1, last, 1, false }); return true;
}
fn genbank_location(text: u8[:]) -> GenbankLocationResult {
    var parts: LocationPart[>..] = [];
    if !genbank_location_parts(text, parts, 0) { return GenbankLocationResult { [], "unsupported or invalid exact location" }; }
    return GenbankLocationResult { copy(parts), "" };
}

fn genbank_token(text: u8[:]) -> bool {
    if text.len == 0 { return false; }
    for c in text { if c <= 32 || c > 126 || c == '=' || c == '"' { return false; } }
    return true;
}

fn parse_genbank(text: u8[:]) -> AnnotatedRecordsResult {
    var records: AnnotatedRecord[>..] = [];
    var id: u8[>..] = []; var description: u8[>..] = [];
    var headers: u8[][>..] = []; var sequence: u8[>..] = [];
    var features: AnnotatedFeature[>..] = [];
    var kind: u8[>..] = []; var location: u8[>..] = [];
    var qualifiers: FeatureQualifier[>..] = [];
    var definition = false; var definition_seen = false;
    var state = 0; var length = 0; var rna = false;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if starts_with(line, "LOCUS ") && state == 0 {
            let words = split(trim(line[5..]), ' ');
            var tokens: u8[][>..] = [];
            for w in words { if w.len > 0 { tokens.push(str(w)); } }
            var name: u8[>..] = []; var size: u8[>..] = []; var unit: u8[>..] = [];
            for t, i in tokens { if i == 0 { name.clear(); name.append(t); } if i == 1 { size.clear(); size.append(t); } if i == 2 { unit.clear(); unit.append(t); } }
            if tokens.len < 3 || unit != "bp" { return AnnotatedRecordsResult { [], "unsupported LOCUS" }; }
            let n, ok = parse_int(size);
            if !ok || n <= 0 { return AnnotatedRecordsResult { [], "invalid LOCUS length" }; }
            id.clear(); id.append(name); length = n; rna = false;
            for t in tokens { if t == "RNA" || t == "mRNA" || t == "rRNA" || t == "tRNA" { rna = true; } }
            headers.clear(); headers.push(str(line)); sequence.clear(); features.clear();
            kind.clear(); location.clear(); qualifiers.clear(); description.clear(); definition = false; definition_seen = false; state = 1;
        } else if line == "//" && state == 3 {
            let normalized = normalize_sequence(sequence, rna);
            if sequence.len != length || normalized.error.len > 0 { return AnnotatedRecordsResult { [], "invalid sequence or LOCUS length mismatch" }; }
            let record = AnnotatedRecord { copy(id), copy(description), copy(normalized.value),
                [FeatureQualifier { "genbank_header", copy(headers) }], copy(features), rna };
            let error = validate_annotated_record(copy(record));
            if error.len > 0 { return AnnotatedRecordsResult { [], copy(error) }; }
            records.push(copy(record)); state = 0;
        } else if starts_with(line, "FEATURES ") && state == 1 { state = 2;
        } else if line == "ORIGIN" || starts_with(line, "ORIGIN ") {
            if state != 1 && state != 2 { return AnnotatedRecordsResult { [], "unexpected ORIGIN" }; }
            if kind.len > 0 {
                let loc = genbank_location(location);
                if loc.error.len > 0 { return AnnotatedRecordsResult { [], copy(loc.error) }; }
                features.push(AnnotatedFeature { copy(kind), copy(loc.parts), copy(qualifiers) });
            }
            state = 3;
        } else if state == 1 {
            if starts_with(line, "DEFINITION ") {
                if definition_seen { return AnnotatedRecordsResult { [], "duplicate DEFINITION" }; }
                if line.len < 12 { return AnnotatedRecordsResult { [], "short DEFINITION" }; }
                definition_seen = true;
                description.clear(); description.append(trim(line[12..])); definition = true;
            } else {
                if line.len < 12 { return AnnotatedRecordsResult { [], "short header" }; }
                if definition && starts_with(line, "            ") { return AnnotatedRecordsResult { [], "multiline DEFINITION unsupported" }; }
                definition = false; headers.push(str(line));
            }
        } else if state == 2 {
            if line.len < 21 || line[..5] != "     " { return AnnotatedRecordsResult { [], "invalid feature line" }; }
            let name = trim(line[5..21]); let value = trim(line[21..]);
            if name.len > 0 {
                if kind.len > 0 {
                    let loc = genbank_location(location);
                    if loc.error.len > 0 { return AnnotatedRecordsResult { [], copy(loc.error) }; }
                    features.push(AnnotatedFeature { copy(kind), copy(loc.parts), copy(qualifiers) });
                }
                if !genbank_token(name) { return AnnotatedRecordsResult { [], "invalid feature key" }; }
                kind.clear(); kind.append(name); location.clear(); location.append(value); qualifiers.clear();
            } else if value.len > 0 && value[0] == '/' {
                if kind.len == 0 { return AnnotatedRecordsResult { [], "qualifier without feature" }; }
                var eq = -1;
                for c, i in value { if c == '=' && eq < 0 { eq = i; } }
                let key = if eq < 0 { value[1..] } else { value[1..eq] };
                if !genbank_token(key) { return AnnotatedRecordsResult { [], "invalid qualifier key" }; }
                if eq < 0 { qualifiers.push(FeatureQualifier { str(key), [] }); }
                else {
                    let v = value[eq+1..];
                    if v.len == 0 { return AnnotatedRecordsResult { [], "empty unquoted qualifier" }; }
                    var decoded: u8[>..] = [];
                    if v[0] == '"' {
                        if v.len < 2 || v[v.len-1] != '"' { return AnnotatedRecordsResult { [], "multiline qualifier unsupported" }; }
                        var i = 1;
                        while i < v.len-1 {
                            if v[i] == '"' {
                                if i+1 >= v.len-1 || v[i+1] != '"' { return AnnotatedRecordsResult { [], "invalid quoted qualifier" }; }
                                i += 1;
                            }
                            decoded.push(v[i]); i += 1;
                        }
                    } else { decoded.append(v); }
                    qualifiers.push(FeatureQualifier { str(key), [copy(decoded)] });
                }
            } else {
                if qualifiers.len > 0 || kind.len == 0 { return AnnotatedRecordsResult { [], "multiline qualifier unsupported" }; }
                location.append(value);
            }
        } else if state == 3 {
            for c in line {
                if c == ' ' || c == '\t' || (c >= '0' && c <= '9') { continue; }
                sequence.push(c);
            }
        } else { return AnnotatedRecordsResult { [], "expected LOCUS or terminator" }; }
    }
    if state != 0 { return AnnotatedRecordsResult { [], "truncated GenBank record" }; }
    return AnnotatedRecordsResult { copy(records), "" };
}

// Canonical joins retain extraction order and each part's strand.
fn write_genbank(records: AnnotatedRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        let error = validate_annotated_record(copy(r));
        if error.len > 0 || !genbank_token(r.id) || r.sequence.len == 0 { return FormatTextResult { "", "invalid annotated record" }; }
        var headers: u8[][>..] = [];
        for q in r.metadata {
            if q.key != "genbank_header" { return FormatTextResult { "", "unsupported metadata key" }; }
            headers.append(q.values);
        }
        if headers.len > 0 {
            for h, i in headers {
                for c in h { if c < 32 || c > 126 { return FormatTextResult { "", "invalid raw header byte" }; } }
                if (i == 0 && !starts_with(h, "LOCUS ")) || (i > 0 && starts_with(h, "LOCUS ")) || starts_with(h, "FEATURES") || starts_with(h, "ORIGIN") || starts_with(h, "DEFINITION") || starts_with(h, "//") {
                    return FormatTextResult { "", "invalid raw header field" };
                }
                out.append(h); out.push('\n');
            }
        } else {
            out.append("LOCUS       "); out.append(r.id); out.push(' '); out.append(str(r.sequence.len));
            out.append(if r.rna { " bp RNA\n" } else { " bp DNA\n" });
        }
        for c in r.description { if c < 32 || c > 126 { return FormatTextResult { "", "invalid description byte" }; } }
        if r.description.len > 0 { out.append("DEFINITION  "); out.append(r.description); out.push('\n'); }
        out.append("FEATURES             Location/Qualifiers\n");
        for f in r.features {
            if !genbank_token(f.kind) || f.kind.len > 15 { return FormatTextResult { "", "invalid feature key" }; }
            out.append("     "); out.append(f.kind);
            for i in 16-f.kind.len { out.push(' '); }
            if f.parts.len > 1 { out.append("join("); }
            for p, i in f.parts {
                if i > 0 { out.push(','); }
                if p.strand == -1 { out.append("complement("); }
                out.append(str(p.start+1));
                if p.end != p.start+1 { out.append(".."); out.append(str(p.end)); }
                if p.strand == -1 { out.push(')'); }
            }
            if f.parts.len > 1 { out.push(')'); } out.push('\n');
            for q in f.qualifiers {
                if !genbank_token(q.key) { return FormatTextResult { "", "invalid qualifier key" }; }
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
        for c, i in r.sequence {
            if i % 60 == 0 { out.append("        "); out.append(str(i+1)); }
            if i % 10 == 0 { out.push(' '); }
            out.push(c);
            if (i+1) % 60 == 0 || i+1 == r.sequence.len { out.push('\n'); }
        }
        out.append("//\n");
    }
    // Reparse to reject raw-header injection and stale LOCUS metadata.
    let parsed = parse_genbank(out);
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
