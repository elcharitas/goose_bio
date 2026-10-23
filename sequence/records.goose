namespace bio;
import .annotations;
import .locations;

/* Segments are sorted, nonempty, and nonoverlapping; adjacent segments are legal. Uncovered positions
 * have no bases, rather than N bases. Sequence transforms retain segment boundaries and nucleotide
 * case; extraction returns uppercase. */
struct DefinedSegment { start: i64, value: u8[] }

/* Ordered compound parts have half-open boundaries and strand 1 or -1; empty, overlapping, and
 * mixed-strand parts are legal. Origin-spanning parts use biological extraction order, such as [6,8),
 * [0,2) on length eight. Remote references reject; there is no resolver. */
struct RecordFeature {
    kind: u8[], parts: RecordLocationPart[], qualifiers: FeatureQualifier[]
}
// kind: 0 bytes, 1 integers, 2 floats; other arrays must be empty.

/* kind selects bytes (0), i64 (1), or f64 (2). Only the selected array may contain values, with length
 * equal to record length; keys must be unique. Quality values have no implicit encoding, range, or
 * probability meaning. Per-position strings, booleans, and arbitrary objects are unsupported. */
struct LetterTrack {
    key: u8[], kind: i64, bytes: u8[], integers: i64[], floats: f64[]
}
// topology: 0 linear, 1 circular. Parts retain extraction order.

/* Length is explicitly nonnegative. Empty and fully undefined sequences are legal. DNA and RNA use
 * existing IUPAC alphabets; proteins are unsupported. Topology is 0 linear or 1 circular, without
 * implicit wrapping or origin rotation. */
struct RichRecord {
    id: u8[], description: u8[], length: i64, segments: DefinedSegment[],
    metadata: FeatureQualifier[], features: RecordFeature[],
    tracks: LetterTrack[], rna: bool, topology: i64
}
struct RichRecordResult { record: RichRecord, error: u8[] }

/* Scans segments, features, and tracks before record operations. Positions are
 * exact/before/after/unknown (0/1/2/3); unknown requires value zero. Other position kinds reject.
 * Low-level position helpers require valid inputs and bounds. Duplicate track detection uses
 * quadratic scans. */
fn validate_rich_record(r: RichRecord) -> u8[] {
    if r.length < 0 || r.topology < 0 || r.topology > 1 { return "invalid length or topology"; }
    var end: i64 = 0;
    for s in r.segments {
        if s.start < end || s.start > r.length || s.value.len == 0 ||
           s.value.len > r.length - s.start { return "invalid or overlapping defined segment"; }
        if normalize_sequence(s.value, r.rna).error.len > 0 { return "invalid nucleotide"; }
        end = s.start + s.value.len;
    }
    for f in r.features {
        let error = validate_record_parts(f.parts, r.length);
        if error.len > 0 { return copy(error); }
    }
    for t, i in r.tracks {
        for other, j in r.tracks { if j < i && other.key == t.key { return "duplicate track key"; } }
        if t.kind == 0 {
            if t.bytes.len != r.length || t.integers.len != 0 || t.floats.len != 0 { return "invalid byte track"; }
        } else if t.kind == 1 {
            if t.integers.len != r.length || t.bytes.len != 0 || t.floats.len != 0 { return "invalid integer track"; }
        } else if t.kind == 2 {
            if t.floats.len != r.length || t.bytes.len != 0 || t.integers.len != 0 { return "invalid float track"; }
        } else { return "unknown track kind"; }
    }
    return "";
}
fn rich_record_from_annotated(r: AnnotatedRecord) -> RichRecordResult {
    var features: RecordFeature[>..] = [];
    for f in r.features {
        var parts: RecordLocationPart[>..] = [];
        for p in f.parts {
            parts.push(RecordLocationPart { RecordPosition { 0, p.start },
                RecordPosition { 0, p.end }, p.strand, "" });
        }
        features.push(RecordFeature { copy(f.kind), copy(parts), copy(f.qualifiers) });
    }
    var segments: DefinedSegment[>..] = [];
    if r.sequence.len > 0 { segments.push(DefinedSegment { 0, copy(r.sequence) }); }
    let out = RichRecord { copy(r.id), copy(r.description), r.sequence.len,
        copy(segments), copy(r.metadata), copy(features), [], r.rna, 0 };
    return RichRecordResult { copy(out), validate_annotated_record(copy(r)) };
}

/* Materializes only a fully defined selected interval. Data and outputs are buffered without streaming
 * or a configured allocation cap; available memory and signed i64 coordinates limit inputs. Extraction
 * allocates proportional to output length. */
fn rich_sequence_slice(r: RichRecord, start: i64, end: i64) -> SequenceResult {
    let error = validate_rich_record(copy(r));
    if error.len > 0 { return SequenceResult { "", copy(error) }; }
    if start < 0 || end < start || end > r.length { return SequenceResult { "", "invalid slice bounds" }; }
    var out: u8[>..] = [];
    var cursor = start;
    for s in r.segments {
        if cursor == end { break; }
        if s.start > cursor { break; }
        let stop = if s.start + s.value.len < end { s.start + s.value.len } else { end };
        if stop > cursor {
            out.append(s.value[cursor - s.start..stop - s.start]); cursor = stop;
        }
    }
    if cursor != end { return SequenceResult { "", "selected sequence contains undefined bases" }; }
    return SequenceResult { copy(out), "" };
}
// numeric_fuzzy explicitly uses stored before/after numeric bounds.

/* Requires known boundaries and rejects fuzzy positions by default. numeric_fuzzy=true uses stored
 * before/after numeric bounds without changing tags. Unknown positions always fail; errors return no
 * partial sequence. Compound extraction revalidates the record for each part. */
fn extract_rich_feature(r: RichRecord, f: RecordFeature, numeric_fuzzy: bool = false) -> SequenceResult {
    let error = validate_record_parts(f.parts, r.length);
    if error.len > 0 { return SequenceResult { "", copy(error) }; }
    var out: u8[>..] = [];
    for p in f.parts {
        if p.start.kind == 3 || p.end.kind == 3 { return SequenceResult { "", "unknown extraction boundary" }; }
        if !numeric_fuzzy && (p.start.kind != 0 || p.end.kind != 0) {
            return SequenceResult { "", "fuzzy extraction requires numeric_fuzzy" };
        }
        let selected = rich_sequence_slice(copy(r), p.start.value, p.end.value);
        if selected.error.len > 0 { return copy(selected); }
        if p.strand == -1 { out.append(reverse_complement(selected.value, r.rna).value); }
        else { out.append(normalize_sequence(selected.value, r.rna).value); }
    }
    return SequenceResult { copy(out), "" };
}

/* Reversal reverses track values without complementing them; slicing selects the same interval. Track
 * transforms allocate proportional to output length. */
fn transform_letter_track(t: LetterTrack, start: i64, end: i64, reverse: bool) -> LetterTrack {
    var bytes: u8[>..] = []; var integers: i64[>..] = []; var floats: f64[>..] = [];
    for n in end - start {
        let i = if reverse { end - n - 1 } else { start + n };
        if t.kind == 0 { bytes.push(t.bytes[i]); }
        if t.kind == 1 { integers.push(t.integers[i]); }
        if t.kind == 2 { floats.push(t.floats[i]); }
    }
    LetterTrack { copy(t.key), t.kind, copy(bytes), copy(integers), copy(floats) }
}

fn reverse_defined_segment(text: u8[:], rna: bool) -> u8[] {
    let complemented = reverse_complement(text, rna);
    let bases = complemented.value;
    var out: u8[>..] = [];
    for b, i in bases {
        let original = text[text.len - i - 1];
        out.push(if original >= 'a' && original <= 'z' { b + 32 } else { b });
    }
    return copy(out);
}

/* Retains compound-part order while reversing each strand. Reversal exchanges before/after, maps
 * known positions to length-value, and preserves unknowns. IDs, descriptions, metadata, and
 * qualifiers remain verbatim; coordinate metadata can become stale. Double reversal retains
 * segments, tracks, feature order, positions, metadata, topology, and lowercase case. */
fn reverse_complement_rich_record(r: RichRecord) -> RichRecordResult {
    let error = validate_rich_record(copy(r));
    if error.len > 0 { return RichRecordResult { copy(r), copy(error) }; }
    var segments: DefinedSegment[>..] = [];
    /* Reversal scans the segment list for each output segment: O(segments^2). */
    for i in r.segments.len {
      for s, j in r.segments {
        if j != r.segments.len - i - 1 { continue; }
        segments.push(DefinedSegment { r.length - s.start - s.value.len,
            reverse_defined_segment(s.value, r.rna) });
      }
    }
    var features: RecordFeature[>..] = [];
    for f in r.features {
        var parts: RecordLocationPart[>..] = [];
        for p in f.parts {
            parts.push(RecordLocationPart { flip_record_position(copy(p.end), r.length),
                flip_record_position(copy(p.start), r.length), -p.strand, "" });
        }
        features.push(RecordFeature { copy(f.kind), copy(parts), copy(f.qualifiers) });
    }
    var tracks: LetterTrack[>..] = [];
    for t in r.tracks { tracks.push(transform_letter_track(copy(t), 0, r.length, true)); }
    return RichRecordResult { RichRecord { copy(r.id), copy(r.description), r.length,
        copy(segments), copy(r.metadata), copy(features), copy(tracks), r.rna, r.topology }, "" };
}

/* Proper slices become linear; full slices retain topology. Wholly excluded features drop, but
 * cutting any part or compound feature rejects. Any unknown feature boundary prevents slicing. Fuzzy
 * inclusion uses stored numeric bounds and retains tags; known positions shift without changing
 * tags. IDs, descriptions, metadata, and qualifiers remain verbatim and can become stale. */
fn slice_rich_record(r: RichRecord, start: i64, end: i64) -> RichRecordResult {
    let error = validate_rich_record(copy(r));
    if error.len > 0 { return RichRecordResult { copy(r), copy(error) }; }
    if start < 0 || end < start || end > r.length { return RichRecordResult { copy(r), "invalid slice bounds" }; }
    var features: RecordFeature[>..] = [];
    for f in r.features {
        var inside = false; var outside = false;
        var parts: RecordLocationPart[>..] = [];
        for p in f.parts {
            if p.start.kind == 3 || p.end.kind == 3 { return RichRecordResult { copy(r), "cannot slice unknown feature boundaries" }; }
            if p.start.value >= start && p.end.value <= end && (start != end || r.length == 0) {
                inside = true;
                parts.push(RecordLocationPart { shift_record_position(copy(p.start), start),
                    shift_record_position(copy(p.end), start), p.strand, "" });
            } else if p.end.value > start && p.start.value < end {
                return RichRecordResult { copy(r), "slice cuts feature" };
            } else { outside = true; }
        }
        if inside && outside { return RichRecordResult { copy(r), "slice cuts compound feature" }; }
        if inside { features.push(RecordFeature { copy(f.kind), copy(parts), copy(f.qualifiers) }); }
    }
    var segments: DefinedSegment[>..] = [];
    for s in r.segments {
        let a = if s.start > start { s.start } else { start };
        let b = if s.start + s.value.len < end { s.start + s.value.len } else { end };
        if a < b { segments.push(DefinedSegment { a - start, str(s.value[a - s.start..b - s.start]) }); }
    }
    var tracks: LetterTrack[>..] = [];
    for t in r.tracks { tracks.push(transform_letter_track(copy(t), start, end, false)); }
    let topology = if start == 0 && end == r.length { r.topology } else { 0 };
    return RichRecordResult { RichRecord { copy(r.id), copy(r.description), end - start,
        copy(segments), copy(r.metadata), copy(features), copy(tracks), r.rna, topology }, "" };
}
