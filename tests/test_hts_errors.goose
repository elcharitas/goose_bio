import hts from "..";
import bio from "..";
import bio.hts;
fn main() {
    let large = bio::hts_open(".tools/pile-large.sam", "r", false, "", "");
    assert(large > 0 && bio::pileup_next(large) == 1);
    assert(bio::pileup_field(large, 0, 1) == 2147483648);
    assert(bio::pileup_next(large) == 1);
    assert(bio::pileup_field(large, 0, 1) == 2147483649);
    assert(bio::pileup_next(large) == 0 && bio::pileup_next(large) == 0);
    assert(bio::pileup_field(large, 0, 1) == -9223372036854775808);
    assert(bio::hts_close(large) == 0);
    for path in [".tools/pile-unsorted.sam", ".tools/pile-refs.sam", ".tools/pile-invalid.sam"] {
        let p = bio::hts_open(path, "r", false, "", "");
        assert(p > 0);
        assert(bio::pileup_next(p) == -1);
        assert(bio::pileup_next(p) == -1);
        assert(bio::pileup_field(p, 0, 2) == -9223372036854775808);
        assert(bio::hts_close(p) == 0);
    }
    let r = bio::hts_open(".tools/wrong-types.vcf", "r", true, "", "");
    assert(r > 0 && bio::hts_next(r) == 1);
    var before: u8[>..] = [];
    assert(bio::hts_text(r, before) == 0);
    let value: i32[1] = [42];
    let empty: i32[0] = [];
    for tag in ["F", "S", "FLAG", "GT", "ABSENT", "", "F\0x"] {
        assert(bio::bcf_set_int(r, tag, false, value) == -1);
        assert(bio::bcf_set_int(r, tag, false, empty) == -1);
    }
    for tag in ["F", "S", "FLAG", "ONLYINFO", "ABSENT", ""] {
        assert(bio::bcf_set_int(r, tag, true, value) == -1);
        assert(bio::bcf_set_int(r, tag, true, empty) == -1);
    }
    assert(bio::bcf_set_int(0, "DP", false, value) == -1);
    var after: u8[>..] = [];
    assert(bio::hts_text(r, after) == 0 && after[..] == before[..]);
    assert(bio::bcf_set_int(r, "DP", false, value) == 0);
    assert(bio::bcf_int(r, "DP", false, 0) == 42);
    assert(bio::bcf_set_int(r, "DP", false, empty) == 0);
    assert(bio::bcf_int_count(r, "DP", false) == -1);
    let gt: i32[2] = [2, 5];
    assert(bio::bcf_set_int(r, "GT", true, gt) == 0);
    assert(bio::bcf_int(r, "GT", true, 1) == 5);
    assert(bio::hts_close(r) == 0);
    assert(bio::bcf_set_int(r, "DP", false, value) == -1);
}
