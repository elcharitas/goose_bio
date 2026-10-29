namespace bio_index;
extern "bio_index_build" fn build(source: const u8[:], target: const u8[:]) -> i32;
extern "bio_index_open" fn open(target: const u8[:]) -> i64;
extern "bio_index_close" fn close(handle: i64) -> i32;
extern "bio_index_count" fn count(handle: i64) -> i64;
extern "bio_index_copy" fn native_copy(handle: i64, key: const u8[:], ordinal: i64, mode: i32, out: u8[>..]&) -> i32;
struct BytesResult { value: u8[], error: u8[] }
struct KeysResult { value: u8[][], error: u8[] }
struct Record { id: u8[], description: u8[], sequence: u8[] }
struct RecordResult { value: Record, error: u8[] }
fn get_raw(handle: i64, key: u8[:]) -> BytesResult {
    var out: u8[>..] = [];
    if native_copy(handle, key, 0, 0, out) != 0 { return BytesResult { "", "invalid handle, changed source, invalid index, or missing key" }; }
    return BytesResult { copy(out), "" };
}
fn key_at(handle: i64, ordinal: i64) -> BytesResult {
    var out: u8[>..] = [];
    if native_copy(handle, "", ordinal, 1, out) != 0 { return BytesResult { "", "invalid handle, source, index, or ordinal" }; }
    return BytesResult { copy(out), "" };
}
fn keys(handle: i64) -> KeysResult {
    let n = count(handle);
    if n < 0 { return KeysResult { [], "invalid handle, source, or index" }; }
    var out: u8[][>..] = [];
    for i in 0..n {
        let k = key_at(handle, i);
        if k.error.len > 0 { return KeysResult { [], copy(k.error) }; }
        out.push(copy(k.value));
    }
    return KeysResult { copy(out), "" };
}
fn get_record(handle: i64, key: u8[:]) -> RecordResult {
    let raw = get_raw(handle, key);
    if raw.error.len > 0 { return RecordResult { Record { "", "", "" }, copy(raw.error) }; }
    var end: i64 = 1;
    while end < raw.value.len && raw.value[end] != '\n' && raw.value[end] != '\r' { end += 1; }
    var id: u8[>..] = [];
    for c in key { id.push(c); }
    var description: u8[>..] = [];
    for i in 1..end { description.push(raw.value[i]); }
    var sequence: u8[>..] = [];
    for i in end..raw.value.len {
        let c = raw.value[i];
        if c != '\n' && c != '\r' { sequence.push(c); }
    }
    return RecordResult { Record { copy(id), copy(description), copy(sequence) }, "" };
}
