import bio from "..";
import bio.sequence.annotations;
fn first_feature(record: bio::AnnotatedRecord) -> bio::AnnotatedFeature {
    for f in record.features { return copy(f); }
    return bio::AnnotatedFeature { "", [], [] };
}
fn first_value(values: bio::FeatureQualifier[:]) -> u8[] {
    for q in values { for v in q.values { return copy(v); } }
    return "";
}
fn main() {
    let f = bio::AnnotatedFeature { "CDS", [
        bio::LocationPart { 0, 2, 1, false },
        bio::LocationPart { 4, 6, -1, false }
    ], [bio::FeatureQualifier { "gene", ["example"] }] };
    let record = bio::AnnotatedRecord { "id", "description", "ACGTAGTC",
        [bio::FeatureQualifier { "source", ["test"] }], [copy(f)], false };
    assert(bio::extract_feature(record.sequence, copy(f)).value == "ACCT");
    let reversed = bio::reverse_complement_record(copy(record));
    assert(reversed.error.len == 0);
    assert(reversed.record.sequence == "GACTACGT");
    assert(first_feature(copy(reversed.record)).parts[0].start == 6);
    assert(first_feature(copy(reversed.record)).parts[0].strand == -1);
    assert(bio::extract_feature(reversed.record.sequence, first_feature(copy(reversed.record))).value == "ACCT");
    assert(first_feature(copy(record)).parts[0].start == 0);
    let twice = bio::reverse_complement_record(copy(reversed.record));
    assert(twice.record.sequence == record.sequence);
    assert(first_feature(copy(twice.record)).parts[1].start == 4);
    assert(first_value(first_feature(copy(twice.record)).qualifiers) == "example");
    assert(first_value(twice.record.metadata) == "test");
    let slice = bio::slice_annotated_record(copy(record), 0, 6);
    assert(slice.error.len == 0 && slice.record.sequence == "ACGTAG");
    assert(bio::slice_annotated_record(copy(record), 0, 5).error.len > 0);
    assert(bio::slice_annotated_record(copy(record), 0, 3).error.len > 0);
    let empty = bio::slice_annotated_record(copy(record), 8, 8);
    assert(empty.error.len == 0 && empty.record.features.len == 0);
    assert(bio::slice_annotated_record(copy(record), -1, 8).error.len > 0);
    assert(bio::slice_annotated_record(copy(record), 0, 9).error.len > 0);
    assert(bio::validate_location([], 8).len > 0);
    assert(bio::validate_location([bio::LocationPart { 0, 0, 1, false }], 8).len > 0);
    assert(bio::validate_location([bio::LocationPart { 0, 9, 1, false }], 8).len > 0);
    assert(bio::validate_location([bio::LocationPart { 0, 1, 0, false }], 8).len > 0);
    assert(bio::validate_location([bio::LocationPart { 0, 1, 1, true }], 8).len > 0);
    let minus = bio::AnnotatedFeature { "gene", [
        bio::LocationPart { 6, 8, -1, false },
        bio::LocationPart { 2, 4, -1, false }
    ], [] };
    assert(bio::extract_feature(record.sequence, copy(minus)).value == "GAAC");
    assert(bio::extract_feature("ACGT?GTC", copy(f)).error.len > 0);
    let simple = bio::AnnotatedRecord { "rna", "", "AAUGCC", [], [
        bio::AnnotatedFeature { "gene", [bio::LocationPart { 2, 4, -1, false }], [] }
    ], true };
    let shifted = bio::slice_annotated_record(copy(simple), 1, 5);
    assert(shifted.error.len == 0 && first_feature(copy(shifted.record)).parts[0].start == 1);
    assert(first_feature(copy(simple)).parts[0].start == 2);
    assert(bio::extract_feature(shifted.record.sequence, first_feature(copy(shifted.record)), true).value == "CA");
    for position in simple.sequence.len + 1 {
        let empty = bio::slice_annotated_record(copy(simple), position, position);
        assert(empty.error.len == 0 && empty.record.sequence.len == 0);
        assert(empty.record.features.len == 0 && empty.record.id == "rna");
    }
    print("annotation assertions passed");
}
