// Exact nucleotide annotations only; no location text parser or writer.
// Parts can overlap and mix strands; caller supplies biological order.
// Metadata is copied verbatim; coordinate-bearing qualifiers are opaque.
// Record operations do not model quality, topology, or remote references.
namespace bio;
import .sequence;

// Parts are in biological extraction order, not coordinate order.
struct LocationPart { start: i64, end: i64, strand: i64, fuzzy: bool }
struct FeatureQualifier { key: u8[], values: u8[][] }
struct AnnotatedFeature {
    kind: u8[], parts: LocationPart[], qualifiers: FeatureQualifier[]
}
struct AnnotatedRecord {
    id: u8[], description: u8[], sequence: u8[],
    metadata: FeatureQualifier[], features: AnnotatedFeature[], rna: bool
}
struct AnnotatedRecordResult { record: AnnotatedRecord, error: u8[] }

// Exact, nonempty, half-open parts; fuzzy and unknown strands fail.
fn validate_location(parts: LocationPart[:], length: i64) -> u8[] {
    if length < 0 || parts.len == 0 { return "empty location or invalid length"; }
    for p in parts {
        if p.fuzzy { return "fuzzy positions are unsupported"; }
        if p.strand != 1 && p.strand != -1 { return "strand must be 1 or -1"; }
        if p.start < 0 || p.end <= p.start || p.end > length {
            return "location outside sequence or empty part";
        }
    }
    return "";
}

fn extract_feature(text: u8[:], feature: AnnotatedFeature, rna: bool = false) -> SequenceResult {
    let error = validate_location(feature.parts, text.len);
    if error.len > 0 { return SequenceResult { "", copy(error) }; }
    let normalized = normalize_sequence(text, rna);
    if normalized.error.len > 0 { return copy(normalized); }
    var out: u8[>..] = [];
    for p in feature.parts {
        if p.strand == 1 { out.append(normalized.value[p.start..p.end]); }
        else { out.append(reverse_complement(normalized.value[p.start..p.end], rna).value); }
    }
    return SequenceResult { copy(out), "" };
}

fn validate_annotated_record(record: AnnotatedRecord) -> u8[] {
    let sequence = normalize_sequence(record.sequence, record.rna);
    if sequence.error.len > 0 { return copy(sequence.error); }
    for f in record.features {
        let error = validate_location(f.parts, record.sequence.len);
        if error.len > 0 { return copy(error); }
    }
    return "";
}

// Keep part order so extraction is invariant under record reversal.
fn reverse_complement_record(record: AnnotatedRecord) -> AnnotatedRecordResult {
    let error = validate_annotated_record(copy(record));
    if error.len > 0 { return AnnotatedRecordResult { copy(record), copy(error) }; }
    var features: AnnotatedFeature[>..] = [];
    for f in record.features {
        var parts: LocationPart[>..] = [];
        for p in f.parts {
            parts.push(LocationPart { record.sequence.len - p.end,
                record.sequence.len - p.start, -p.strand, false });
        }
        features.push(AnnotatedFeature { copy(f.kind), copy(parts), copy(f.qualifiers) });
    }
    return AnnotatedRecordResult { AnnotatedRecord { copy(record.id),
        copy(record.description), copy(reverse_complement(record.sequence, record.rna).value),
        copy(record.metadata), copy(features), record.rna }, "" };
}

// Reject cuts through features rather than silently losing annotation.
fn slice_annotated_record(record: AnnotatedRecord, start: i64, end: i64) -> AnnotatedRecordResult {
    let error = validate_annotated_record(copy(record));
    if error.len > 0 { return AnnotatedRecordResult { copy(record), copy(error) }; }
    if start < 0 || end < start || end > record.sequence.len {
        return AnnotatedRecordResult { copy(record), "invalid slice bounds" };
    }
    if start == end {
        return AnnotatedRecordResult { AnnotatedRecord { copy(record.id),
            copy(record.description), "", copy(record.metadata), [], record.rna }, "" };
    }
    var features: AnnotatedFeature[>..] = [];
    for f in record.features {
        var inside = false;
        var outside = false;
        for p in f.parts {
            if p.start >= start && p.end <= end { inside = true; }
            else if p.end > start && p.start < end {
                return AnnotatedRecordResult { copy(record), "slice cuts feature" };
            } else { outside = true; }
        }
        if inside && outside { return AnnotatedRecordResult { copy(record), "slice cuts compound feature" }; }
        if inside {
            var parts: LocationPart[>..] = [];
            for p in f.parts {
                parts.push(LocationPart { p.start - start, p.end - start, p.strand, false });
            }
            features.push(AnnotatedFeature { copy(f.kind), copy(parts), copy(f.qualifiers) });
        }
    }
    return AnnotatedRecordResult { AnnotatedRecord { copy(record.id),
        copy(record.description), str(record.sequence[start..end]),
        copy(record.metadata), copy(features), record.rna }, "" };
}
