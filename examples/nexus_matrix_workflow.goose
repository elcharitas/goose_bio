import std;
import bio from "..";
import bio.io.nexus_matrix;
import bio.io.nexus_matrix_workflow;
fn main() {
    let input = "#NEXUS\nBEGIN DATA; DIMENSIONS NTAX=2 NCHAR=4; FORMAT DATATYPE=DNA; MATRIX\na ACGT\nb AGGT\n; END; BEGIN SETS; CHARSET coding=1-3; CHARPARTITION regions=gene:coding,tail:4; END;";
    let parsed = bio::parse_nexus_matrix(input); assert(parsed.error.len == 0);
    let selected = bio::nexus_select(copy(parsed.matrix), [1], [1]); assert(selected.error.len == 0);
    let output = bio::write_nexus_matrix(copy(selected.matrix)); assert(output.error.len == 0); print(output.text);
}
