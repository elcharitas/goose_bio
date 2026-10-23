namespace bio;

// kind: 0 exact, 1 before, 2 after, 3 unknown (value must be zero).

/* kind is 0 exact, 1 before, 2 after, or 3 unknown. Unknown values must be zero. Other position
 * kinds are unsupported. */
struct RecordPosition { kind: i64, value: i64 }

/* Half-open boundaries use strand 1 or -1. Empty, overlapping, and mixed-strand parts are legal;
 * remote references reject. There is no implicit circular wrapping. */
struct RecordLocationPart {
    start: RecordPosition, end: RecordPosition, strand: i64,
    remote: u8[]
}
fn validate_record_position(p: RecordPosition, length: i64) -> bool {
    if p.kind == 3 { return p.value == 0; }
    return p.kind >= 0 && p.kind <= 2 && p.value >= 0 && p.value <= length;
}
fn validate_record_parts(parts: RecordLocationPart[:], length: i64) -> u8[] {
    if length < 0 || parts.len == 0 { return "empty location or invalid length"; }
    for p in parts {
        if p.remote.len > 0 { return "remote locations are unsupported"; }
        if p.strand != 1 && p.strand != -1 { return "strand must be 1 or -1"; }
        if !validate_record_position(copy(p.start), length) ||
           !validate_record_position(copy(p.end), length) { return "invalid position"; }
        if p.start.kind != 3 && p.end.kind != 3 && p.start.value > p.end.value {
            return "reversed location boundaries";
        }
    }
    return "";
}

/* Requires valid positions and bounds. Known values map to length-value and before/after exchange;
 * unknown remains unknown. */
fn flip_record_position(p: RecordPosition, length: i64) -> RecordPosition {
    if p.kind == 3 { return copy(p); }
    let kind = if p.kind == 1 { 2 } else if p.kind == 2 { 1 } else { p.kind };
    RecordPosition { kind, length - p.value }
}

/* Requires valid positions and bounds. Subtracts the offset from known values without changing tags.
 */
fn shift_record_position(p: RecordPosition, offset: i64) -> RecordPosition {
    RecordPosition { p.kind, if p.kind == 3 { 0 } else { p.value - offset } }
}
