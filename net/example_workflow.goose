// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio_http from ".";
import std;
fn main() {
    let limits = bio_http::UniProtLimits { 3, 10, 16, 1048576, 5000, 10, 2 };
    var workflow = bio_http::uniprot_workflow("test", "http://127.0.0.1:18771", limits);
    let result = bio_http::workflow_data(workflow);
    assert(workflow.complete);
    for record in result.records {
        print(bio_http::join(">", record.accession.value));
        print(record.sequence.value);
    }
}
