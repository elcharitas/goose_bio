import hts from "..";
import bio from "..";
import bio.hts;
fn main() {
    for compress in [true, false] {
        let source = if compress { ".tools/alias.raw" } else { ".tools/alias.bgzf" };
        let hard = if compress { ".tools/alias.raw.hard" } else { ".tools/alias.bgzf.hard" };
        let sym = if compress { ".tools/alias.raw.sym" } else { ".tools/alias.bgzf.sym" };
        let relative = if compress { ".tools/../.tools/alias.raw" } else { ".tools/../.tools/alias.bgzf" };
        for dest in [source, hard, sym, relative] {
            assert(bio::hts_bgzf_copy(source, dest, compress) == -1);
        }
        assert(bio::hts_bgzf_copy(".tools/absent-source", ".tools/preserved.out", compress) == -1);
    }
    for path in [".tools/boundary.bam", ".tools/boundary.bcf", ".tools/boundary.vcf.gz", ".tools/no-eof.cram"] {
        let variants = path == ".tools/boundary.bcf" || path == ".tools/boundary.vcf.gz";
        assert(bio::hts_open(path, "r", variants, "", ".tools/reference.fa") == 0);
    }
    for path in [".tools/valid-empty.bam", ".tools/valid-empty.bcf", ".tools/valid-empty.vcf.gz"] {
        let variants = path != ".tools/valid-empty.bam";
        let h = bio::hts_open(path, "r", variants, "", "");
        assert(h > 0);
        assert(bio::hts_next(h) == 0);
        assert(bio::hts_close(h) == 0);
    }
}
