// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import math;
import .alignment_io;
struct CelField { section: u8[], key: u8[], value: u8[] }
/*
Cell arrays are flat row-major [Y*ncols+X]. Metadata preserves section/key/raw value,
including DatHeader control bytes and extra fields. DatHeader has no parsed dictionary.
Whole-input copies and duplicate checks may be quadratic; caps do not bound total
memory/time.
*/
struct CelRecord { version: i64, nrows: i64, ncols: i64, cell_count: i64, intensities: f64[], stdevs: f64[], pixels: i64[], mask: bool[], outliers: bool[], modified: f64[], metadata: CelField[] }
struct CelResult { record: CelRecord, error: u8[] }
fn cel_fail(s: u8[:]) -> CelResult { return CelResult { CelRecord { 0,0,0,0,[],[],[],[],[],[],[] }, str(s) }; }
fn cel_integer(s: u8[:]) -> i64 { if s.len == 0 || s.len > 20 { return -9223372036854775807; } var p = 0; if s[0] == '-' || s[0] == '+' { p = 1; } if p == s.len { return -9223372036854775807; } for b in s[p..] { if b < '0' || b > '9' { return -9223372036854775807; } } let n, ok = parse_int(s); if !ok { return -9223372036854775807; } return n; }
fn cel_finite(x: f64) -> bool { return !is_nan(x) && !is_inf(x); }
fn cel_u32(b: u8[:], p: i64) -> i64 { return b[p]+(b[p+1] as i64)*256+(b[p+2] as i64)*65536+(b[p+3] as i64)*16777216; }
fn cel_float(b: u8[:], p: i64) -> f64 {
    let bits = cel_u32(b,p); let e = (bits/8388608)%256; let m = bits%8388608;
    if e == 255 { return log(0.0); }
    var v = if e == 0 { (m as f64) } else { ((m+8388608) as f64) };
    var power = if e == 0 { -149 } else { e-150 };
    while power < 0 { v *= 0.5; power += 1; }
    while power > 0 { v *= 2.0; power -= 1; }
    return if bits >= 2147483648 { -v } else { v };
}
/*
Detects v3 text or v4 binary; errors return an empty record. Input is capped at 64 MiB
and one million cells; products/counts validate before allocation. Lines/metadata fields
cap at 65,536 bytes/count, binary metadata at 1 MiB.
*/
/* No CEL writer, Calvin, chip design, normalization, or expression analysis. Bio.CelFile source
 * credits Harry Zuzan and Adam Kurkiewicz under Biopython/BSD terms. */
fn parse_affy_cel(data: u8[:]) -> CelResult {
    if data.len == 0 || data.len > 67108864 { return cel_fail("CEL input limit"); }
    if data.len >= 4 && cel_u32(data,0) == 64 { return cel_binary(data); }
    return cel_text(data);
}
/*
V4 reads little-endian preheaders and cross-checks Rows/Cols, requiring zero
axes/offsets. Delimiter 0x04 must occur within scan offsets 0-9,999, followed by exactly
15 opaque padding bytes. Truncated padding/cells fail before allocation.
*/
/*
Each cell uses float32 intensity/stdev plus int16 pixels (10 bytes). Binary32
reconstruction exactly represents finite values, subnormals, and signed zero in
binary64. Optional arrays stay zero-length; trailing bytes are ignored. Use version to
distinguish unavailable v4 arrays from absent v3 sections.
*/
fn cel_binary(data: u8[:]) -> CelResult {
    if data.len < 24 { return cel_fail("truncated binary header"); }
    let version = cel_u32(data,4); let cols = cel_u32(data,8); let rows = cel_u32(data,12); let n = cel_u32(data,16); let length = cel_u32(data,20);
    if version != 4 || rows < 1 || cols < 1 || rows > 1000000 || cols > 1000000 || rows*cols != n || n > 1000000 || length > data.len-24 { return cel_fail("invalid binary dimensions/header"); }
    var fields: CelField[>..] = [];
    if length > 1048576 { return cel_fail("binary metadata limit"); }
    for line in split(data[24..24+length], '\n') { if line.len == 0 { continue; } let parts = split(line,'='); if parts.len < 2 { return cel_fail("invalid binary metadata"); } let key = parts[0]; let value = line[key.len+1..];
        for f in fields { if f.key == key { return cel_fail("duplicate metadata"); } }
        fields.push(CelField { "HEADER",str(key),str(value) });
    }
    for key in ["Rows","Cols","GridCornerUL","GridCornerUR","GridCornerLR","GridCornerLL","DatHeader","Algorithm","AlgorithmParameters","Axis-invertX","AxisInvertY","OffsetX","OffsetY"] {
        var found = false; for f in fields { if f.key == key { found = true;
            if key == "Rows" && cel_integer(f.value) != rows { return cel_fail("row mismatch"); }
            if key == "Cols" && cel_integer(f.value) != cols { return cel_fail("column mismatch"); }
            if (key == "Axis-invertX" || key == "AxisInvertY" || key == "OffsetX" || key == "OffsetY") && cel_integer(f.value) != 0 { return cel_fail("unsupported axis/offset"); }
        } } if !found { return cel_fail("missing binary metadata"); }
    }
    var p = 24+length; var scanned = 0;
    while p < data.len && scanned < 10000 && data[p] != 4 { p += 1; scanned += 1; }
    if p >= data.len || scanned == 10000 || data[p] != 4 { return cel_fail("missing bounded binary delimiter"); }
    p += 16;
    if p > data.len || n > (data.len-p)/10 { return cel_fail("truncated binary cells/padding"); }
    var a: f64[>..] = []; var s: f64[>..] = []; var pixels: i64[>..] = [];
    for i in 0..n { let x = cel_float(data,p); let y = cel_float(data,p+4); var z = data[p+8]+256*(data[p+9] as i64); if z >= 32768 { z -= 65536; }
        if !cel_finite(x) || !cel_finite(y) || y < 0.0 { return cel_fail("nonfinite cell or negative stdev"); }
        a.push(x); s.push(y); pixels.push(z); p += 10;
    }
    return CelResult { CelRecord { 4,rows,cols,n,copy(a),copy(s),copy(pixels),[],[],[],copy(fields) }, "" };
}
/*
V3 uses zero-based X,Y coordinates; rectangular/shuffled intensity grids must be
complete and unique. Optional sections require unique coordinates and matching counts.
Empty sections yield full zero arrays; absent sections yield zero-length arrays.
*/
fn cel_text(data: u8[:]) -> CelResult {
    var fields: CelField[>..] = []; var section: u8[>..] = []; var sections: u8[][>..] = [];
    var rows = 0; var cols = 0; var n = 0; var expected = -1; var count = 0; var header = false;
    var a: f64[>..] = []; var s: f64[>..] = []; var pixels: i64[>..] = [];
    var mask: bool[>..] = []; var outlier: bool[>..] = []; var modified: f64[>..] = []; var seen: bool[>..] = [];
    for raw in split(data,'\n') {
        let line = if raw.len > 0 && raw[raw.len-1] == '\r' { raw[..raw.len-1] } else { raw }; if trim(line).len == 0 { continue; }
        if line.len > 65536 || fields.len >= 65536 { return cel_fail("text metadata/line limit"); }
        if line[0] == '[' {
            if section != "" && section != "CEL" && section != "HEADER" && (expected != count || !header) { return cel_fail("incomplete CEL section"); }
            if line != "[CEL]" && line != "[HEADER]" && line != "[INTENSITY]" && line != "[MASKS]" && line != "[OUTLIERS]" && line != "[MODIFIED]" { return cel_fail("unknown section"); }
            if n > 0 && (line == "[CEL]" || line == "[HEADER]") { return cel_fail("header after data"); }
            section.clear(); section.append(line[1..line.len-1]); for old in sections { if old == section { return cel_fail("duplicate section"); } } sections.push(copy(section));
            if (sections.len == 2 && section != "HEADER") || (sections.len == 3 && section != "INTENSITY") || (sections.len == 1 && section != "CEL") { return cel_fail("missing CEL section"); }
            if section == "INTENSITY" {
                var valid_version = false; for f in fields { if f.section == "CEL" && f.key == "Version" { valid_version = true; } }
                if !valid_version { return cel_fail("missing version"); }
                if rows < 1 || cols < 1 || rows > 1000000 || cols > 1000000 || rows*cols > 1000000 { return cel_fail("CEL dimensions limit"); }
                n = rows*cols; for i in 0..n { a.push(0.0); s.push(0.0); pixels.push(0); }
            } else if section != "CEL" && section != "HEADER" && n == 0 { return cel_fail("section before intensity"); }
            seen.clear(); if n > 0 { for i in 0..n { seen.push(false); } }
            if section == "MASKS" { for i in 0..n { mask.push(false); } }
            if section == "OUTLIERS" { for i in 0..n { outlier.push(false); } }
            if section == "MODIFIED" { for i in 0..n { modified.push(0.0); } }
            expected = -1; count = 0; header = false; continue;
        }
        if section.len == 0 { return cel_fail("data before CEL section"); }
        let parts = split(line,'=');
        if parts.len >= 2 {
            let key = parts[0]; let value = line[key.len+1..];
            for f in fields { if f.section == section && f.key == key { return cel_fail("duplicate field"); } }
            fields.push(CelField { copy(section),str(key),str(value) });
            if section == "CEL" { if key != "Version" || value != "3" { return cel_fail("invalid version"); } }
            else if section == "HEADER" { if key == "Rows" { rows = cel_integer(value); } if key == "Cols" { cols = cel_integer(value); } }
            else if key == "NumberCells" { expected = cel_integer(value); if expected < 0 || expected > n || (section == "INTENSITY" && expected != n) { return cel_fail("invalid cell count"); } }
            else if key == "CellHeader" {
                let ww = alignment_words(value); var words: u8[:][>..] = []; for v in ww.fields { words.push(v); } let want = if section == "INTENSITY" { "X Y MEAN STDV NPIXELS" } else if section == "MODIFIED" { "X Y ORIGMEAN" } else { "X Y" };
                let dd = alignment_words(want); var desired: u8[:][>..] = []; for v in dd.fields { desired.push(v); } if words.len != desired.len { return cel_fail("invalid CellHeader"); } for w,i in words { if w != desired[i] { return cel_fail("invalid CellHeader"); } } header = true;
            } else { return cel_fail("unknown section field"); }
            continue;
        }
        if n == 0 || !header || expected < 0 || count >= expected { return cel_fail("unexpected cell data"); }
        let tokens = alignment_words(line); var w: u8[:][>..] = []; for v in tokens.fields { w.push(v); } let size = if section == "INTENSITY" { 5 } else if section == "MODIFIED" { 3 } else { 2 };
        if w.len != size { return cel_fail("invalid cell row"); }
        let x = cel_integer(w[0]); let y = cel_integer(w[1]); if x < 0 || y < 0 || x >= cols || y >= rows { return cel_fail("invalid cell coordinate"); }
        let i = y*cols+x; if seen[i] { return cel_fail("duplicate cell coordinate"); } seen[i] = true;
        if section == "INTENSITY" || section == "MODIFIED" {
            let v,ok = cel_decimal(w[2]); if !ok || !cel_finite(v) { return cel_fail("invalid cell number"); }
            if section == "MODIFIED" { modified[i] = v; } else {
                let sd,valid = cel_decimal(w[3]); let px = cel_integer(w[4]); if !valid || !cel_finite(sd) || sd < 0.0 || px < -32768 || px > 32767 { return cel_fail("invalid stdev/pixels"); }
                a[i] = v; s[i] = sd; pixels[i] = px;
            }
        } else if section == "MASKS" { mask[i] = true; } else if section == "OUTLIERS" { outlier[i] = true; } else { return cel_fail("invalid cell section"); }
        count += 1;
    }
    var version = false; for f in fields { if f.section == "CEL" && f.key == "Version" { version = true; } }
    if !version || n == 0 || expected != count || !header { return cel_fail("incomplete CEL"); }
    for field in fields { if field.section == "HEADER" && (field.key == "GridCornerUL" || field.key == "GridCornerUR" || field.key == "GridCornerLR" || field.key == "GridCornerLL") {
        let words = alignment_words(field.value); if words.fields.len != 2 { return cel_fail("invalid corner"); } for w in words.fields { let v,ok = parse_int(w); if !ok { return cel_fail("invalid corner"); } }
    } }
    let params = cel_algorithm_parameters(copy(fields)); if params.error.len > 0 { return cel_fail(params.error); }
    return CelResult { CelRecord { 3,rows,cols,n,copy(a),copy(s),copy(pixels),copy(mask),copy(outlier),copy(modified),copy(fields) }, "" };
}
struct CelParameter { key: u8[], kind: i64, text: u8[], integer: i64, number: f64, boolean: bool }
struct CelParameters { values: CelParameter[], error: u8[] }
/*
V3 known parameter names select kind 0 text, 1 integer, 2 number, or 3 boolean; unknown
names remain text and raw spelling survives. V4 parameters remain raw and must not use
this typing helper.
*/
fn cel_algorithm_parameters(fields: CelField[]) -> CelParameters {
    var result: CelParameter[>..] = [];
    for field in fields { if field.key == "AlgorithmParameters" && field.section == "HEADER" {
        for item in split(field.value,';') {
            let pair = split(item,':'); if pair.len < 2 { return CelParameters { [], "invalid algorithm parameter" }; }
            let key = pair[0]; let value = item[key.len+1..]; var kind = 0;
            for old in result { if old.key == key { return CelParameters { [], "duplicate algorithm parameter" }; } }
            for tag in ["Percentile","CellMargin","FullFeatureWidth","FullFeatureHeight","PoolWidthExtenstion","PoolHeightExtension","NumPixelsToUse","ExtendPoolWidth","ExtendPoolHeight","OutlierRatioLowPercentile","OutlierRatioHighPercentile","HalfCellRowsDivisor","HalfCellRowsRemainder","HighCutoff","LowCutoff","featureRows","featureColumns"] { if key == tag { kind = 1; } }
            for tag in ["OutlierHigh","OutlierLow","StdMult","PercentileSpread","PairCutoff","featureWidth","featureHeight"] { if key == tag { kind = 2; } }
            for tag in ["FixedCellSize","IgnoreOutliersInShiftRows","FeatureExtraction","UseSubgrids","RandomizePixels","ImageCalibration","IgnoreShiftRowOutliers"] { if key == tag { kind = 3; } }
            var integer = 0; var number = 0.0; var boolean = false;
            if kind == 1 { let v,ok = parse_int(value); if !ok { return CelParameters { [],"invalid integer parameter" }; } integer = v; }
            if kind == 2 { let v,ok = cel_decimal(value); if !ok || !cel_finite(v) { return CelParameters { [],"invalid numeric parameter" }; } number = v; }
            if kind == 3 { if value != "TRUE" && value != "FALSE" { return CelParameters { [],"invalid boolean parameter" }; } boolean = value == "TRUE"; }
            result.push(CelParameter { str(key),kind,str(value),integer,number,boolean });
        }
    } }
    return CelParameters { copy(result),"" };
}

/*
Strict decimal grammar caps tokens at 768 bytes before Goose conversion. Finite negative
intensities/modified means, signed zero, and underflow are accepted; stdev is
nonnegative and pixels fit signed i16. Invalid syntax, overflow, NaN, and infinity fail.
*/
/* Decimal conversion uses binary64 and need not be correctly rounded; large values can lose low-
 * order precision. */
fn cel_decimal(text: u8[:]) -> f64, bool {
    if text.len == 0 || text.len > 768 { return 0.0, false; }
    var p = 0; if text[p] == '+' || text[p] == '-' { p += 1; }
    var digits = 0;
    while p < text.len && text[p] >= '0' && text[p] <= '9' { digits += 1; p += 1; }
    if p < text.len && text[p] == '.' { p += 1; while p < text.len && text[p] >= '0' && text[p] <= '9' { digits += 1; p += 1; } }
    if digits == 0 { return 0.0, false; }
    if p < text.len && (text[p] == 'e' || text[p] == 'E') {
        p += 1; if p < text.len && (text[p] == '+' || text[p] == '-') { p += 1; }
        var exponent_digits = 0;
        while p < text.len && text[p] >= '0' && text[p] <= '9' { exponent_digits += 1; p += 1; }
        if exponent_digits == 0 { return 0.0, false; }
    }
    if p != text.len { return 0.0, false; }
    let x,ok = parse_flt(text); return x, ok && cel_finite(x);
}
struct CelCorner { present: bool, x: i64, y: i64, error: u8[] }
/*
V3 corners validate as two signed integers and return an explicit presence flag. V4
corner strings remain raw.
*/
fn cel_corner(record: CelRecord, key: u8[:]) -> CelCorner {
    for f in record.metadata { if f.section == "HEADER" && f.key == key {
        let words = alignment_words(f.value); if words.fields.len != 2 { return CelCorner { true,0,0,"invalid corner" }; }
        var values: i64[>..] = [];
        for w in words.fields { let v,ok = parse_int(w); if !ok { return CelCorner { true,0,0,"invalid corner" }; } values.push(v); }
        return CelCorner { true,values[0],values[1],"" };
    } }
    return CelCorner { false,0,0,"" };
}
