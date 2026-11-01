// BLAST outfmt 6 default twelve columns, nucleotide strand convention.
// Protein callers must interpret strand fields as coordinate direction.
namespace bio;
import std;
import .formats;
/*
Retains IDs, identity, column/mismatch/gap-open counts, f64 scores, and zero-based half-open
ranges. Direction is strand, including +1 for equal endpoints. Protein/translated
meaning requires caller knowledge; frames are not inferred.
*/
struct BlastHsp {
    query_id:         u8[], hit_id: u8[], identity: f64,
    alignment_length: i64, mismatches: i64, gap_opens: i64,
    query_start:      i64, query_end: i64, query_strand: i64,
    hit_start:        i64, hit_end: i64, hit_strand: i64,
    evalue:           f64, bitscore: f64,
}
struct BlastHit { id: u8[], hsps: BlastHsp[] }
struct BlastQuery { id: u8[], hits: BlastHit[] }
struct BlastSearchResult { queries: BlastQuery[], error: u8[] }
/*
Strict default twelve-column tab-separated outfmt 6; empty input succeeds.
Comments/outfmt 7, custom schemas, XML, text BLAST, HMMER, PSL, and Exonerate fail here.
Queries/hits merge noncontiguous rows in first occurrence order; HSP order survives.
*/
/*
Mismatch plus gap opens must fit columns; identity permits a gap column per opening and
agrees with mismatches when ungapped. Tolerance is half the last displayed decimal unit,
at least 0.0005 percentage points; rounded 100% may coexist with differences. Translated
coordinate units do not constrain columns; gap lengths/frames are unavailable.
*/
fn parse_blast_tab(text: u8[:]) -> BlastSearchResult {
    var hsps: BlastHsp[>..] = []; var query_ids: u8[][>..] = [];
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if line[0] == '#' { return BlastSearchResult { [], "commented/custom BLAST columns unsupported" }; }
        let f = split(line, '\t');
        if f.len != 12 { return BlastSearchResult { [], "expected twelve tab-separated BLAST columns" }; }
        if f[0].len == 0 || f[1].len == 0 { return BlastSearchResult { [], "empty BLAST identifier" }; }
        for id in [f[0], f[1]] { for c in id { if c <= 32 || c > 126 { return BlastSearchResult { [], "invalid BLAST identifier" }; } } }
        let identity, p_ok = parse_flt(f[2]); let length, l_ok = parse_int(f[3]);
        let mismatch, m_ok = parse_int(f[4]); let gaps, g_ok = parse_int(f[5]);
        let qs, qs_ok = parse_int(f[6]); let qe, qe_ok = parse_int(f[7]);
        let hs, hs_ok = parse_int(f[8]); let he, he_ok = parse_int(f[9]);
        let evalue, e_ok = parse_flt(f[10]); let bits, b_ok = parse_flt(f[11]);
        if !p_ok || !l_ok || !m_ok || !g_ok || !qs_ok || !qe_ok || !hs_ok || !he_ok || !e_ok || !b_ok { return BlastSearchResult { [], "invalid BLAST numeric field" }; }
        if !(identity >= 0.0 && identity <= 100.0) || length <= 0 || mismatch < 0 || mismatch > length || gaps < 0 || gaps > length || qs <= 0 || qe <= 0 || hs <= 0 || he <= 0 || !(evalue >= 0.0 && evalue <= 1.7976931348623157e308) || !(bits >= 0.0 && bits <= 1.7976931348623157e308) { return BlastSearchResult { [], "BLAST numeric field outside range" }; }
        // Default BLAST prints three decimals; coarser input stays valid.
        var tolerance = 0.5; var decimal = false;
        for c in f[2] {
            if c == '.' { decimal = true; }
            else if decimal && c >= '0' && c <= '9' { tolerance /= 10.0; }
        }
        tolerance = max(tolerance, 0.0005);
        let low = max(0.0, identity - tolerance);
        let high = min(100.0, identity + tolerance);
        if gaps > length - mismatch { return BlastSearchResult { [], "inconsistent BLAST counts" }; }
        let available = (length - mismatch - gaps) * 100.0 / length;
        if low > available + 0.0000001 { return BlastSearchResult { [], "inconsistent BLAST identity and counts" }; }
        if gaps == 0 && high + 0.0000001 < available { return BlastSearchResult { [], "inconsistent ungapped BLAST identity" }; }
        hsps.push(BlastHsp { str(f[0]), str(f[1]), identity, length, mismatch, gaps,
            min(qs, qe) - 1, max(qs, qe), if qs <= qe { 1 } else { -1 },
            min(hs, he) - 1, max(hs, he), if hs <= he { 1 } else { -1 }, evalue, bits });
        var seen = false; for id in query_ids { if id == f[0] { seen = true; } }
        if !seen { query_ids.push(str(f[0])); }
    }
    var queries: BlastQuery[>..] = [];
    for q in query_ids {
        var hit_ids: u8[][>..] = [];
        for h in hsps { if h.query_id == q {
            var seen = false; for id in hit_ids { if id == h.hit_id { seen = true; } }
            if !seen { hit_ids.push(copy(h.hit_id)); }
        } }
        var hits: BlastHit[>..] = [];
        for id in hit_ids {
            var group: BlastHsp[>..] = [];
            for h in hsps { if h.query_id == q && h.hit_id == id { group.push(copy(h)); } }
            hits.push(BlastHit { copy(id), copy(group) });
        }
        queries.push(BlastQuery { copy(q), copy(hits) });
    }
    return BlastSearchResult { copy(queries), "" };
}

// Configurable tabular records retain only explicitly supplied fields.
/*
Lists exact columns/order and each side’s nucleotide, protein, or translated unit.
Ranges are zero-based half-open; translated positions are nucleotide but aligned strings
amino acid. Protein strand is zero; frames stay explicit columns.
*/
/*
Columns: qseqid/sseqid, pident, length, mismatch, gapopen, qstart/qend, sstart/send,
evalue, bitscore, qlen/slen, qframe/sframe, qseq/sseq, score, nident, positive, gaps,
ppos. Others fail.
*/
struct BlastSchema { fields: u8[][], query_unit: u8[], hit_unit: u8[] }
struct BlastRow { values: u8[][] }
struct BlastBlock { id: u8[], description: u8[], fields_declared: bool, rows: BlastRow[] }
/*
Retains query blocks/descriptions, repeated hit rows, zero-hit queries, field-
declaration presence, and original row order. Configurable tables do not merge
nonadjacent queries/hits. Structs require valid caller construction; buffering/copying
has no streaming/index API or full SearchIO claim.
*/
struct BlastTable { schema: BlastSchema, queries: BlastBlock[], error: u8[] }
struct BlastValue { present: bool, text: u8[] }
struct BlastRange { present: bool, start: i64, end: i64, strand: i64, unit: u8[] }
struct BlastText { text: u8[], error: u8[] }
fn blast_label(field: u8[:]) -> u8[] {
    if field == "qseqid" { return "query id"; }
    if field == "sseqid" { return "subject id"; }
    if field == "pident" { return "% identity"; }
    if field == "length" { return "alignment length"; }
    if field == "mismatch" { return "mismatches"; }
    if field == "gapopen" { return "gap opens"; }
    if field == "qstart" { return "q. start"; }
    if field == "qend" { return "q. end"; }
    if field == "sstart" { return "s. start"; }
    if field == "send" { return "s. end"; }
    if field == "evalue" { return "evalue"; }
    if field == "bitscore" { return "bit score"; }
    if field == "qlen" { return "query length"; }
    if field == "slen" { return "subject length"; }
    if field == "qframe" { return "query frame"; }
    if field == "sframe" { return "sbjct frame"; }
    if field == "qseq" { return "query seq"; }
    if field == "sseq" { return "subject seq"; }
    if field == "score" { return "score"; }
    if field == "nident" { return "identical"; }
    if field == "positive" { return "positives"; }
    if field == "gaps" { return "gaps"; }
    if field == "ppos" { return "% positives"; }
    return "";
}
/*
Returns preserved column text; present=false differs from explicit zero.
*/
fn blast_value(row: BlastRow, schema: BlastSchema, field: u8[:]) -> BlastValue {
    for i in 0..schema.fields.len {
        if blast_at(copy(schema.fields), i) == field && i < row.values.len {
            return BlastValue { true, blast_at(copy(row.values), i) };
        }
    }
    return BlastValue { false, "" };
}
/*
Normalizes coordinates according to explicit schema units; it does not infer frames.
*/
fn blast_range(row: BlastRow, schema: BlastSchema, query: bool) -> BlastRange {
    let a = blast_value(copy(row), copy(schema), if query { "qstart" } else { "sstart" });
    let b = blast_value(copy(row), copy(schema), if query { "qend" } else { "send" });
    let unit = if query { copy(schema.query_unit) } else { copy(schema.hit_unit) };
    if !a.present || !b.present { return BlastRange { false, 0, 0, 0, copy(unit) }; }
    let x, _ = parse_int(a.text); let y, _ = parse_int(b.text);
    var strand = if unit == "protein" { 0 } else if x <= y { 1 } else { -1 };
    if x == y && unit != "protein" {
        let frame = blast_value(copy(row), copy(schema), if query { "qframe" } else { "sframe" });
        if frame.present { let n, _ = parse_int(frame.text); if n != 0 { strand = if n < 0 { -1 } else { 1 }; } }
    }
    return BlastRange { true, min(x, y) - 1, max(x, y), strand, copy(unit) };
}
fn blast_schema_error(schema: BlastSchema) -> u8[] {
    let units = [copy(schema.query_unit), copy(schema.hit_unit)];
    for unit in units {
        if unit != "nucleotide" && unit != "protein" && unit != "translated" { return "explicit coordinate unit required"; }
    }
    if schema.fields.len == 0 { return "empty schema"; }
    for i in 0..schema.fields.len {
        if blast_label(blast_at(copy(schema.fields), i)).len == 0 { return "unsupported field"; }
        for j in 0..i { if blast_at(copy(schema.fields), i) == blast_at(copy(schema.fields), j) { return "duplicate field"; } }
    }
    for names in [["qstart", "qend"], ["sstart", "send"]] {
        var n = 0; for f in schema.fields { if f == names[0] || f == names[1] { n += 1; } }
        if n == 1 { return "incomplete coordinate pair"; }
    }
    return "";
}
fn blast_row_error(row: BlastRow, schema: BlastSchema) -> u8[] {
    if row.values.len != schema.fields.len { return "truncated or excess BLAST fields"; }
    for i in 0..schema.fields.len {
        let f = blast_at(copy(schema.fields), i); let v = blast_at(copy(row.values), i);
        if v.len == 0 { return "empty BLAST field"; }
        for c in v { if c < 33 || c > 126 { return "invalid field byte"; } }
        if f == "qseqid" || f == "sseqid" || f == "qseq" || f == "sseq" { continue; }
        if f == "pident" || f == "ppos" || f == "evalue" || f == "bitscore" || f == "score" {
            let n, ok = parse_flt(v);
            if !ok || !(n >= 0.0 && n <= 1.7976931348623157e308) { return "invalid numeric field"; }
            if (f == "pident" || f == "ppos") && n > 100.0 { return "invalid percentage"; }
        } else {
            let n, ok = parse_int(v);
            if !ok { return "invalid integer field"; }
            if f == "qframe" || f == "sframe" {
                if n < -3 || n > 3 { return "invalid frame"; }
            } else if n < 0 { return "negative count or coordinate"; }
            else if (f == "qstart" || f == "qend" || f == "sstart" || f == "send" || f == "qlen" || f == "slen" || f == "length") && n == 0 { return "zero length or coordinate"; }
        }
    }
    let length = blast_value(copy(row), copy(schema), "length");
    if length.present {
        let n, _ = parse_int(length.text);
        for f in ["mismatch", "gapopen", "nident", "positive", "gaps"] {
            let v = blast_value(copy(row), copy(schema), f);
            if v.present { let x, _ = parse_int(v.text); if x > n { return "count exceeds alignment length"; } }
        }
        for f in ["qseq", "sseq"] {
            let v = blast_value(copy(row), copy(schema), f);
            if v.present && v.text.len != n { return "aligned string length mismatch"; }
        }
    }
    let mismatch = blast_value(copy(row), copy(schema), "mismatch");
    let gaps = blast_value(copy(row), copy(schema), "gaps");
    let identical = blast_value(copy(row), copy(schema), "nident");
    if length.present && mismatch.present && gaps.present && identical.present {
        let n, _ = parse_int(length.text); let m, _ = parse_int(mismatch.text);
        let g, _ = parse_int(gaps.text); let k, _ = parse_int(identical.text);
        if m > n - g || k != n - g - m { return "inconsistent alignment counts"; }
    }
    let ident = blast_value(copy(row), copy(schema), "nident");
    let pct = blast_value(copy(row), copy(schema), "pident");
    if length.present && ident.present && pct.present {
        let n, _ = parse_int(length.text); let k, _ = parse_int(ident.text);
        let p, _ = parse_flt(pct.text);
        var tolerance = 0.5; var decimal = false;
        for c in pct.text { if c == '.' { decimal = true; }
            else if decimal && c >= '0' && c <= '9' { tolerance /= 10.0; } }
        if max(p - k * 100.0 / n, k * 100.0 / n - p) > max(tolerance, 0.0005) + 0.0000001 { return "inconsistent identity"; }
    }
    for query in [true, false] {
        let r = blast_range(copy(row), copy(schema), query);
        let frame = blast_value(copy(row), copy(schema), if query { "qframe" } else { "sframe" });
        if frame.present && r.present {
            let f, _ = parse_int(frame.text);
            if (r.unit == "protein" && f != 0) || (r.unit == "translated" && f == 0) || (f < 0 && r.strand != -1) || (f > 0 && r.strand != 1) { return "inconsistent coordinate frame"; }
        }
        let seq = blast_value(copy(row), copy(schema), if query { "qseq" } else { "sseq" });
        if seq.present && r.present {
            var count = 0; for c in seq.text { if c != '-' { count += 1; } }
            let scale = if r.unit == "translated" { 3 } else { 1 };
            if r.end - r.start != count * scale { return "aligned string coordinate mismatch"; }
        }
        let l = blast_value(copy(row), copy(schema), if query { "qlen" } else { "slen" });
        if r.present && l.present { let n, _ = parse_int(l.text); if r.end > n { return "coordinate exceeds sequence length"; } }
    }
    return "";
}
/*
Reads plain tabs or commented outfmt 7 using the exact caller schema; declared fields
must agree. IDs/aligned strings require printable non- whitespace ASCII. Numbers fit i64
or finite f64; identity checks respect supplied precision. Cross-column checks require
the relevant supplied fields.
*/
fn parse_blast_table(text: u8[:], schema: BlastSchema, comments: bool) -> BlastTable {
    var result = BlastTable { copy(schema), [], blast_schema_error(copy(schema)) };
    if result.error.len > 0 { return result; }
    var groups: BlastBlock[>..] = []; var rows: BlastRow[>..] = [];
    var id:     u8[>..]         = []; var description: u8[>..] = [];
    var declared = false; var expected: i64 = -1; var active = false;
    for raw in split(text, '\n') {
        let line = format_line(raw); if line.len == 0 { continue; }
        if line[0] == '#' {
            if !comments { return BlastTable { copy(schema), [], "unexpected comment" }; }
            if starts_with(line, "# Query: ") {
                if active {
                    if expected < 0 || expected != rows.len { return BlastTable { copy(schema), [], "missing or inconsistent hit count" }; }
                    groups.push(BlastBlock { copy(id), copy(description), declared, copy(rows) });
                }
                description = []; description.append(line[9..]); id = []; id.append(split(description, ' ')[0]);
                rows = []; declared = false; expected = -1; active = true;
            } else if starts_with(line, "# Fields: ") {
                if !active || declared || rows.len > 0 { return BlastTable { copy(schema), [], "misplaced fields declaration" }; }
                let labels = split(line[10..], ',');
                if labels.len != schema.fields.len { return BlastTable { copy(schema), [], "declared schema mismatch" }; }
                for i in 0..labels.len {
                    var label = labels[i]; if label.len > 0 && label[0] == ' ' { label = label[1..]; }
                    if label != blast_label(blast_at(copy(schema.fields), i)) { return BlastTable { copy(schema), [], "declared schema mismatch" }; }
                }
                declared = true;
            } else if starts_with(line, "# ") {
                let words = split(line, ' ');
                if words.len == 5 && words[2] == "hits" && words[3] == "found" { return BlastTable { copy(schema), [], "malformed hit declaration" }; }
                if words.len == 4 && words[2] == "hits" && words[3] == "found" {
                    let n, ok = parse_int(words[1]);
                    if !active || expected >= 0 || !ok || n < 0 { return BlastTable { copy(schema), [], "invalid hit declaration" }; }
                    expected = n;
                }
            }
            continue;
        }
        var values: u8[][>..] = []; for v in split(line, '\t') { values.push(str(v)); }
        let row = BlastRow { copy(values) }; let error = blast_row_error(copy(row), copy(schema));
        if error.len > 0 { return BlastTable { copy(schema), [], error }; }
        let q = blast_value(copy(row), copy(schema), "qseqid");
        if comments {
            if !active || !declared || expected < 0 || (q.present && q.text != id) { return BlastTable { copy(schema), [], "row outside declared query" }; }
        } else {
            if !q.present { return BlastTable { copy(schema), [], "plain input requires qseqid" }; }
            if !active || q.text != id {
                if active { groups.push(BlastBlock { copy(id), copy(description), declared, copy(rows) }); }
                id = []; id.append(q.text); description = []; description.append(id); rows = []; active = true;
            }
        }
        rows.push(copy(row));
    }
    if active {
        if comments && (expected < 0 || expected != rows.len) { return BlastTable { copy(schema), [], "truncated query group" }; }
        groups.push(BlastBlock { copy(id), copy(description), declared, copy(rows) });
    }
    return BlastTable { copy(schema), copy(groups), "" };
}
/*
Selects/reorders supplied fields without inventing values or changing coordinate units.
Numeric spelling/precision survives. Plain output rejects zero-hit queries; commented
output includes descriptions, fields, and counts.
*/
/*
Program/database/version and unrelated comments are not retained; output uses a generic
BLAST header without claiming a run. No BLAST execution, alignment mutation, XML, or
HMMER support.
*/
fn write_blast_table(table: BlastTable, output: BlastSchema, comments: bool) -> BlastText {
    if table.error.len > 0 { return BlastText { "", copy(table.error) }; }
    if output.query_unit != table.schema.query_unit || output.hit_unit != table.schema.hit_unit { return BlastText { "", "output coordinate units differ" }; }
    let error = blast_schema_error(copy(output)); if error.len > 0 { return BlastText { "", error }; }
    if !comments {
        var query_id = false;
        for field in output.fields { if field == "qseqid" { query_id = true; } }
        if !query_id { return BlastText { "", "plain output requires qseqid" }; }
    }
    var text: u8[>..] = [];
    for group in table.queries {
        if comments {
            text.append("# BLAST tabular\n# Query: "); text.append(group.description); text.append("\n");
            if group.fields_declared || group.rows.len > 0 {
                text.append("# Fields: ");
                for i in 0..output.fields.len { if i > 0 { text.append(", "); } text.append(blast_label(blast_at(copy(output.fields), i))); }
                text.append("\n");
            }
            text.append("# "); text.append(str(group.rows.len)); text.append(" hits found\n");
        }
        for row in group.rows {
            let e = blast_row_error(copy(row), copy(table.schema)); if e.len > 0 { return BlastText { "", e }; }
            for i in 0..output.fields.len {
                let v = blast_value(copy(row), copy(table.schema), blast_at(copy(output.fields), i));
                if !v.present { return BlastText { "", "output field absent" }; }
                if i > 0 { text.append("\t"); } text.append(v.text);
            }
            text.append("\n");
        }
    }
    return BlastText { copy(text), "" };
}
/*
Inclusive numeric bounds require the field on every evaluated row. Query blocks remain
even when all rows fail.
*/
fn filter_blast_table(table: BlastTable, field: u8[:], minimum: f64, maximum: f64) -> BlastTable {
    var out = copy(table); var groups: BlastBlock[>..] = [];
    if table.error.len > 0 { return out; }
    if !(minimum <= maximum) { return BlastTable { copy(table.schema), [], "invalid filter range" }; }
    for group in table.queries {
        var rows: BlastRow[>..] = [];
        for row in group.rows {
            let v = blast_value(copy(row), copy(table.schema), field);
            if !v.present { return BlastTable { copy(table.schema), [], "filter field absent" }; }
            let n, ok = parse_flt(v.text);
            if !ok { return BlastTable { copy(table.schema), [], "filter requires numeric field" }; }
            if n >= minimum && n <= maximum { rows.push(copy(row)); }
        }
        groups.push(BlastBlock { copy(group.id), copy(group.description), group.fields_declared, copy(rows) });
    }
    return BlastTable { copy(table.schema), copy(groups), "" };
}

fn blast_at(items: u8[][], index: i64) -> u8[] {
    var i = 0; for item in items { if i == index { return copy(item); } i += 1; }
    return "";
}
