// Exact nucleotide EMBL subset. Raw headers retain order and bytes.
namespace bio;
import std;
import .genbank;

/*
Accepts modern seven-field nucleotide ID lines, DNA/RNA, and uppercase- normalized
sequence. One SQ line must contain Sequence <integer> BP; and match both ID and actual
lengths. Missing, malformed, or duplicate SQ fails; optional composition fields are not
retained.
*/
/*
Rejects proteins, fuzzy/remote/between-base/order locations, multiline DE, and multiline
qualifiers. Exact parts use zero-based half-open coordinates in extraction order; DE
becomes description.
*/
fn parse_embl(text: u8[:]) -> AnnotatedRecordsResult {
    var result:          AnnotatedRecord[>..] = [];
    var gb:              u8[>..]              = []; var headers: u8[][>..] = [];
    var declared_length: i64                  = 0;
    var active = false; var sequence = false; var features = false;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if !active {
            if !starts_with(line, "ID   ") { return AnnotatedRecordsResult { [], "expected EMBL ID" }; }
            let fields = split(line[5..], ';');
            if fields.len != 7 { return AnnotatedRecordsResult { [], "expected seven EMBL ID fields" }; }
            let id = trim(fields[0]); let molecule = trim(fields[3]);
            let size = trim(fields[6]);
            if !ends_with(size, " BP.") || (molecule != "genomic DNA" && molecule != "DNA" && molecule != "RNA") { return AnnotatedRecordsResult { [], "unsupported EMBL molecule or size" }; }
            let size_number, size_ok = parse_int(size[..size.len - 4]);
            if !size_ok || size_number < 0 { return AnnotatedRecordsResult { [], "invalid EMBL ID length" }; }
            declared_length = size_number;
            gb.clear(); gb.append("LOCUS       "); gb.append(id); gb.push(' '); gb.append(size[..size.len - 4]);
            gb.append(if molecule == "RNA" { " bp RNA\n" } else { " bp DNA\n" });
            headers.clear(); headers.push(str(line)); active = true; sequence = false; features = false;
        } else if line == "//" {
            if !sequence { return AnnotatedRecordsResult { [], "missing SQ" }; }
            gb.append("//\n"); let parsed = parse_genbank(gb);
            if parsed.error.len > 0 || parsed.records.len != 1 { return AnnotatedRecordsResult { [], copy(parsed.error) }; }
            for r in parsed.records { result.push(AnnotatedRecord { copy(r.id), copy(r.description), copy(r.sequence), [FeatureQualifier { "embl_header", copy(headers) }], copy(r.features), r.rna }); }
            active = false;
        } else if starts_with(line, "SQ   ") && !sequence {
            let sq = split(line[5..], ';');
            if sq.len < 2 { return AnnotatedRecordsResult { [], "malformed EMBL SQ summary" }; }
            let summary = trim(sq[0]);
            if summary.len < 13 || !starts_with(summary, "Sequence ") || !ends_with(summary, " BP") { return AnnotatedRecordsResult { [], "malformed EMBL SQ length" }; }
            let sq_length, sq_ok = parse_int(summary[9..summary.len - 3]);
            if !sq_ok || sq_length != declared_length { return AnnotatedRecordsResult { [], "EMBL SQ and ID lengths differ" }; }
            gb.append("ORIGIN\n"); sequence = true;
        } else if sequence {
            if starts_with(line, "SQ") { return AnnotatedRecordsResult { [], "duplicate EMBL SQ" }; }
            gb.append(line); gb.push('\n');
        } else if starts_with(line, "FT   ") {
            if !features { gb.append("FEATURES             Location/Qualifiers\n"); features = true; }
            gb.append("     "); gb.append(line[5..]); gb.push('\n');
        } else if starts_with(line, "FH   ") || line == "FH" || line == "XX" { continue;
        } else {
            if features || line.len < 5 || line[2..5] != "   " || starts_with(line, "ID") { return AnnotatedRecordsResult { [], "invalid EMBL header order" }; }
            if starts_with(line, "DE   ") { gb.append("DEFINITION  "); gb.append(line[5..]); gb.push('\n'); }
            else { headers.push(str(line)); }
        }
    }
    if active { return AnnotatedRecordsResult { [], "truncated EMBL" }; }
    return AnnotatedRecordsResult { copy(result), "" };
}
/*
embl_header retains opaque header order/bytes, including raw ID. Update ID yourself
after identifier, molecule, or length changes; embedded header coordinates can become
stale. Output uses canonical FH/XX, SQ length, and exact feature layout.
*/
fn write_embl(records: AnnotatedRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        var headers: u8[][>..] = [];
        for q in r.metadata {
            if q.key != "embl_header" { return FormatTextResult { "", "unsupported EMBL metadata" }; }
            headers.append(q.values);
        }
        if headers.len == 0 {
            out.append("ID   "); out.append(r.id); out.append("; SV 1; linear; ");
            out.append(if r.rna { "RNA" } else { "genomic DNA" });
            out.append("; STD; UNC; "); out.append(str(r.sequence.len)); out.append(" BP.\n");
        } else { for h, i in headers {
            if (i == 0 && !starts_with(h, "ID   ")) || (i > 0 && (h.len < 5 || h[2..5] != "   " || starts_with(h, "ID") || starts_with(h, "DE") || starts_with(h, "FT") || starts_with(h, "FH") || starts_with(h, "SQ"))) { return FormatTextResult { "", "reserved or malformed EMBL raw header" }; }
            for c in h { if c < 32 || c > 126 { return FormatTextResult { "", "invalid raw EMBL header" }; } } out.append(h); out.push('\n'); } }
        let plain = [AnnotatedRecord { copy(r.id), copy(r.description), copy(r.sequence), [], copy(r.features), r.rna }];
        let encoded = write_genbank(plain);
        if encoded.error.len > 0 { return copy(encoded); }
        var state = 0;
        for line in split(encoded.text, '\n') {
            if starts_with(line, "DEFINITION  ") { out.append("DE   "); out.append(line[12..]); out.push('\n'); }
            else if starts_with(line, "FEATURES ") { state = 1; out.append("FH   Key             Location/Qualifiers\nFH\n"); }
            else if line == "ORIGIN" { state = 2; out.append("SQ   Sequence "); out.append(str(r.sequence.len)); out.append(" BP;\n"); }
            else if line == "//" {
                for c, i in r.sequence {
                    if i % 60 == 0 { out.append("     "); }
                    out.push(c);
                    if (i + 1) % 10 == 0 { out.push(' '); }
                    if (i + 1) % 60 == 0 || i + 1 == r.sequence.len { out.push(' '); out.append(str(i + 1)); out.push('\n'); }
                }
                out.append("//\n");
            }
            else if state == 1 { out.append("FT   "); out.append(line[5..]); out.push('\n'); }
        }
    }
    let parsed = parse_embl(out);
    if parsed.error.len > 0 || parsed.records.len != records.len { return FormatTextResult { "", "invalid or stale EMBL headers" }; }
    for r, i in records { for p, j in parsed.records { if i == j && (r.id != p.id || r.rna != p.rna || r.description != p.description) { return FormatTextResult { "", "EMBL header changes semantics" }; } } }
    return FormatTextResult { copy(out), "" };
}
