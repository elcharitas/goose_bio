// Ordered MEDLINE keys retain lists for unknown fields.
namespace bio;
import std;
import .formats;
struct MedlineField { key: u8[], values: u8[][], text: bool }
/* Keys keep first occurrence order. Text keys, including TI, AB, PMID, and JT, join repeated
 * values/continuations with spaces; unknown keys retain lists. */
struct MedlineRecord { fields: MedlineField[] }
struct MedlineResult { records: MedlineRecord[], error: u8[] }
struct MedlineReadResult { record: MedlineRecord, error: u8[] }
fn medline_text_key(key: u8[:]) -> bool {
    for k in split("ID PMID SO RF NI JC TA IS CY TT CA IP VI DP YR PG LID DA LR OWN STAT DCOM PUBM DEP PL JID SB PMC EDAT MHDA PST AB EA TI JT", ' ') { if k == key { return true; } }
    return false;
}
fn medline_finish(fields: MedlineField[:]) -> MedlineRecord {
    var result: MedlineField[>..] = [];
    for f in fields {
        if f.text {
            var joined: u8[>..] = [];
            for v, i in f.values { if i > 0 { joined.push(' '); } joined.append(v); }
            result.push(MedlineField { copy(f.key), [copy(joined)], true });
        } else { result.push(copy(f)); }
    }
    return MedlineRecord { copy(result) };
}
/*
Requires four-column keys and the conventional - prefix; orphan continuations fail. Six-
space continuations add list items, except AD/MH extend the last item. Blank
continuations retain newline values; trailing spaces are removed and leading payload
spaces survive.
*/
/*
Accepts CRLF/LF and a final record without a blank separator. Whole-input parsing and
repeated field updates can be quadratic. No writer, streaming, schema/author model,
Unicode normalization, file, or network API.
*/
fn parse_medline(text: u8[:]) -> MedlineResult {
    var records: MedlineRecord[>..] = []; var fields: MedlineField[>..] = [];
    var last = -1;
    for raw in split(text,'\n') {
        let line = format_line(raw);
        if line.len == 0 {
            if fields.len > 0 { records.push(medline_finish(fields)); fields.clear(); last = -1; }
            continue;
        }
        let continuation = line.len >= 6 && line[..6] == "      ";
        var key: u8[>..] = []; var value: u8[>..] = [];
        if continuation {
            if last < 0 { return MedlineResult { [], "continuation without field" }; }
            for f, i in fields { if i == last { key.append(f.key); } } value.append(medline_rstrip(line[6..]));
            if trim(line).len == 0 { value.clear(); value.append("\n"); }
        } else {
            if line.len < 6 || line[4] != '-' || line[5] != ' ' { return MedlineResult { [], "invalid MEDLINE field prefix" }; }
            key.append(trim(line[..4])); value.append(medline_rstrip(line[6..]));
            if key.len == 0 { return MedlineResult { [], "empty MEDLINE key" }; }
        }
        var index = -1;
        for f, i in fields { if f.key == key { index = i; } }
        if index < 0 { fields.push(MedlineField { copy(key), [], medline_text_key(key) }); index = fields.len-1; }
        var updated: MedlineField[>..] = [];
        for f, i in fields {
            if i != index { updated.push(copy(f)); continue; }
            var values: u8[][>..] = [];
            for v, j in f.values {
                if continuation && (key == "AD" || key == "MH") && j == f.values.len-1 {
                    var joined: u8[>..] = []; joined.append(v); joined.push(' '); joined.append(value); values.push(copy(joined));
                } else { values.push(copy(v)); }
            }
            if !continuation || (key != "AD" && key != "MH") { values.push(copy(value)); }
            updated.push(MedlineField { copy(key), copy(values), f.text });
        }
        fields.clear(); fields.append(updated); last = index;
    }
    if fields.len > 0 { records.push(medline_finish(fields)); }
    return MedlineResult { copy(records), "" };
}
/*
Reads only the first record and ignores even malformed later text. Empty input returns
an error.
*/
fn read_medline(text: u8[:]) -> MedlineReadResult {
    // Stop at the first record boundary.
    var first: u8[>..] = []; var started = false;
    for raw in split(text,'\n') {
        let line = format_line(raw);
        if line.len == 0 { if started { break; } continue; }
        started = true; first.append(line); first.push('\n');
    }
    let parsed = parse_medline(first);
    if parsed.error.len > 0 { return MedlineReadResult { MedlineRecord { [] }, copy(parsed.error) }; }
    if parsed.records.len == 0 { return MedlineReadResult { MedlineRecord { [] }, "no MEDLINE record" }; }
    for r in parsed.records { return MedlineReadResult { copy(r), "" }; }
    return MedlineReadResult { MedlineRecord { [] }, "no MEDLINE record" };
}

fn medline_rstrip(value: u8[:]) -> u8[:] {
    var end = value.len;
    while end > 0 && (value[end-1] == ' ' || value[end-1] == '\t' || value[end-1] == '\r') { end -= 1; }
    return value[..end];
}
