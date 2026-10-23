namespace bio;

struct Interval { start: i64, end: i64 }
fn interval_valid(a: Interval) -> bool { a.start >= 0 && a.end >= a.start }
fn interval_overlap(a: Interval, b: Interval) -> bool {
    assert(interval_valid(a) && interval_valid(b));
    return a.start < a.end && b.start < b.end && a.start < b.end && b.start < a.end;
}
fn interval_contains(a: Interval, point: i64) -> bool {
    assert(interval_valid(a));
    return a.start <= point && point < a.end;
}
// Linear query returns original indices in input order.
fn interval_query(intervals: const Interval[:], query: Interval) -> i64[>..] {
    assert(interval_valid(query));
    var hits: i64[>..] = [];
    for a, i in intervals { if interval_overlap(a, query) { hits.push(i); } }
    return hits;
}
