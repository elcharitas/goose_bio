import bio from "../..";
import hts from "../..";
import bio.hts;
import bio_http from "..";
fn main() {
    assert(bio::normalize_sequence("acgt").value == "ACGT");
    assert(bio::hts_close(-1) == -1);
    assert(bio_http::request("GET", "file:///unused").code != 0);
    print("combined imports passed");
}
