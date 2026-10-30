// Copyright (c) 2026 Jonathan Irhodia. MIT License.
import bio from "..";
import bio.io.compass;
import std;
fn main() {
    let header = "Ali1: q Ali2: h\nThreshold of effective gap content in columns: .5\nlength1=4 filtered_length1=3.5 length2=4 filtered_length2=3\nNseqs1=1 Neff1=1 Nseqs2=1 Neff2=1\nSmith-Waterman unavailable\n";
    assert(bio::read_compass(header).error.code.len == 0);
    for score in ["Smith-Waterman\tscore = 99 Evalue = 2.5e-20", "Smith-Waterman score = 99 Evalue =  2.5e-20", "Smith-Waterman score = 99 Evalue = \t2.5e-20", "Smith-Waterman  score = 99 Evalue = 2.5e-20", "Smith-Waterman score = 99 Evalue\t= 2.5e-20"] {
        var input: u8[>..] = [];
        for line, i in split(header, '\n') { if i < 4 { input.append(line); input.push('\n'); } }
        input.append(score); input.push('\n');
        let parsed = bio::read_compass(input); assert(parsed.error.code.len == 0);
        for record in parsed.records { assert(record.sw_score == 0 && record.evalue == -1.0); }
    }
    for separator in [9, 11, 12, 13, 28, 29, 30, 31] {
        var input: u8[>..] = [];
        for line, i in split(header, '\n') { if i < 4 { input.append(line); input.push('\n'); } }
        input.append("Smith-Waterman score = 99"); input.push(separator as u8); input.append("Evalue = 2.5e-20\n");
        let parsed = bio::read_compass(input); assert(parsed.error.code.len == 0);
        for record in parsed.records { assert(record.sw_score == 99 && record.evalue > 0.0); }
    }
    var many: u8[>..] = [];
    for i in 0..10001 { many.append(header); }
    assert(bio::parse_compass(many).error.code == "limit");
    var large: u8[>..] = []; large.resize(67108865, ' ');
    assert(bio::parse_compass(large).error.code == "limit");
    var columns: u8[>..] = []; columns.append(header);
    for prefix in ["1              ", "               ", "2              "] {
        columns.append(prefix); for i in 0..1000001 { columns.push('A'); } columns.push('\n');
    }
    assert(bio::parse_compass(columns).error.code == "limit");
    assert(bio::compass_coverage("=-.A=") == 3);
}
