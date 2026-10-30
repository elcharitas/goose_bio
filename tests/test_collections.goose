import bio from "..";
import bio.collections.collections;
fn main() {
    for a in 4 { for b in a..4 { for c in 4 { for d in c..4 {
        let intervals = [bio::Interval { a, b }, bio::Interval { c, d }];
        let tree = bio::interval_tree(intervals);
        for start in 5 { for end in start..5 {
            let query = bio::Interval { start, end };
            let expected = bio::interval_query(intervals, query);
            let actual = bio::interval_tree_query(tree, query);
            assert(expected.len == actual.len);
            for id in expected {
                var count: i64 = 0; for got in actual { if got == id { count += 1; } }
                assert(count == 1);
            }
        } }
    } } } }
    var seed: i64 = 47;
    for n in 40 {
        var sum = bio::fenwick(n); var maximum = bio::fenwick(n);
        var values: i64[>..] = []; var maxima: i64[>..] = [];
        for i in n { values.push(0); maxima.push(0); }
        if n > 0 { for step in 100 {
            seed = seed * 48271 % 2147483647; let pos = seed % n;
            seed = seed * 48271 % 2147483647; let value = seed % 100;
            bio::fenwick_update(sum, pos, value);
            bio::fenwick_update(maximum, pos, value, true);
            values[pos] += value; if value > maxima[pos] { maxima[pos] = value; }
            var total: i64 = 0; var top: i64 = 0;
            for end in n + 1 {
                assert(bio::fenwick_query(sum, end) == total);
                assert(bio::fenwick_query(maximum, end, true) == top);
                if end < n { total += values[end]; if maxima[end] > top { top = maxima[end]; } }
            }
        } }
        assert(bio::fenwick_query(sum, 0) == 0);
        var intervals: bio::Interval[>..] = [];
        for i in n {
            seed = seed * 48271 % 2147483647; let start = seed % 10;
            seed = seed * 48271 % 2147483647;
            intervals.push(bio::Interval { start, start + seed % 6 });
            if i % 3 == 0 { intervals.push(bio::Interval { start, start + seed % 6 }); }
        }
        let tree = bio::interval_tree(intervals);
        for start in 17 { for end in start..18 {
            let query = bio::Interval { start, end };
            let expected = bio::interval_query(intervals, query);
            let actual = bio::interval_tree_query(tree, query);
            assert(expected.len == actual.len);
            for id in expected {
                var count: i64 = 0; for got in actual { if got == id { count += 1; } }
                assert(count == 1);
            }
        } }
    }
    print("collections: passed");
}
