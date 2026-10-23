namespace bio;
import .sequence;
import .genetic_codes;

struct ORF { start: i64, end: i64, strand: i64, frame: i64, protein: u8[] }
struct ORFResult { values: ORF[], error: u8[] }

// Complete start-to-first-stop ORFs, including nested starts.
// Half-open original coordinates include stop; protein excludes stop.
// frame is 0..2 on the oriented strand; strand is +1 or -1.
// Concrete DNA only; dual-stop tables are rejected as ambiguous.
fn find_orfs(text: u8[:], table: i64 = 1, both_strands: bool = true) -> ORFResult {
    var out: ORF[>..] = [];
    let code = genetic_code(table);
    if code.id == 0 || code.dual { return ORFResult { copy(out), "unsupported or dual-stop genetic code" }; }
    let normalized = normalize_sequence(text);
    if normalized.error.len > 0 { return ORFResult { copy(out), copy(normalized.error) }; }
    for c in normalized.value {
        if c != 'A' && c != 'C' && c != 'G' && c != 'T' {
            return ORFResult { copy(out), "ORFs require concrete DNA" };
        }
    }
    let rc = reverse_complement(normalized.value);
    for side in (if both_strands { 2 } else { 1 }) {
        let dna = if side == 0 { copy(normalized.value) } else { copy(rc.value) };
        for frame in 3 {
            var pos = frame;
            while pos+2 < dna.len {
                var index: i64 = 0;
                for k in 3 { index = index*4 + (match dna[pos+k] { 'T' => 0, 'C' => 1, 'A' => 2, _ => 3 }); }
                if code.starts[index] == '1' {
                    var end = pos+3;
                    while end+2 < dna.len {
                        var stop: i64 = 0;
                        for k in 3 { stop = stop*4 + (match dna[end+k] { 'T' => 0, 'C' => 1, 'A' => 2, _ => 3 }); }
                        if code.stops[stop] == '1' {
                            let protein = translate_with_options(dna[pos..end+3], TranslationOptions { table: table, cds: true });
                            assert(protein.error.len == 0);
                            out.push(ORF { if side == 0 { pos } else { dna.len-end-3 },
                                if side == 0 { end+3 } else { dna.len-pos },
                                if side == 0 { 1 } else { -1 }, frame, copy(protein.value) });
                            break;
                        }
                        end += 3;
                    }
                }
                pos += 3;
            }
        }
    }
    return ORFResult { copy(out), "" };
}

struct RestrictionSite { start: i64, end: i64, strand: i64, top_cut: i64, bottom_cut: i64 }
struct RestrictionResult { sites: RestrictionSite[], error: u8[] }
struct DigestResult { fragments: u8[][], error: u8[] }

// Linear concrete DNA; IUPAC pattern matches either orientation.
// Offsets are boundaries from the oriented recognition start.
// Reverse hits map top=n-(reverse_start+bottom_offset), and vice versa.
// Palindromic recognition patterns report only the forward hit.
// Cuts outside the molecule return an error, never clipped cuts.
fn restriction_sites(text: u8[:], pattern: u8[:], top_offset: i64,
    bottom_offset: i64) -> RestrictionResult {
    var sites: RestrictionSite[>..] = [];
    let dna = normalize_sequence(text); let motif = normalize_sequence(pattern);
    if dna.error.len > 0 || motif.error.len > 0 || motif.value.len == 0 {
        return RestrictionResult { copy(sites), "invalid DNA or empty recognition pattern" };
    }
    for c in dna.value { if codon_bases(c).len != 1 {
        return RestrictionResult { copy(sites), "restriction input requires concrete DNA" };
    } }
    let rc = reverse_complement(motif.value);
    let palindrome = rc.value == motif.value;
    if motif.value.len > dna.value.len { return RestrictionResult { copy(sites), "" }; }
    for pos in 0..(dna.value.len-motif.value.len+1) {
        for side in (if palindrome { 1 } else { 2 }) {
            let p = if side == 0 { copy(motif.value) } else { copy(rc.value) };
            var hit = true;
            for k in p.len {
                var found = false;
                for b in codon_bases(p[k]) { if b == dna.value[pos+k] { found = true; } }
                if !found { hit = false; }
            }
            if !hit { continue; }
            // Check bounds before offset arithmetic can overflow.
            let low = if side == 0 { -pos } else { pos+p.len-dna.value.len };
            let high = if side == 0 { dna.value.len-pos } else { pos+p.len };
            if top_offset < low || top_offset > high ||
                bottom_offset < low || bottom_offset > high {
                return RestrictionResult { [], "cut outside linear molecule" };
            }
            let top = if side == 0 { pos+top_offset } else { pos+p.len-bottom_offset };
            let bottom = if side == 0 { pos+bottom_offset } else { pos+p.len-top_offset };
            if top < 0 || bottom < 0 || top > dna.value.len || bottom > dna.value.len {
                return RestrictionResult { [], "cut outside linear molecule" };
            }
            sites.push(RestrictionSite { pos, pos+p.len, if side == 0 { 1 } else { -1 }, top, bottom });
        }
    }
    return RestrictionResult { copy(sites), "" };
}

// Top-strand fragments only, sorted cuts, duplicates removed.
// No circular topology or sticky-end double-strand assembly.
fn restriction_digest(text: u8[:], pattern: u8[:], top_offset: i64,
    bottom_offset: i64) -> DigestResult {
    let result = restriction_sites(text, pattern, top_offset, bottom_offset);
    var fragments: u8[][>..] = [];
    if result.error.len > 0 { return DigestResult { copy(fragments), copy(result.error) }; }
    let dna = normalize_sequence(text);
    var start: i64 = 0;
    while start < text.len {
        var end = text.len;
        for site in result.sites { if site.top_cut > start && site.top_cut < end { end = site.top_cut; } }
        fragments.push(str(dna.value[start..end])); start = end;
    }
    return DigestResult { copy(fragments), "" };
}
