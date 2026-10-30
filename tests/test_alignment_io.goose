import bio from "..";
import bio.io.alignment_io;
fn main() {
    let records = [bio::SequenceRecord { "long_identifier", "AC-Gt-", "" }, bio::SequenceRecord { "b", "ACTGt-", "" }];
    let clustal = bio::write_clustal(records);
    let phylip = bio::write_phylip(records);
    assert(clustal.error.len == 0 && phylip.error.len == 0);
    let c = bio::parse_clustal(clustal.text); let p = bio::parse_phylip(phylip.text);
    assert(c.error.len == 0 && p.error.len == 0 && c.records.len == 2);
    assert(bio::write_clustal(c.records).text == clustal.text);
    assert(bio::write_phylip(p.records).text == phylip.text);
    assert(bio::parse_clustal("CLUSTAL W\r\n\r\na AC-\r\nb AT-\r\n  * :\r\n").error.len == 0);
    for t in ["2 3\na AC\nb AG\n", "3 2\na AC\nb AG\n", "2 2\na AC\na AG\n", "2 2\na A?\nb AG\n", "2 2\na AC 2\nb AG 2\n", "0 0\n"] { assert(bio::parse_phylip(t).error.len > 0); }
    assert(bio::parse_clustal("CLUSTAL W\na AC\nb AG\n\na TT\nb TC\n").error.len > 0);
    assert(bio::parse_clustal("CLUSTAL W\na AC\n . ..\n").error.len > 0);
    let dots = bio::parse_clustal("CLUSTAL W\n a AC\n . ..\n");
    assert(dots.error.len == 0 && dots.records.len == 2);
    for t in ["CLUSTAL W\na AC\nb AT\n * .\n", "CLUSTAL W\na AC\nb AT\n  **\nc AA\n", "CLUSTAL W\na AC\n  **\n"] { assert(bio::parse_clustal(t).error.len > 0); }
    assert(bio::parse_phylip("2 3\na A.C\nb ATC\n").error.len > 0);
    let dotted = [bio::SequenceRecord { "a", "A.C", "" }, bio::SequenceRecord { "b", "ATC", "" }];
    assert(bio::write_phylip(dotted).error.len > 0);
    assert(bio::write_clustal(dotted).error.len == 0);
    assert(clustal.text == "CLUSTAL W\n\nlong_identifier AC-Gt-\nb               ACTGt-\n");
    let bad_header = [bio::SequenceRecord { "x description", "AC", "" }];
    assert(bio::write_clustal(bad_header).error.len > 0);
    let bad_quality = [bio::SequenceRecord { "x", "AC", "!!" }];
    assert(bio::write_phylip(bad_quality).error.len > 0);
    print("alignment IO assertions passed");
}
