import bio from "..";
import bio.io.genepop;
import bio.io.medline;
fn main() {
    let r = bio::parse_genepop("comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\npop\nGamma, 0405 0000\n");
    assert(r.error.len == 0 && r.record.populations.len == 2);
    let w = bio::write_genepop(copy(r.record));
    assert(w.error.len == 0 && w.text == "comment\nL1\nL2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n");
    assert(bio::read_genepop("c\nL1 L2\npOp\na, 01 00").error.len == 0);
    assert(bio::genepop_remove(copy(r.record),-1,2).error.len > 0);
    let single = bio::parse_genepop("c\nL\nPop\na, 01");
    assert(bio::genepop_remove(copy(single.record),0,-1).error.len > 0);
    assert(bio::genepop_remove(copy(single.record),-1,0).error.len > 0);
    assert(bio::write_genepop(bio::GenePopRecord { "c", ["L"], [bio::GenePopPopulation { [] }], 2, 1 }).error.len > 0);
    assert(bio::write_genepop(bio::GenePopRecord { "c", ["L"], [bio::GenePopPopulation { [bio::GenePopIndividual { "a", [100] }] }], 2, 1 }).error.len > 0);
    assert(bio::write_genepop(bio::GenePopRecord { "c", ["L"], [bio::GenePopPopulation { [bio::GenePopIndividual { "a", [-1] }] }], 2, 1 }).error.len > 0);
    assert(bio::write_genepop(bio::GenePopRecord { "c", ["L"], [bio::GenePopPopulation { [bio::GenePopIndividual { "a", [] }] }], 2, 1 }).error.len > 0);
    assert(bio::genepop_split(copy(r.record),true).records.len == 2);
    assert(bio::genepop_select(copy(r.record),[],[0]).error.len > 0);
    assert(bio::genepop_select(copy(r.record),[0,0],[0]).error.len > 0);
    assert(bio::genepop_select(copy(r.record),[2],[0]).error.len > 0);
    assert(bio::genepop_remove(copy(r.record),-2,-1).error.len > 0);
    for text in ["x\nL\nPop\n", "x\nL\nPop\nPop\na, 01", "x\nL\nPop\na, 01 02", "x\nL\nPop\na, 01\nb, 001", "x\nL\nPop\na, 0102\nb, 01", "x\nL\nPop\na, xx", "x\nL\na, 01"] {
        assert(bio::parse_genepop(text).error.len > 0);
    }
    let m = bio::parse_medline("PMID- 123\nTI  - first\n      second\nTI  - third\nAD  - city\n      country\nAD  - elsewhere\nZZ  - one\n      two\nZZ  - three\n\nTI  - final");
    assert(m.error.len == 0 && m.records.len == 2);
    let first = bio::read_medline("TI  - first\n\ninvalid");
    assert(first.error.len == 0);
    for f in first.record.fields { assert(f.key == "TI"); for v in f.values { assert(v == "first"); } }
    assert(bio::parse_medline("invalid").error.len > 0);
    assert(bio::read_medline("").error.len > 0);
    assert(bio::parse_medline("      orphan").error.len > 0);
    print("genepop and medline: passed");
}
