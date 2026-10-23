// Whole-text GenePop with uniform allele width and ploidy.
namespace bio;
import std;
import .alignment_io;
struct GenePopIndividual { name: u8[], alleles: i64[] }
struct GenePopPopulation { individuals: GenePopIndividual[] }
/*
Owns comment, ordered loci/populations, uniform allele width 2/3, and ploidy 1/2.
Individual names are separate from flat locus-then-copy alleles. Zero means missing;
partial diploid missing calls survive. Population indices are identities, not last-
individual labels.
*/
struct GenePopRecord { comment: u8[], loci: u8[][], populations: GenePopPopulation[], width: i64, ploidy: i64 }
struct GenePopResult { record: GenePopRecord, error: u8[] }
struct GenePopSplit { records: GenePopRecord[], error: u8[] }
fn genepop_error(message: u8[:]) -> GenePopResult {
    return GenePopResult { GenePopRecord { "", [], [], 0, 0 }, str(message) };
}
/*
Check error before using record. First-line loci accept spaces/commas; later lines
supply one locus each. Delimiters ignore ASCII case, CRLF works, and blank lines after
the comment are skipped. Names may repeat/contain spaces; comment spaces survive.
*/
/*
Model validation rejects inconsistent width/ploidy/counts, empty groups, invalid/out-of-
width alleles, nonprintable text, padded/control/comma names, reserved loci, and spaces
within locus names. Buffered byte parsing has no file/network API; repeated
validation/updates may be quadratic.
*/
/* Population statistics and Tajima D are not computed.
 */
fn parse_genepop(text: u8[:]) -> GenePopResult {
    var comment: u8[>..] = []; var loci: u8[][>..] = [];
    var pops: GenePopPopulation[>..] = [];
    var individuals: GenePopIndividual[>..] = [];
    var first = true; var active = false; var width = 0; var ploidy = 0;
    for raw in split(text, '\n') {
        let line = trim(format_line(raw));
        if first { comment.append(format_line(raw)); first = false; continue; }
        if line.len == 0 { continue; }
        if genepop_pop(line) {
            if active {
                if individuals.len == 0 { return genepop_error("empty population"); }
                pops.push(GenePopPopulation { copy(individuals) }); individuals.clear();
            }
            active = true; continue;
        }
        if !active {
            let first_loci_line = loci.len == 0;
            for part in split(line, ',') {
                let name = trim(part);
                if name.len == 0 { return genepop_error("empty locus"); }
                if first_loci_line {
                    for word in alignment_words(name).fields { loci.push(copy(word)); }
                } else { loci.push(str(name)); }
            }
            continue;
        }
        let pieces = split(line, ',');
        var name: u8[>..] = []; var genotypes: u8[>..] = [];
        for part, i in pieces { if i == 0 { name.append(trim(part)); } else { genotypes.append(part); } }
        if pieces.len != 2 || name.len == 0 { return genepop_error("expected individual name and genotypes"); }
        let words = alignment_words(trim(genotypes));
        if words.fields.len != loci.len || loci.len == 0 { return genepop_error("locus count mismatch"); }
        var alleles: i64[>..] = [];
        for token in words.fields {
            var w = 0; var p = 0;
            if token.len == 2 || token.len == 3 { w = token.len; p = 1; }
            if token.len == 4 || token.len == 6 { w = token.len/2; p = 2; }
            if w == 0 { return genepop_error("invalid genotype width"); }
            if width == 0 { width = w; ploidy = p; }
            if w != width || p != ploidy { return genepop_error("inconsistent width or ploidy"); }
            for c in token { if c < '0' || c > '9' { return genepop_error("nondecimal allele"); } }
            for a in 0..p {
                let value, ok = parse_int(token[a*w..(a+1)*w]);
                if !ok { return genepop_error("invalid allele"); }
                alleles.push(value);
            }
        }
        individuals.push(GenePopIndividual { copy(name), copy(alleles) });
    }
    if !active || individuals.len == 0 || loci.len == 0 { return genepop_error("missing loci or empty population"); }
    pops.push(GenePopPopulation { copy(individuals) });
    let record = GenePopRecord { copy(comment), copy(loci), copy(pops), width, ploidy };
    let checked = write_genepop(copy(record));
    if checked.error.len > 0 { return genepop_error(checked.error); }
    return GenePopResult { copy(record), "" };
}
fn genepop_line(value: u8[:]) -> bool {
    for c in value { if c < 32 || c > 126 { return false; } }
    return true;
}
/*
Validates the same model and emits one locus per line, Pop delimiters, padded decimal
alleles, and a final LF.
*/
fn write_genepop(r: GenePopRecord) -> FormatTextResult {
    if (r.width != 2 && r.width != 3) || (r.ploidy != 1 && r.ploidy != 2) || !genepop_line(r.comment) { return FormatTextResult { "", "invalid width, ploidy or comment" }; }
    var out: u8[>..] = []; out.append(r.comment); out.push('\n');
    if r.loci.len == 0 || r.populations.len == 0 { return FormatTextResult { "", "empty record" }; }
    for name in r.loci {
        if name.len == 0 || alignment_words(name).fields.len != 1 || trim(name) != name || !genepop_line(name) || split(name, ',').len != 1 || genepop_pop(name) { return FormatTextResult { "", "invalid locus name" }; }
        out.append(name); out.push('\n');
    }
    for pop in r.populations {
        if pop.individuals.len == 0 { return FormatTextResult { "", "empty population" }; }
        out.append("Pop\n");
        for ind in pop.individuals {
            if ind.name.len == 0 || trim(ind.name) != ind.name || !genepop_line(ind.name) || split(ind.name, ',').len != 1 || ind.alleles.len != r.loci.len*r.ploidy { return FormatTextResult { "", "invalid individual" }; }
            out.append(ind.name); out.push(',');
            for a, i in ind.alleles {
                if i % r.ploidy == 0 { out.push(' '); }
                let limit = if r.width == 2 { 100 } else { 1000 };
                if a < 0 || a >= limit { return FormatTextResult { "", "allele outside width" }; }
                var divisor = limit/10;
                while divisor > 0 { out.push((48 + (a/divisor)%10) as u8); divisor /= 10; }
            }
            out.push('\n');
        }
    }
    return FormatTextResult { copy(out), "" };
}
fn genepop_indices(ids: i64[:], count: i64) -> bool {
    if ids.len == 0 { return false; }
    for id, i in ids {
        if id < 0 || id >= count { return false; }
        for other, j in ids { if j < i && id == other { return false; } }
    }
    return true;
}
/*
Zero-based selection order controls output order. Empty, duplicate, or invalid indices
fail; input remains unchanged.
*/
fn genepop_select(r: GenePopRecord, populations: i64[:], loci: i64[:]) -> GenePopResult {
    let checked = write_genepop(copy(r));
    if checked.error.len > 0 { return genepop_error(checked.error); }
    if !genepop_indices(populations,r.populations.len) || !genepop_indices(loci,r.loci.len) { return genepop_error("invalid or empty selection"); }
    var names: u8[][>..] = []; var pops: GenePopPopulation[>..] = [];
    for l in loci { for name, i in r.loci { if i == l { names.push(copy(name)); } } }
    for p in populations {
        var inds: GenePopIndividual[>..] = [];
        for pop, pi in r.populations { if pi != p { continue; }
        for ind in pop.individuals {
            var alleles: i64[>..] = [];
            for l in loci { for a in 0..r.ploidy { alleles.push(ind.alleles[l*r.ploidy+a]); } }
            inds.push(GenePopIndividual { copy(ind.name), copy(alleles) });
        }
        }
        pops.push(GenePopPopulation { copy(inds) });
    }
    return GenePopResult { GenePopRecord { copy(r.comment), copy(names), copy(pops), r.width, r.ploidy }, "" };
}
/*
Use -1 to keep either dimension; other negatives fail. Removing the last population or
locus fails.
*/
fn genepop_remove(r: GenePopRecord, population: i64, locus: i64) -> GenePopResult {
    if population < -1 || population >= r.populations.len || locus < -1 || locus >= r.loci.len { return genepop_error("removal index out of range"); }
    var ps: i64[>..] = []; var ls: i64[>..] = [];
    for i in 0..r.populations.len { if i != population { ps.push(i); } }
    for i in 0..r.loci.len { if i != locus { ls.push(i); } }
    return genepop_select(copy(r),ps,ls);
}
/*
Returns ordered records: by_population=true gives one population each; false gives one
locus each.
*/
fn genepop_split(r: GenePopRecord, by_population: bool) -> GenePopSplit {
    var records: GenePopRecord[>..] = [];
    let checked = write_genepop(copy(r));
    if checked.error.len > 0 { return GenePopSplit { [], copy(checked.error) }; }
    let count = if by_population { r.populations.len } else { r.loci.len };
    for n in 0..count {
        var ps: i64[>..] = []; var ls: i64[>..] = [];
        for i in 0..r.populations.len { if !by_population || i == n { ps.push(i); } }
        for i in 0..r.loci.len { if by_population || i == n { ls.push(i); } }
        records.push(copy(genepop_select(copy(r),ps,ls).record));
    }
    return GenePopSplit { copy(records), "" };
}

fn genepop_pop(value: u8[:]) -> bool {
    return value.len == 3 && (value[0] == 'P' || value[0] == 'p') && (value[1] == 'O' || value[1] == 'o') && (value[2] == 'P' || value[2] == 'p');
}
fn read_genepop(text: u8[:]) -> GenePopResult { return parse_genepop(text); }
