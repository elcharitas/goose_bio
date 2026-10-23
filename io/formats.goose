namespace bio;
import std;

struct SequenceRecord { header: u8[], sequence: u8[], quality: u8[] }
struct RecordsResult { records: SequenceRecord[], error: u8[] }
struct FormatTextResult { text: u8[], error: u8[] }
struct TextRow { fields: u8[][] }
struct RowsResult { rows: TextRow[], error: u8[] }

fn format_line(line: u8[:]) -> u8[:] {
    if line.len > 0 && line[line.len-1] == '\r' { return line[..line.len-1]; }
    return line;
}

fn parse_fasta(text: u8[:]) -> RecordsResult {
    var records: SequenceRecord[>..] = [];
    var header: u8[>..] = [];
    var sequence: u8[>..] = [];
    var active = false;
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if line[0] == '>' {
            if active {
                if sequence.len == 0 { return RecordsResult { [], "empty FASTA sequence" }; }
                records.push(SequenceRecord { copy(header), copy(sequence), "" });
            }
            if line.len == 1 || trim(line[1..]).len == 0 {
                return RecordsResult { [], "empty FASTA header" };
            }
            header.clear(); sequence.clear();
            header.append(line[1..]); active = true;
        } else {
            if !active { return RecordsResult { [], "FASTA sequence before header" }; }
            for c in line {
                if c <= 32 || c > 126 || c == '>' { return RecordsResult { [], "invalid FASTA sequence byte" }; }
                sequence.push(c);
            }
        }
    }
    if active {
        if sequence.len == 0 { return RecordsResult { [], "empty FASTA sequence" }; }
        records.push(SequenceRecord { copy(header), copy(sequence), "" });
    }
    return RecordsResult { copy(records), "" };
}

fn parse_fastq(text: u8[:]) -> RecordsResult {
    var records: SequenceRecord[>..] = [];
    var header: u8[>..] = [];
    var sequence: u8[>..] = [];
    var quality: u8[>..] = [];
    var state = 0;
    let lines = split(text, '\n');
    for raw, index in lines {
        let line = format_line(raw);
        if index == lines.len - 1 && line.len == 0 { continue; }
        if state == 0 {
            if line.len < 2 || line[0] != '@' || trim(line[1..]).len == 0 {
                return RecordsResult { [], "expected FASTQ header" };
            }
            header.clear(); sequence.clear(); quality.clear();
            header.append(line[1..]); state = 1;
        } else if state == 1 {
            if line.len > 0 && line[0] == '+' {
                if sequence.len == 0 { return RecordsResult { [], "empty FASTQ sequence" }; }
                if line.len > 1 && line[1..] != header {
                    return RecordsResult { [], "FASTQ separator header mismatch" };
                }
                state = 2;
            } else {
                if line.len == 0 { return RecordsResult { [], "empty FASTQ sequence line" }; }
                for c in line {
                    if c <= 32 || c > 126 || c == '+' { return RecordsResult { [], "invalid FASTQ sequence byte" }; }
                    sequence.push(c);
                }
            }
        } else {
            if line.len == 0 { return RecordsResult { [], "empty FASTQ quality line" }; }
            for c in line {
                if c < 33 || c > 126 { return RecordsResult { [], "invalid Phred+33 quality" }; }
                quality.push(c);
            }
            if quality.len > sequence.len { return RecordsResult { [], "FASTQ quality too long" }; }
            if quality.len == sequence.len {
                records.push(SequenceRecord { copy(header), copy(sequence), copy(quality) });
                state = 0;
            }
        }
    }
    if state != 0 { return RecordsResult { [], "truncated FASTQ record" }; }
    return RecordsResult { copy(records), "" };
}

fn write_fasta(records: SequenceRecord[:], width: i64 = 80) -> FormatTextResult {
    if width <= 0 { return FormatTextResult { "", "width must be positive" }; }
    var out: u8[>..] = [];
    for r in records {
        if trim(r.header).len == 0 || r.sequence.len == 0 { return FormatTextResult { "", "empty FASTA record" }; }
        for c in r.header { if c == '\n' || c == '\r' { return FormatTextResult { "", "newline in header" }; } }
        for c in r.sequence { if c <= 32 || c > 126 || c == '>' { return FormatTextResult { "", "invalid FASTA sequence byte" }; } }
        out.push('>'); out.append(r.header); out.push('\n');
        for c, i in r.sequence {
            out.push(c);
            if (i+1) % width == 0 || i+1 == r.sequence.len { out.push('\n'); }
        }
    }
    return FormatTextResult { copy(out), "" };
}

fn write_fastq(records: SequenceRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        if trim(r.header).len == 0 || r.sequence.len == 0 || r.sequence.len != r.quality.len {
            return FormatTextResult { "", "invalid FASTQ record lengths" };
        }
        for c in r.header { if c == '\n' || c == '\r' { return FormatTextResult { "", "newline in header" }; } }
        for c in r.sequence { if c <= 32 || c > 126 || c == '+' { return FormatTextResult { "", "invalid FASTQ sequence byte" }; } }
        for c in r.quality { if c < 33 || c > 126 { return FormatTextResult { "", "invalid Phred+33 quality" }; } }
        out.push('@'); out.append(r.header); out.push('\n');
        out.append(r.sequence); out.append("\n+\n"); out.append(r.quality); out.push('\n');
    }
    return FormatTextResult { copy(out), "" };
}

// Retains raw columns; validates mandatory column counts and coordinates.
fn parse_feature_rows(text: u8[:], kind: u8[:]) -> RowsResult {
    if kind != "BED" && kind != "GFF" && kind != "VCF" && kind != "SAM" {
        return RowsResult { [], "unknown format" };
    }
    var rows: TextRow[>..] = [];
    for raw in split(text, '\n') {
        let line = format_line(raw);
        if line.len == 0 { continue; }
        if kind == "GFF" && line == "##FASTA" { break; }
        if line[0] == '#' { continue; }
        if kind == "SAM" && line[0] == '@' { continue; }
        if kind == "BED" && (starts_with(line, "track ") || starts_with(line, "browser ")) { continue; }
        let parts = split(line, '\t');
        let minimum = if kind == "BED" { 3 } else if kind == "VCF" { 8 } else if kind == "SAM" { 11 } else { 9 };
        if parts.len < minimum || (kind == "GFF" && parts.len != 9) {
            return RowsResult { [], "wrong column count" };
        }
        var fields: u8[][>..] = [];
        for p in parts {
            if p.len == 0 { return RowsResult { [], "empty column" }; }
            fields.push(str(p));
        }
        let coordinate_index = if kind == "BED" || kind == "VCF" { 1 } else { 3 };
        let start, ok = parse_int(parts[coordinate_index]);
        if !ok || start < 0 || (kind != "BED" && kind != "SAM" && start == 0) {
            return RowsResult { [], "invalid coordinate" };
        }
        if kind == "BED" || kind == "GFF" {
            let end, end_ok = parse_int(parts[if kind == "BED" { 2 } else { 4 }]);
            if !end_ok || end < start { return RowsResult { [], "invalid interval end" }; }
        }
        if kind == "SAM" {
            let flag, flag_ok = parse_int(parts[1]);
            let mapq, mapq_ok = parse_int(parts[4]);
            if !flag_ok || flag < 0 || flag > 65535 || !mapq_ok || mapq < 0 || mapq > 255 {
                return RowsResult { [], "invalid SAM flag or MAPQ" };
            }
            if parts[9] != "*" && parts[10] != "*" && parts[9].len != parts[10].len {
                return RowsResult { [], "SAM sequence/quality length mismatch" };
            }
        }
        rows.push(TextRow { copy(fields) });
    }
    return RowsResult { copy(rows), "" };
}
fn parse_bed(text: u8[:]) -> RowsResult { return parse_feature_rows(text, "BED"); }
fn parse_gff(text: u8[:]) -> RowsResult { return parse_feature_rows(text, "GFF"); }
fn parse_vcf(text: u8[:]) -> RowsResult { return parse_feature_rows(text, "VCF"); }
fn parse_sam(text: u8[:]) -> RowsResult { return parse_feature_rows(text, "SAM"); }
