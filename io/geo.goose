namespace bio;
import std;
import .specialist_fields;
struct GeoRecord { entity_type: u8[], entity_id: u8[], attributes: SpecialistField[], columns: SpecialistField[], rows: TextRow[], raw: u8[] }
struct GeoResult { records: GeoRecord[], error: u8[] }
/*
Retains entity type/ID, ordered attributes and column definitions, tab- separated rows,
and raw text. Repeated attributes and empty trailing cells survive. Rows include the
table header; unknown attributes remain opaque.
*/
/*
Column keys must be unique. Sample/Platform table markers must balance; other marker
names remain attributes. Rows outside markers are accepted without width or numeric
checks. Multiline quoting and continuations are unsupported.
*/
/*
Empty input yields no records. Raw omits blank lines, normalizes CRLF, and ends with LF,
so it is not byte exact. Parsing buffers bytes without file handles, encoding
conversion, or network access.
*/
fn parse_geo(text: u8[:]) -> GeoResult {
    var records:    GeoRecord[>..]       = [];
    var entity_key: u8[>..]              = []; var entity_value: u8[>..] = [];
    var attrs:      SpecialistField[>..] = []; var cols: SpecialistField[>..] = [];
    var rows:       TextRow[>..]         = []; var raw: u8[>..] = [];
    var table:      u8[>..]              = [];
    for input in split(text, '\n') {
        let line = format_line(input);
        if line.len == 0 { continue; }
        if line[0] == '^' {
            if table.len > 0 { return GeoResult { [], "unclosed GEO table" }; }
            if entity_key.len > 0 { records.push(GeoRecord { copy(entity_key), copy(entity_value), copy(attrs), copy(cols), copy(rows), copy(raw) }); }
            let p = specialist_pair(line[1..], '=');
            if p.error.len > 0 || p.field.value.len == 0 { return GeoResult { [], "invalid GEO entity" }; }
            entity_key.clear(); entity_key.append(p.field.key); entity_value.clear(); entity_value.append(p.field.value); attrs.clear(); cols.clear(); rows.clear(); raw.clear();
        } else {
            if entity_key.len == 0 { return GeoResult { [], "GEO data before entity" }; }
            if line == "!Sample_table_begin" || line == "!Platform_table_begin" {
                if table.len > 0 { return GeoResult { [], "nested GEO table" }; }
                table.append(line[..line.len - 5]);
            } else if line == "!Sample_table_end" || line == "!Platform_table_end" {
                if table.len == 0 || table != line[..line.len - 3] { return GeoResult { [], "mismatched GEO table end" }; }
                table.clear();
            } else if line[0] == '!' || line[0] == '#' {
                let parsed = specialist_pair(line[1..], '=');
                let p = if parsed.error.len > 0 { SpecialistPair { SpecialistField { str(trim(line[1..])), "" }, "" } } else { copy(parsed) };
                if p.field.key.len == 0 { return GeoResult { [], "empty GEO key" }; }
                if line[0] == '!' { attrs.push(copy(p.field)); }
                else {
                    for c in cols { if c.key == p.field.key { return GeoResult { [], "duplicate GEO column" }; } }
                    cols.push(copy(p.field));
                }
            } else {
                var cells: u8[][>..] = [];
                for cell in split(line, '\t') { cells.push(str(cell)); }
                rows.push(TextRow { copy(cells) });
            }
        }
        raw.append(line); raw.push('\n');
    }
    if table.len > 0 { return GeoResult { [], "unclosed GEO table" }; }
    if entity_key.len > 0 { records.push(GeoRecord { copy(entity_key), copy(entity_value), copy(attrs), copy(cols), copy(rows), copy(raw) }); }
    return GeoResult { copy(records), "" };
}
