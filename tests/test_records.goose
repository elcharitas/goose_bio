import bio from "..";
import bio.sequence.records;
fn main() {
    let original = bio::AnnotatedRecord { "id", "description", "ACGTAGTC", [
        bio::FeatureQualifier { "source", ["test"] }], [], false };
    let converted = bio::rich_record_from_annotated(copy(original));
    assert(converted.error.len == 0);
    assert(bio::rich_sequence_slice(copy(converted.record), 0, 8).value == original.sequence);
    let f = bio::RecordFeature { "gene", [
        bio::RecordLocationPart { bio::RecordPosition { 1, 6 }, bio::RecordPosition { 2, 8 }, 1, "" },
        bio::RecordLocationPart { bio::RecordPosition { 0, 0 }, bio::RecordPosition { 0, 2 }, 1, "" }
    ], [bio::FeatureQualifier { "gene", ["origin"] }] };
    let r = bio::RichRecord { "id", "description", 8, [
        bio::DefinedSegment { 0, "AC" }, bio::DefinedSegment { 6, "TC" }
    ], copy(original.metadata), [copy(f)], [
        bio::LetterTrack { "quality", 1, "", [1,2,3,4,5,6,7,8], [] },
        bio::LetterTrack { "mask", 0, "abcdefgh", [], [] },
        bio::LetterTrack { "score", 2, "", [], [0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0] }
    ], false, 1 };
    assert(bio::validate_rich_record(copy(r)).len == 0);
    assert(bio::rich_sequence_slice(copy(r), 0, 8).error.len > 0);
    assert(bio::extract_rich_feature(copy(r), copy(f)).error.len > 0);
    assert(bio::extract_rich_feature(copy(r), copy(f), true).value == "TCAC");
    let rev = bio::reverse_complement_rich_record(copy(r));
    assert(rev.error.len == 0 && rev.record.topology == 1);
    assert(bio::extract_rich_feature(copy(rev.record), copy(f), true).value != "TCAC");
    for feature in rev.record.features {
        assert(bio::extract_rich_feature(copy(rev.record), copy(feature), true).value == "TCAC");
        for p, i in feature.parts {
            if i == 0 { assert(p.start.kind == 1 && p.end.kind == 2 && p.start.value == 0 && p.end.value == 2); }
        }
    }
    for t in rev.record.tracks {
        if t.kind == 0 { assert(t.bytes == "hgfedcba"); }
        if t.kind == 2 { for v, i in t.floats { assert(v == 7-i); } }
    }
    for m in rev.record.metadata { assert(m.key == "source"); for v in m.values { assert(v == "test"); } }
    let twice = bio::reverse_complement_rich_record(copy(rev.record));
    assert(twice.error.len == 0);
    for s, i in twice.record.segments {
        if i == 0 { assert(s.start == 0 && s.value == "AC"); }
        else { assert(s.start == 6 && s.value == "TC"); }
    }
    for t in twice.record.tracks {
        if t.kind == 0 { assert(t.bytes == "abcdefgh"); }
        if t.kind == 1 { for v, i in t.integers { assert(v == i + 1); } }
        if t.kind == 2 { for v, i in t.floats { assert(v == i); } }
    }
    assert(bio::slice_rich_record(copy(r), 0, 7).error.len > 0);
    let sliced = bio::slice_rich_record(copy(r), 2, 6);
    assert(sliced.error.len == 0 && sliced.record.length == 4 && sliced.record.segments.len == 0);
    assert(sliced.record.topology == 0 && sliced.record.features.len == 0);
    for t in sliced.record.tracks {
        if t.kind == 0 { assert(t.bytes == "cdef"); }
        if t.kind == 1 { for v, i in t.integers { assert(v == i + 3); } }
        if t.kind == 2 { for v, i in t.floats { assert(v == i + 2); } }
    }
    let unknown = bio::RecordFeature { "unknown", [bio::RecordLocationPart {
        bio::RecordPosition { 3, 0 }, bio::RecordPosition { 0, 2 }, 1, "" }], [] };
    assert(bio::extract_rich_feature(copy(r), copy(unknown), true).error.len > 0);
    let ur = bio::RichRecord { "", "", 8, [], [], [copy(unknown)], [], false, 0 };
    let flipped_unknown = bio::reverse_complement_rich_record(copy(ur));
    assert(flipped_unknown.error.len == 0);
    for feature in flipped_unknown.record.features {
        for p in feature.parts { assert(p.end.kind == 3 && p.end.value == 0 && p.start.value == 6); }
    }
    assert(bio::slice_rich_record(copy(ur), 0, 8).error.len > 0);
    assert(bio::flip_record_position(bio::RecordPosition { 3, 0 }, 8).kind == 3);
    let remote = [bio::RecordLocationPart {
        bio::RecordPosition { 0, 0 }, bio::RecordPosition { 0, 2 }, 1, "remote" }];
    assert(bio::validate_record_parts(remote, 8).len > 0);
    let bad = bio::RichRecord { "", "", 2, [], [], [], [
        bio::LetterTrack { "quality", 1, "", [1], [] }], false, 0 };
    assert(bio::validate_rich_record(copy(bad)).len > 0);
    for a in 9 { for b in 9 {
        if a > b { continue; }
        let part = bio::slice_rich_record(copy(converted.record), a, b);
        assert(part.error.len == 0);
        assert(bio::rich_sequence_slice(copy(part.record), 0, b-a).value == original.sequence[a..b]);
    } }
    let empty_feature = bio::RecordFeature { "site", [bio::RecordLocationPart {
        bio::RecordPosition { 0, 0 }, bio::RecordPosition { 0, 0 }, 1, "" }], [] };
    let empty_record = bio::RichRecord { "empty", "", 0, [], [],
        [copy(empty_feature)], [], false, 0 };
    let empty_copy = bio::slice_rich_record(copy(empty_record), 0, 0);
    assert(empty_copy.error.len == 0 && empty_copy.record.features.len == 1);
    for feature in empty_copy.record.features {
        let extracted = bio::extract_rich_feature(copy(empty_copy.record), copy(feature));
        assert(extracted.error.len == 0 && extracted.value.len == 0);
    }
    print("rich record assertions passed");
}
