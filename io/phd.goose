namespace bio;
import std;
import .specialist_fields;
import .alignment_io;
/*
Quality and optional peaks are nonnegative i64 values, without a FASTQ quality cap.
*/
struct PhdSite { base: u8, quality: i64, peak: i64, has_peak: bool }
/*
TRIM bounds are zero-based and half-open. Without TRIM, seq_trimmed is empty. Ordered
comments retain unknown keys and duplicate keys; raw omits blank lines and normalizes
CRLF and the final LF.
*/
struct PhdRecord { file_name: u8[], comments: SpecialistField[], sites: PhdSite[], sequence: u8[], seq_trimmed: u8[], raw: u8[] }
struct PhdResult { records: PhdRecord[], error: u8[] }
struct PhdReadResult { record: PhdRecord, error: u8[] }
/*
Requires exact marker order and uppercase TRIM. Preambles, trailing garbage, non-IUPAC
bases, negative quality, and invalid trim bounds fail. Empty input yields no records;
parsing buffers bytes without files, encoding conversion, or network access.
*/
fn parse_phd(text: u8[:]) -> PhdResult {
    var records:  PhdRecord[>..]       = []; var name: u8[>..] = [];
    var comments: SpecialistField[>..] = []; var sites: PhdSite[>..] = [];
    var sequence: u8[>..]              = []; var raw: u8[>..] = [];
    var state = 0; var first = -1; var last = -1;
    for input in split(text, '\n') {
        let original = format_line(input); let line = trim(original);
        if line.len == 0 { continue; }
        if state == 0 {
            if line.len <= 15 || line[..15] != "BEGIN_SEQUENCE " { return PhdResult { [], "expected BEGIN_SEQUENCE" }; }
            name.append(line[15..]); state = 1;
        } else if state == 1 {
            if line != "BEGIN_COMMENT" { return PhdResult { [], "expected BEGIN_COMMENT" }; } state = 2;
        } else if state == 2 {
            if line == "END_COMMENT" { state = 3; }
            else {
                let p = specialist_pair(line, ':');
                if p.error.len > 0 { return PhdResult { [], "invalid PHD comment" }; }
                if p.field.key == "TRIM" {
                    let tokens = alignment_words(p.field.value); var words: u8[:][>..] = []; for token in tokens.fields { words.push(token); }
                    if words.len != 3 { return PhdResult { [], "invalid PHD trim" }; }
                    let a, aok = specialist_uint(words[0]); let b, bok = specialist_uint(words[1]);
                    let pok = phd_probability(words[2]);
                    if !aok || !bok || a > b || !pok { return PhdResult { [], "invalid PHD trim" }; }
                    first = a; last = b;
                }
                comments.push(copy(p.field));
            }
        } else if state == 3 {
            if line != "BEGIN_DNA" { return PhdResult { [], "expected BEGIN_DNA" }; } state = 4;
        } else if state == 4 {
            if line == "END_DNA" { state = 5; }
            else {
                let tokens = alignment_words(line); var words: u8[:][>..] = []; for token in tokens.fields { words.push(token); }
                if words.len < 2 || words.len > 3 || words[0].len != 1 { return PhdResult { [], "invalid PHD site" }; }
                let base = words[0][0];
                var valid = false;
                for c in "ACGTRYSWKMBDHVNacgtryswkmbdhvn" { if base == c { valid = true; } }
                let quality, ok = specialist_uint(words[1]);
                if !valid || !ok { return PhdResult { [], "invalid nucleotide or quality" }; }
                var peak = 0;
                if words.len == 3 {
                    let n, nok = specialist_uint(words[2]);
                    if !nok { return PhdResult { [], "invalid PHD peak" }; } peak = n;
                }
                sites.push(PhdSite { base, quality, peak, words.len == 3 }); sequence.push(base);
            }
        } else {
            if line != "END_SEQUENCE" { return PhdResult { [], "expected END_SEQUENCE" }; }
            var trimmed: u8[>..] = [];
            if first >= 0 {
                if last > sequence.len { return PhdResult { [], "PHD trim exceeds sequence" }; }
                trimmed.append(sequence[first..last]);
            }
            raw.append(original); raw.push('\n');
            records.push(PhdRecord { copy(name), copy(comments), copy(sites), copy(sequence), copy(trimmed), copy(raw) });
            name.clear(); comments.clear(); sites.clear(); sequence.clear(); raw.clear(); state = 0; first = -1; last = -1; continue;
        }
        raw.append(original); raw.push('\n');
    }
    if state != 0 { return PhdResult { [], "truncated PHD record" }; }
    return PhdResult { copy(records), "" };
}
/*
Requires exactly one record, including on empty input.
*/
fn read_phd(text: u8[:]) -> PhdReadResult {
    let result = parse_phd(text);
    if result.error.len > 0 { return PhdReadResult { PhdRecord { "", [], [], "", "", "" }, copy(result.error) }; }
    if result.records.len != 1 { return PhdReadResult { PhdRecord { "", [], [], "", "", "" }, "expected one PHD record" }; }
    for r in result.records { return PhdReadResult { copy(r), "" }; }
    return PhdReadResult { PhdRecord { "", [], [], "", "", "" }, "no PHD record" };
}
/*
Sites and comments are authoritative. Checks sequence consistency and reparses generated
output. Unknown comments survive; derived seq_trimmed and raw do not control output.
*/
fn write_phd(records: PhdRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        if r.file_name.len == 0 || !specialist_line(r.file_name) || trim_end(r.file_name) != r.file_name { return FormatTextResult { "", "invalid PHD name" }; }
        out.append("BEGIN_SEQUENCE "); out.append(r.file_name); out.append("\nBEGIN_COMMENT\n");
        for c in r.comments {
            if c.key.len == 0 || !specialist_line(c.key) || !specialist_line(c.value) || trim(c.key) != c.key || trim(c.value) != c.value { return FormatTextResult { "", "invalid PHD comment" }; }
            for byte in c.key { if byte == ':' { return FormatTextResult { "", "colon in PHD comment key" }; } }
            out.append(c.key); out.append(": "); out.append(c.value); out.push('\n');
        }
        out.append("END_COMMENT\nBEGIN_DNA\n");
        var sequence: u8[>..] = [];
        for s in r.sites {
            sequence.push(s.base); out.push(s.base); out.push(' '); out.append(str(s.quality));
            if s.has_peak { out.push(' '); out.append(str(s.peak)); } out.push('\n');
        }
        if sequence != r.sequence { return FormatTextResult { "", "PHD site/sequence mismatch" }; }
        out.append("END_DNA\nEND_SEQUENCE\n");
    }
    let checked = parse_phd(out);
    if checked.error.len > 0 { return FormatTextResult { "", copy(checked.error) }; }
    return FormatTextResult { copy(out), "" };
}

/*
TRIM probability accepts 0, 1, and decimals beginning with 0. or 1. within [0,1].
Scientific notation fails; other comment values remain untyped text.
*/
fn phd_probability(text: u8[:]) -> bool {
    if text.len == 0 || (text[0] != '0' && text[0] != '1') { return false; }
    if text.len == 1 { return true; }
    if text[1] != '.' || text.len == 2 { return false; }
    for c in text[2..] { if c < '0' || c > '9' || (text[0] == '1' && c != '0') { return false; } }
    return true;
}
