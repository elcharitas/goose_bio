namespace bio;
import std;
import .formats;
struct SpecialistField { key: u8[], value: u8[] }
struct SpecialistPair { field: SpecialistField, error: u8[] }
fn specialist_pair(text: u8[:], separator: u8) -> SpecialistPair {
    for c, i in text {
        if c == separator {
            let key = trim(text[..i]);
            if key.len == 0 { break; }
            return SpecialistPair { SpecialistField { str(key), str(trim(text[i + 1..])) }, "" };
        }
    }
    return SpecialistPair { SpecialistField { "", "" }, "missing metadata separator" };
}
fn specialist_uint(text: u8[:]) -> i64, bool {
    if text.len == 0 { return 0, false; }
    for c in text { if c < '0' || c > '9' { return 0, false; } }
    return parse_int(text);
}
fn specialist_line(text: u8[:]) -> bool {
    for c in text { if c == '\n' || c == '\r' || c == 0 { return false; } }
    return true;
}
