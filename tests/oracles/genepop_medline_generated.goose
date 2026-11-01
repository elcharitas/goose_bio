import bio from "../..";
import bio.io.genepop;
import bio.io.medline;
fn main() {
    { let result = bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n"); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n");
        assert(result.record.width == 2 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 2); }
            if n == 2 { assert(a == 0); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 4); }
            if n == 5 { assert(a == 0); }
            n += 1; } } } assert(n == 6); }
    { let result = bio::parse_genepop(bio::write_genepop(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n").record)).text); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n");
        assert(result.record.width == 2 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 2); }
            if n == 2 { assert(a == 0); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 4); }
            if n == 5 { assert(a == 0); }
            n += 1; } } } assert(n == 6); }
    { let result = bio::genepop_select(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n").record), [1, 0], [1, 0]); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nL1\nPop\nGamma, 00 04\nPop\nAlpha, 02 01\nBeta, 03 00\n");
        assert(result.record.width == 2 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            if n == 1 { assert(a == 4); }
            if n == 2 { assert(a == 2); }
            if n == 3 { assert(a == 1); }
            if n == 4 { assert(a == 3); }
            if n == 5 { assert(a == 0); }
            n += 1; } } } assert(n == 6); }
    { let result = bio::genepop_remove(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n").record), 0, 0); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nPop\nGamma, 00\n");
        assert(result.record.width == 2 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            n += 1; } } } assert(n == 1); }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n").record), true); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nAlpha, 01 02\nBeta, 00 03\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nGamma, 04 00\n"); }
    } }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 01 02\nBeta, 00 03\nPop\nGamma, 04 00\n").record), false); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nPop\nAlpha, 01\nBeta, 00\nPop\nGamma, 04\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL2\nPop\nAlpha, 02\nBeta, 03\nPop\nGamma, 00\n"); }
    } }
    { let result = bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n"); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n");
        assert(result.record.width == 2 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 0); }
            if n == 2 { assert(a == 2); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 0); }
            if n == 5 { assert(a == 2); }
            if n == 6 { assert(a == 3); }
            if n == 7 { assert(a == 4); }
            if n == 8 { assert(a == 4); }
            if n == 9 { assert(a == 5); }
            if n == 10 { assert(a == 0); }
            if n == 11 { assert(a == 0); }
            n += 1; } } } assert(n == 12); }
    { let result = bio::parse_genepop(bio::write_genepop(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n").record)).text); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n");
        assert(result.record.width == 2 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 0); }
            if n == 2 { assert(a == 2); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 0); }
            if n == 5 { assert(a == 2); }
            if n == 6 { assert(a == 3); }
            if n == 7 { assert(a == 4); }
            if n == 8 { assert(a == 4); }
            if n == 9 { assert(a == 5); }
            if n == 10 { assert(a == 0); }
            if n == 11 { assert(a == 0); }
            n += 1; } } } assert(n == 12); }
    { let result = bio::genepop_select(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n").record), [1, 0], [1, 0]); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nL1\nPop\nGamma, 0000 0405\nPop\nAlpha, 0203 0100\nBeta, 0304 0002\n");
        assert(result.record.width == 2 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            if n == 1 { assert(a == 0); }
            if n == 2 { assert(a == 4); }
            if n == 3 { assert(a == 5); }
            if n == 4 { assert(a == 2); }
            if n == 5 { assert(a == 3); }
            if n == 6 { assert(a == 1); }
            if n == 7 { assert(a == 0); }
            if n == 8 { assert(a == 3); }
            if n == 9 { assert(a == 4); }
            if n == 10 { assert(a == 0); }
            if n == 11 { assert(a == 2); }
            n += 1; } } } assert(n == 12); }
    { let result = bio::genepop_remove(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n").record), 0, 0); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nPop\nGamma, 0000\n");
        assert(result.record.width == 2 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            if n == 1 { assert(a == 0); }
            n += 1; } } } assert(n == 2); }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n").record), true); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nGamma, 0405 0000\n"); }
    } }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 0100 0203\nBeta, 0002 0304\nPop\nGamma, 0405 0000\n").record), false); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nPop\nAlpha, 0100\nBeta, 0002\nPop\nGamma, 0405\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL2\nPop\nAlpha, 0203\nBeta, 0304\nPop\nGamma, 0000\n"); }
    } }
    { let result = bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n"); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n");
        assert(result.record.width == 3 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 2); }
            if n == 2 { assert(a == 0); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 4); }
            if n == 5 { assert(a == 0); }
            n += 1; } } } assert(n == 6); }
    { let result = bio::parse_genepop(bio::write_genepop(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n").record)).text); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n");
        assert(result.record.width == 3 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 2); }
            if n == 2 { assert(a == 0); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 4); }
            if n == 5 { assert(a == 0); }
            n += 1; } } } assert(n == 6); }
    { let result = bio::genepop_select(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n").record), [1, 0], [1, 0]); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nL1\nPop\nGamma, 000 004\nPop\nAlpha, 002 001\nBeta, 003 000\n");
        assert(result.record.width == 3 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            if n == 1 { assert(a == 4); }
            if n == 2 { assert(a == 2); }
            if n == 3 { assert(a == 1); }
            if n == 4 { assert(a == 3); }
            if n == 5 { assert(a == 0); }
            n += 1; } } } assert(n == 6); }
    { let result = bio::genepop_remove(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n").record), 0, 0); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nPop\nGamma, 000\n");
        assert(result.record.width == 3 && result.record.ploidy == 1);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            n += 1; } } } assert(n == 1); }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n").record), true); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nAlpha, 001 002\nBeta, 000 003\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nGamma, 004 000\n"); }
    } }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001 002\nBeta, 000 003\nPop\nGamma, 004 000\n").record), false); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nPop\nAlpha, 001\nBeta, 000\nPop\nGamma, 004\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL2\nPop\nAlpha, 002\nBeta, 003\nPop\nGamma, 000\n"); }
    } }
    { let result = bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n"); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n");
        assert(result.record.width == 3 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 0); }
            if n == 2 { assert(a == 2); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 0); }
            if n == 5 { assert(a == 2); }
            if n == 6 { assert(a == 3); }
            if n == 7 { assert(a == 4); }
            if n == 8 { assert(a == 4); }
            if n == 9 { assert(a == 5); }
            if n == 10 { assert(a == 0); }
            if n == 11 { assert(a == 0); }
            n += 1; } } } assert(n == 12); }
    { let result = bio::parse_genepop(bio::write_genepop(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n").record)).text); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL1\nL2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n");
        assert(result.record.width == 3 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 1); }
            if n == 1 { assert(a == 0); }
            if n == 2 { assert(a == 2); }
            if n == 3 { assert(a == 3); }
            if n == 4 { assert(a == 0); }
            if n == 5 { assert(a == 2); }
            if n == 6 { assert(a == 3); }
            if n == 7 { assert(a == 4); }
            if n == 8 { assert(a == 4); }
            if n == 9 { assert(a == 5); }
            if n == 10 { assert(a == 0); }
            if n == 11 { assert(a == 0); }
            n += 1; } } } assert(n == 12); }
    { let result = bio::genepop_select(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n").record), [1, 0], [1, 0]); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nL1\nPop\nGamma, 000000 004005\nPop\nAlpha, 002003 001000\nBeta, 003004 000002\n");
        assert(result.record.width == 3 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            if n == 1 { assert(a == 0); }
            if n == 2 { assert(a == 4); }
            if n == 3 { assert(a == 5); }
            if n == 4 { assert(a == 2); }
            if n == 5 { assert(a == 3); }
            if n == 6 { assert(a == 1); }
            if n == 7 { assert(a == 0); }
            if n == 8 { assert(a == 3); }
            if n == 9 { assert(a == 4); }
            if n == 10 { assert(a == 0); }
            if n == 11 { assert(a == 2); }
            n += 1; } } } assert(n == 12); }
    { let result = bio::genepop_remove(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n").record), 0, 0); assert(result.error.len == 0);
        let w = bio::write_genepop(copy(result.record)); assert(w.error.len == 0 && w.text == "ordered comment\nL2\nPop\nGamma, 000000\n");
        assert(result.record.width == 3 && result.record.ploidy == 2);
        var n = 0; for pop in result.record.populations { for ind in pop.individuals { for a in ind.alleles {
            if n == 0 { assert(a == 0); }
            if n == 1 { assert(a == 0); }
            n += 1; } } } assert(n == 2); }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n").record), true); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nL2\nPop\nGamma, 004005 000000\n"); }
    } }
    { let split = bio::genepop_split(copy(bio::parse_genepop("ordered comment\nL1, L2\nPop\nAlpha, 001000 002003\nBeta, 000002 003004\nPop\nGamma, 004005 000000\n").record), false); assert(split.error.len == 0 && split.records.len == 2); for record, i in split.records {
        if i == 0 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL1\nPop\nAlpha, 001000\nBeta, 000002\nPop\nGamma, 004005\n"); }
        if i == 1 { assert(bio::write_genepop(copy(record)).text == "ordered comment\nL2\nPop\nAlpha, 002003\nBeta, 003004\nPop\nGamma, 000000\n"); }
    } }
    { let parsed = bio::parse_medline("PMID- 123\nTI  - first\n      second\nTI  - third\nAB  - abstract\n      more\nAD  - city\n      country\nAD  - other\nMH  - term\n      qualifier\nZZ  - unknown\n      continued\nZZ  - repeated\n\nTI  - final"); assert(parsed.error.len == 0 && parsed.records.len == 2); for record, ri in parsed.records {
        if ri == 0 { assert(record.fields.len == 6); for field, fi in record.fields {
            if fi == 0 { assert(field.key == "PMID" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "123"); }
            } }
            if fi == 1 { assert(field.key == "TI" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "first second third"); }
            } }
            if fi == 2 { assert(field.key == "AB" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "abstract more"); }
            } }
            if fi == 3 { assert(field.key == "AD" && field.text == false && field.values.len == 2); for v, vi in field.values {
                if vi == 0 { assert(v == "city country"); }
                if vi == 1 { assert(v == "other"); }
            } }
            if fi == 4 { assert(field.key == "MH" && field.text == false && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "term qualifier"); }
            } }
            if fi == 5 { assert(field.key == "ZZ" && field.text == false && field.values.len == 3); for v, vi in field.values {
                if vi == 0 { assert(v == "unknown"); }
                if vi == 1 { assert(v == "continued"); }
                if vi == 2 { assert(v == "repeated"); }
            } }
        } }
        if ri == 1 { assert(record.fields.len == 1); for field, fi in record.fields {
            if fi == 0 { assert(field.key == "TI" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "final"); }
            } }
        } }
    } }
    { let first = bio::read_medline("PMID- 123\nTI  - first\n      second\nTI  - third\nAB  - abstract\n      more\nAD  - city\n      country\nAD  - other\nMH  - term\n      qualifier\nZZ  - unknown\n      continued\nZZ  - repeated\n\nTI  - final"); assert(first.error.len == 0 && first.record.fields.len == 6); }
    { let parsed = bio::parse_medline("TI  -   leading  \r\n      continuation  \r\nXX  - a\r\n      b"); assert(parsed.error.len == 0 && parsed.records.len == 1); for record, ri in parsed.records {
        if ri == 0 { assert(record.fields.len == 2); for field, fi in record.fields {
            if fi == 0 { assert(field.key == "TI" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "  leading continuation"); }
            } }
            if fi == 1 { assert(field.key == "XX" && field.text == false && field.values.len == 2); for v, vi in field.values {
                if vi == 0 { assert(v == "a"); }
                if vi == 1 { assert(v == "b"); }
            } }
        } }
    } }
    { let first = bio::read_medline("TI  -   leading  \r\n      continuation  \r\nXX  - a\r\n      b"); assert(first.error.len == 0 && first.record.fields.len == 2); }
    { let parsed = bio::parse_medline("AB  - first\n      \n      last\nMH  - term\n      \n      end"); assert(parsed.error.len == 0 && parsed.records.len == 1); for record, ri in parsed.records {
        if ri == 0 { assert(record.fields.len == 2); for field, fi in record.fields {
            if fi == 0 { assert(field.key == "AB" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "first \n last"); }
            } }
            if fi == 1 { assert(field.key == "MH" && field.text == false && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "term \n end"); }
            } }
        } }
    } }
    { let first = bio::read_medline("AB  - first\n      \n      last\nMH  - term\n      \n      end"); assert(first.error.len == 0 && first.record.fields.len == 2); }
    { let parsed = bio::parse_medline("\n\nTI  - first\n\nTI  - second\n"); assert(parsed.error.len == 0 && parsed.records.len == 2); for record, ri in parsed.records {
        if ri == 0 { assert(record.fields.len == 1); for field, fi in record.fields {
            if fi == 0 { assert(field.key == "TI" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "first"); }
            } }
        } }
        if ri == 1 { assert(record.fields.len == 1); for field, fi in record.fields {
            if fi == 0 { assert(field.key == "TI" && field.text == true && field.values.len == 1); for v, vi in field.values {
                if vi == 0 { assert(v == "second"); }
            } }
        } }
    } }
    { let first = bio::read_medline("\n\nTI  - first\n\nTI  - second\n"); assert(first.error.len == 0 && first.record.fields.len == 1); }
    print("Bio 1.88 oracle: 38 record comparisons passed");
}
