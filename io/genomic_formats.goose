namespace bio;
import std;
import .formats;

/*
columns tracks BED3-BED12 presence; extras follow BED12. Short custom schemas are
ambiguous. Coordinates are nonnegative i64 half-open; empty unblocked intervals are
valid. Scores are 0-1000; thick bounds lie inside the interval. RGB is three bytes or
empty for zero.
*/
struct BedRecord {
    chrom: u8[], start: i64, end: i64, columns: i64,
    name: u8[], score: i64, strand: u8[], thick_start: i64,
    thick_end: i64, rgb: i64[], block_count: i64,
    block_sizes: i64[], block_starts: i64[], extras: u8[][]
}
struct BedResult { records: BedRecord[], error: u8[] }
/*
Six required plus four optional standard fields; score stays text under bedtools rules.
Unknown chromosome/strand is dot, and each unknown coordinate is independently -1.
Sentinels do not imply unmapped flags or couple chromosome/coordinates.
*/
struct BedPeRecord {
    chrom1: u8[], start1: i64, end1: i64,
    chrom2: u8[], start2: i64, end2: i64, columns: i64,
    name: u8[], score: u8[], strand1: u8[], strand2: u8[], extras: u8[][]
}
struct BedPeResult { records: BedPeRecord[], error: u8[] }
struct GffAttribute { key: u8[], values: u8[][] }
/*
Converts one-based inclusive endpoints to zero-based half-open; equal endpoints mean one
base, with insertion meaning left to callers. Dot score is score_known=false; numeric
scores are finite f64. Strand +/-/./? stays distinct; phase is -1 for dot or 0-2,
required for CDS and never inferred.
*/
struct GffFeature {
    seqid: u8[], source: u8[], kind: u8[], start: i64, end: i64,
    score_known: bool, score: f64, strand: u8[], phase: i64,
    attributes: GffAttribute[]
}
/*
Comments, group separators, and known/unknown directives retain raw line order. Feature
indices must be consecutive; writers reject missing, repeated, or reordered indices.
Unknown directives have no semantic validation.
*/
struct GffEntry { raw: u8[], feature_index: i64 }
/*
Errors contain no partial records; writers validate output and reject delimiter
injection. Variable-size records require iteration and explicit copies for owned
arguments. In-memory codecs have no streaming, index, compression, or resource caps.
*/
struct Gff3Result { features: GffFeature[], entries: GffEntry[], error: u8[] }
struct GenomicDecoded { value: u8[], error: u8[] }
fn genomic_cell(s: u8[:]) -> bool {
    if s.len == 0 { return false; }
    for c in s { if c < 32 || c == 127 { return false; } }
    return true;
}
fn genomic_uint(s: u8[:]) -> i64 {
    if s.len == 0 { return -1; }
    for c in s { if c < '0' || c > '9' { return -1; } }
    let n, ok = parse_int(s); if !ok { return -1; } return n;
}
fn genomic_list(s: u8[:]) -> i64[] {
    var out: i64[>..] = [];
    let parts = split(s, ',');
    for p, i in parts {
        if p.len == 0 && i == parts.len-1 { continue; }
        let n = genomic_uint(p); if n < 0 { return [-1]; } out.push(n);
    }
    return copy(out);
}
fn genomic_strand(s: u8[:], gff: bool = false) -> bool {
    return s == "+" || s == "-" || s == "." || (gff && s == "?");
}
/*
Blocks have positive sizes, matching counts, sorted nonoverlap, and UCSC endpoint
coverage. BED10/11 retain partial fields. Headers, comments, browser directives,
whitespace-separated records, and empty custom fields fail. One terminal list comma is
accepted.
*/
fn parse_typed_bed(text: u8[:]) -> BedResult {
    var out: BedRecord[>..] = [];
    for raw in split(text, '\n') {
        let line = format_line(raw); if line.len == 0 { continue; }
        let f = split(line, '\t');
        if f.len < 3 { return BedResult {[], "BED needs at least three tab columns"}; }
        for s in f { if !genomic_cell(s) { return BedResult {[], "invalid BED cell"}; } }
        var chrom = str(f[0]); var start = genomic_uint(f[1]); var end = genomic_uint(f[2]); var columns = min(f.len,12); var name = str(""); var score = 0; var strand = str(""); var thick_start = 0; var thick_end = 0; var rgb: i64[>..] = []; var block_count = 0; var block_sizes: i64[>..] = []; var block_starts: i64[>..] = []; var extras: u8[][>..] = [];
        if start < 0 || end < start { return BedResult {[], "invalid BED interval"}; }
        if f.len >= 4 { name = str(f[3]); }
        if f.len >= 5 { score = genomic_uint(f[4]); if score < 0 || score > 1000 { return BedResult {[], "BED score outside 0..1000"}; } }
        if f.len >= 6 { strand = str(f[5]); if !genomic_strand(strand) { return BedResult {[], "invalid BED strand"}; } }
        if f.len >= 7 { thick_start = genomic_uint(f[6]); if thick_start < start || thick_start > end { return BedResult {[], "invalid thickStart"}; } }
        if f.len >= 8 { thick_end = genomic_uint(f[7]); if thick_end < thick_start || thick_end > end { return BedResult {[], "invalid thickEnd"}; } }
        if f.len >= 9 {
            if f[8] == "0" { rgb.clear(); } else {
                rgb.append(genomic_list(f[8]));
                if rgb.len != 3 { return BedResult {[], "invalid RGB"}; }
                for n in rgb { if n < 0 || n > 255 { return BedResult {[], "invalid RGB"}; } }
            }
        }
        if f.len >= 10 { block_count = genomic_uint(f[9]); if block_count < 1 { return BedResult {[], "invalid block count"}; } }
        if f.len >= 11 {
            block_sizes.append(genomic_list(f[10]));
            if block_sizes.len != block_count { return BedResult {[], "block size count mismatch"}; }
            for n in block_sizes { if n <= 0 || n > end-start { return BedResult {[], "invalid block size"}; } }
        }
        if f.len >= 12 {
            block_starts.append(genomic_list(f[11]));
            if block_starts.len != block_count { return BedResult {[], "block start count mismatch"}; }
            var previous_end = 0;
            for n, i in block_starts {
                if n < previous_end || n > end-start || block_sizes[i] > end-start-n { return BedResult {[], "overlapping, unsorted or outside blocks"}; }
                if i == 0 && n != 0 { return BedResult {[], "first block must start at zero"}; }
                previous_end = n+block_sizes[i];
            }
            if previous_end != end-start { return BedResult {[], "last block must end at chromEnd"}; }
        }
        var extra_values: u8[][>..] = []; for i in 12..f.len { extra_values.push(str(f[i])); } extras.append(extra_values);
        out.push(BedRecord {copy(chrom), start, end, columns, copy(name), score, copy(strand), thick_start, thick_end, copy(rgb), block_count, copy(block_sizes), copy(block_starts), copy(extras)});
    }
    return BedResult {copy(out), ""};
}
fn genomic_numbers(ns: i64[:]) -> u8[] {
    var out: u8[>..] = []; for n, i in ns { if i > 0 { out.push(','); } out.append(str(n)); } return copy(out);
}
/* Normalizes list commas and formatting while preserving supported fields. No BED detail, or short
 * custom schemas. */
fn write_typed_bed(records: BedRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        if r.columns < 3 || r.columns > 12 || (r.extras.len > 0 && r.columns != 12) { return FormatTextResult {"", "invalid BED column schema"}; }
        let fields: u8[][] = [copy(r.chrom),str(r.start),str(r.end),copy(r.name),str(r.score),copy(r.strand),str(r.thick_start),str(r.thick_end),if r.rgb.len == 0 { "0" } else { genomic_numbers(r.rgb) },str(r.block_count),genomic_numbers(r.block_sizes),genomic_numbers(r.block_starts)];
        for field, i in fields { if i >= r.columns { break; } if !genomic_cell(field) { return FormatTextResult {"", "invalid BED field"}; } if i > 0 { out.push('\t'); } out.append(field); }
        for s in r.extras { if !genomic_cell(s) { return FormatTextResult {"", "invalid extra"}; } out.push('\t'); out.append(s); } out.push('\n');
    }
    let check = parse_typed_bed(out); if check.error.len > 0 { return FormatTextResult {"",copy(check.error)}; }
    return FormatTextResult {copy(out),""};
}
fn genomic_pe_coord(s: u8[:]) -> i64 { if s == "-1" { return -1; } return genomic_uint(s); }
/*
Known coordinate pairs require start <= end. Extra fields after column ten survive
writes.
*/
fn parse_typed_bedpe(text: u8[:]) -> BedPeResult {
    var out: BedPeRecord[>..] = [];
    for raw in split(text,'\n') {
        let line = format_line(raw); if line.len == 0 { continue; } let f = split(line,'\t');
        if f.len < 6 { return BedPeResult {[],"BEDPE needs six columns"}; }
        for s in f { if !genomic_cell(s) { return BedPeResult {[],"invalid BEDPE cell"}; } }
        for j in [1,2,4,5] { if f[j] != "-1" && genomic_uint(f[j]) < 0 { return BedPeResult {[],"invalid BEDPE coordinate"}; } }
        var chrom1 = str(f[0]); var start1 = genomic_pe_coord(f[1]); var end1 = genomic_pe_coord(f[2]); var chrom2 = str(f[3]); var start2 = genomic_pe_coord(f[4]); var end2 = genomic_pe_coord(f[5]); var columns = min(f.len,10); var name = str(""); var score = str(""); var strand1 = str(""); var strand2 = str(""); var extras: u8[][>..] = [];
        if (start1 >= 0 && end1 >= 0 && end1 < start1) || (start2 >= 0 && end2 >= 0 && end2 < start2) { return BedPeResult {[],"reversed BEDPE interval"}; }
        if f.len >= 7 { name = str(f[6]); } if f.len >= 8 { score = str(f[7]); }
        if f.len >= 9 { strand1 = str(f[8]); if !genomic_strand(strand1) { return BedPeResult {[],"invalid BEDPE strand"}; } }
        if f.len >= 10 { strand2 = str(f[9]); if !genomic_strand(strand2) { return BedPeResult {[],"invalid BEDPE strand"}; } }
        var extra_values: u8[][>..] = []; for i in 10..f.len { extra_values.push(str(f[i])); } extras.append(extra_values); out.push(BedPeRecord {copy(chrom1), start1, end1, copy(chrom2), start2, end2, columns, copy(name), copy(score), copy(strand1), copy(strand2), copy(extras)});
    }
    return BedPeResult {copy(out),""};
}
/*
Preserves standard-field presence and extras, with normalized formatting rather than
byte-exact output.
*/
fn write_typed_bedpe(records: BedPeRecord[:]) -> FormatTextResult {
    var out: u8[>..] = [];
    for r in records {
        if r.columns < 6 || r.columns > 10 || (r.extras.len > 0 && r.columns != 10) { return FormatTextResult {"","invalid BEDPE schema"}; }
        let f: u8[][] = [copy(r.chrom1),str(r.start1),str(r.end1),copy(r.chrom2),str(r.start2),str(r.end2),copy(r.name),copy(r.score),copy(r.strand1),copy(r.strand2)];
        for field, i in f { if i >= r.columns { break; } if !genomic_cell(field) { return FormatTextResult {"","invalid field"}; } if i > 0 { out.push('\t'); } out.append(field); }
        for s in r.extras { if !genomic_cell(s) { return FormatTextResult {"","invalid extra"}; } out.push('\t'); out.append(s); } out.push('\n');
    }
    let check = parse_typed_bedpe(out); if check.error.len > 0 { return FormatTextResult {"",copy(check.error)}; } return FormatTextResult {copy(out),""};
}
fn genomic_hex(c: u8) -> i64 { if c >= '0' && c <= '9' { return c-'0'; } if c >= 'A' && c <= 'F' { return c-'A'+10; } if c >= 'a' && c <= 'f' { return c-'a'+10; } return -1; }
/*
Splits attributes before percent decoding, so escaped commas/semicolons stay in values.
Invalid escapes fail; ordered decoded values survive.
*/
fn gff3_decode(s: u8[:], attribute: bool = false) -> GenomicDecoded {
    var out: u8[>..] = []; var i = 0;
    while i < s.len {
        if s[i] == '%' {
            if i+2 >= s.len { return GenomicDecoded {"","truncated percent escape"}; }
            let a = genomic_hex(s[i+1]); let b = genomic_hex(s[i+2]); if a < 0 || b < 0 { return GenomicDecoded {"","invalid percent escape"}; }
            out.push((a*16+b) as u8); i += 3;
        } else { if s[i] < 32 || (s[i] == 32 && !attribute) || s[i] == 127 { return GenomicDecoded {"","unescaped whitespace/control"}; } out.push(s[i]); i += 1; }
    }
    return GenomicDecoded {copy(out),""};
}
fn gff3_encode(s: u8[:]) -> u8[] {
    let hex = "0123456789ABCDEF"; var out: u8[>..] = [];
    for c in s {
        if c <= 32 || c >= 127 || c == '%' || c == ';' || c == '=' || c == ',' || c == '&' || c == '#' || c == '>' {
            out.push('%'); out.push(hex[c/16]); out.push(hex[c%16]);
        } else { out.push(c); }
    } return copy(out);
}
/*
First nonempty line must be exactly ##gff-version 3; duplicate versions fail. Rejects
duplicate tags, multiple ID values, and empty IDs; other empty values and attribute
spaces survive. No GTF/GFF2 support.
*/
/*
Sequence-region needs an identifier and ordered positive endpoints; embedded ##FASTA
fails. Ontology, discontinuous-feature ID uniqueness, Parent graphs, Target/Gap,
reference lengths, and sequence-region containment are not validated.
*/
fn parse_gff3(text: u8[:]) -> Gff3Result {
    var features: GffFeature[>..] = []; var entries: GffEntry[>..] = []; var header = false; var versions = 0;
    for raw in split(text,'\n') {
        let line = format_line(raw); if line.len == 0 { continue; }
        if !header { if line != "##gff-version 3" { return Gff3Result {[],[],"expected exact GFF3 version header"}; } header = true; }
        if line == "##FASTA" || line[0] == '>' { return Gff3Result {[],[],"embedded FASTA unsupported"}; }
        if line[0] == '#' {
            if line.len >= 13 && line[..13] == "##gff-version" && line != "##gff-version 3" { return Gff3Result {[],[],"invalid version directive"}; }
            if line == "##gff-version 3" { versions += 1; if versions != 1 { return Gff3Result {[],[],"duplicate version directive"}; } }
            if line.len >= 17 && line[..17] == "##sequence-region" {
                let words = split(line,' ');
                if words.len != 4 || words[0] != "##sequence-region" || genomic_uint(words[2]) < 1 || genomic_uint(words[3]) < genomic_uint(words[2]) || gff3_decode(words[1]).error.len > 0 || gff3_decode(words[1]).value.len == 0 { return Gff3Result {[],[],"invalid sequence-region directive"}; }
            }
            entries.push(GffEntry {str(line),-1}); continue;
        }
        let f = split(line,'\t'); if f.len != 9 { return Gff3Result {[],[],"GFF3 requires nine columns"}; }
        let start = genomic_uint(f[3]); let end = genomic_uint(f[4]);
        if start < 1 || end < start || !genomic_strand(f[6],true) { return Gff3Result {[],[],"invalid GFF interval or strand"}; }
        let decoded_kind = gff3_decode(f[2]);
        if decoded_kind.error.len > 0 { return Gff3Result {[],[],"invalid GFF identifier"}; }
        let phase = if f[7] == "." { -1 } else { genomic_uint(f[7]) };
        if (f[7] != "." && (f[7].len != 1 || phase < 0 || phase > 2)) || (decoded_kind.value == "CDS" && phase < 0) { return Gff3Result {[],[],"invalid GFF phase"}; }
        var score = 0.0; if f[5] != "." { let v, ok = parse_flt(f[5]); if !genomic_number(f[5]) || !ok || is_nan(v) || is_inf(v) { return Gff3Result {[],[],"invalid GFF score"}; } score = v; }
        var names: u8[][>..] = [];
        for i in 0..3 { let d = gff3_decode(f[i]); if d.error.len > 0 || d.value.len == 0 { return Gff3Result {[],[],"invalid GFF identifier"}; } names.push(copy(d.value)); }
        var attrs: GffAttribute[>..] = [];
        if f[8].len == 0 { return Gff3Result {[],[],"empty attribute column"}; }
        if f[8] != "." {
            let parts = split(f[8],';');
            for p, index in parts {
                if p.len == 0 && index == parts.len-1 { continue; }
                let pair = split(p,'='); if pair.len != 2 { return Gff3Result {[],[],"invalid attribute pair"}; }
                let key = gff3_decode(pair[0],true); if key.error.len > 0 || key.value.len == 0 { return Gff3Result {[],[],"invalid attribute key"}; }
                for a in attrs { if a.key == key.value { return Gff3Result {[],[],"duplicate attribute key"}; } }
                var values: u8[][>..] = [];
                for v in split(pair[1],',') { let d = gff3_decode(v,true); if d.error.len > 0 { return Gff3Result {[],[],copy(d.error)}; } values.push(copy(d.value)); }
                if key.value == "ID" && (values.len != 1 || pair[1].len == 0) { return Gff3Result {[],[],"ID must be single valued"}; }
                attrs.push(GffAttribute {copy(key.value),copy(values)});
            }
        }
        entries.push(GffEntry {"",features.len});
        features.push(GffFeature {copy(gff3_decode(f[0]).value),copy(gff3_decode(f[1]).value),copy(gff3_decode(f[2]).value),start-1,end,f[5] != ".",score,str(f[6]),phase,copy(attrs)});
    }
    if !header { return Gff3Result {[],[],"missing GFF3 header"}; } return Gff3Result {copy(features),copy(entries),""};
}
/*
Returns decoded values, preserving distinct ID and Parent attributes.
*/
fn gff3_values(r: GffFeature, key: u8[:]) -> u8[][] { for a in r.attributes { if a.key == key { return copy(a.values); } } return []; }
/*
Escapes attribute spaces and normalizes blanks, CRLF, trailing semicolons, and numeric
spelling. Float scores have f64 precision limits; content is preserved within the
supported subset.
*/
fn write_gff3(doc: Gff3Result) -> FormatTextResult {
    if doc.error.len > 0 { return FormatTextResult {"","cannot write failed parse"}; }
    var out: u8[>..] = []; var next = 0;
    for e in doc.entries {
        if e.feature_index < 0 {
            if e.feature_index != -1 || !genomic_cell(e.raw) || e.raw[0] != '#' { return FormatTextResult {"","invalid raw directive"}; }
            out.append(e.raw); out.push('\n'); continue;
        }
        if e.feature_index != next || next >= doc.features.len { return FormatTextResult {"","feature entry order/count mismatch"}; } let r = genomic_feature_at(doc.features,next); next += 1;
        if r.start < 0 || r.start == 9223372036854775807 || r.end <= r.start || r.phase < -1 || r.phase > 2 || r.seqid.len == 0 || r.source.len == 0 || r.kind.len == 0 { return FormatTextResult {"","invalid feature"}; }
        let f: u8[][] = [gff3_encode(r.seqid),gff3_encode(r.source),gff3_encode(r.kind),str(r.start+1),str(r.end),if r.score_known { str(r.score) } else { "." },copy(r.strand),if r.phase < 0 { "." } else { str(r.phase) }];
        for s, i in f { if i > 0 { out.push('\t'); } out.append(s); } out.push('\t');
        if r.attributes.len == 0 { out.push('.'); }
        for a, i in r.attributes {
            if a.key.len == 0 || a.values.len == 0 { return FormatTextResult {"","empty attribute"}; }
            if i > 0 { out.push(';'); } out.append(gff3_encode(a.key)); out.push('=');
            for v, j in a.values { if j > 0 { out.push(','); } out.append(gff3_encode(v)); }
        } out.push('\n');
    }
    if next != doc.features.len { return FormatTextResult {"","unwritten features"}; }
    let check = parse_gff3(out); if check.error.len > 0 { return FormatTextResult {"",copy(check.error)}; } return FormatTextResult {copy(out),""};
}

fn genomic_feature_at(fs: GffFeature[:], i: i64) -> GffFeature { for f, j in fs { if i == j { return copy(f); } } assert(false); return GffFeature {"","","",0,0,false,0.0,"",-1,[]}; }

fn genomic_number(s: u8[:]) -> bool {
    var i = 0; if s.len == 0 { return false; }
    if s[i] == '+' || s[i] == '-' { i += 1; }
    var digits = 0;
    while i < s.len && s[i] >= '0' && s[i] <= '9' { digits += 1; i += 1; }
    if i < s.len && s[i] == '.' { i += 1; while i < s.len && s[i] >= '0' && s[i] <= '9' { digits += 1; i += 1; } }
    if digits == 0 { return false; }
    if i < s.len && (s[i] == 'e' || s[i] == 'E') {
        i += 1; if i < s.len && (s[i] == '+' || s[i] == '-') { i += 1; }
        var exp_digits = 0; while i < s.len && s[i] >= '0' && s[i] <= '9' { exp_digits += 1; i += 1; }
        if exp_digits == 0 { return false; }
    } return i == s.len;
}
