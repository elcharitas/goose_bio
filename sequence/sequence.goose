namespace bio;
import .genetic_codes;

struct SequenceResult { value: u8[], error: u8[] }
struct GCResult { fraction: f64, error: u8[] }
struct KmerResult { values: u8[][], error: u8[] }

fn seq_upper(c: u8) -> u8 {
    if c >= 'a' && c <= 'z' { return c - 32; }
    return c;
}

fn normalize_sequence(text: u8[:], rna: bool = false) -> SequenceResult {
    var out: u8[>..] = [];
    let alphabet = if rna { "ACGURYSWKMBDHVN" } else { "ACGTRYSWKMBDHVN" };
    for c in text {
        let b = seq_upper(c);
        var valid = false;
        for a in alphabet { if a == b { valid = true; } }
        if !valid { return SequenceResult { "", "invalid nucleotide" }; }
        out.push(b);
    }
    return SequenceResult { copy(out), "" };
}

fn complement(text: u8[:], rna: bool = false) -> SequenceResult {
    let normalized = normalize_sequence(text, rna);
    if normalized.error.len > 0 { return copy(normalized); }
    var out: u8[>..] = [];
    let source = "ACGTRYSWKMBDHVN";
    let target = "TGCAYRSWMKVHDBN";
    for c in normalized.value {
        if c == 'U' { out.push('A'); continue; }
        for a, i in source {
            if a == c { out.push(if rna && target[i] == 'T' { 'U' } else { target[i] }); }
        }
    }
    return SequenceResult { copy(out), "" };
}

fn reverse_complement(text: u8[:], rna: bool = false) -> SequenceResult {
    let result = complement(text, rna);
    if result.error.len > 0 { return copy(result); }
    var out: u8[>..] = [];
    for i in result.value.len { out.push(result.value[result.value.len - i - 1]); }
    return SequenceResult { copy(out), "" };
}

fn transcribe(text: u8[:], reverse: bool = false) -> SequenceResult {
    let result = normalize_sequence(text, reverse);
    if result.error.len > 0 { return copy(result); }
    var out: u8[>..] = [];
    for c in result.value {
        out.push(if !reverse && c == 'T' { 'U' } else if reverse && c == 'U' { 'T' } else { c });
    }
    return SequenceResult { copy(out), "" };
}

// Strict partial codons preserve the positional translate API.
struct TranslationOptions {
    table: i64 = 1,
    rna: bool = false,
    frame: i64 = 0,
    to_stop: bool = false,
    cds: bool = false,
    allow_partial: bool = false,
    gap: u8 = 0
}

fn codon_bases(c: u8) -> u8[] {
    return match c {
        'T', 'U' => "T", 'C' => "C", 'A' => "A", 'G' => "G",
        'R' => "AG", 'Y' => "CT", 'S' => "GC", 'W' => "AT",
        'K' => "GT", 'M' => "AC", 'B' => "CGT", 'D' => "AGT",
        'H' => "ACT", 'V' => "ACG", 'N' => "TCAG", _ => ""
    };
}

// Dual-coding tables use amino acids except at the final CDS stop.
// to_stop is invalid for these tables; no warning channel is available.
// allow_partial discards trailing bases; CDS always requires full codons.
// Valid nucleotides take precedence over the full-gap fallback.
// Translation accepts T and U together; other validators stay strict.
fn translate_with_options(text: u8[:], options: TranslationOptions = TranslationOptions {}) -> SequenceResult {
    let code = genetic_code(options.table);
    if code.id == 0 { return SequenceResult { "", "unsupported genetic code table" }; }
    if options.to_stop && code.dual { return SequenceResult { "", "to_stop is ambiguous for dual-coding stop table" }; }
    let frame = options.frame;
    if frame < 0 || frame > 2 { return SequenceResult { "", "frame must be 0, 1, or 2" }; }
    var normalized: u8[>..] = [];
    for c in text { normalized.push(seq_upper(c)); }
    if normalized.len < frame { return SequenceResult { "", "incomplete codon" }; }
    let length = normalized.len - frame;
    if length % 3 != 0 && (!options.allow_partial || options.cds) {
        return SequenceResult { "", "incomplete codon" };
    }
    if options.cds && length < 6 { return SequenceResult { "", "CDS requires start and stop codons" }; }
    var out: u8[>..] = [];
    var pos = frame;
    while pos + 2 < normalized.len {
        var valid = true;
        var gaps: i64 = 0;
        for j in 3 {
            if codon_bases(normalized[pos+j]).len == 0 { valid = false; }
            if options.gap != 0 && normalized[pos+j] == options.gap { gaps++; }
        }
        if !valid {
            if gaps != 3 || (options.cds && (pos == frame || pos + 3 == normalized.len)) {
                return SequenceResult { "", "invalid nucleotide or gap codon" };
            }
            out.push(options.gap); pos += 3; continue;
        }
        var amino: u8[>..] = [];
        var all_start = true;
        var all_stop = true;
        for a in codon_bases(normalized[pos]) {
            for b in codon_bases(normalized[pos+1]) {
                for c in codon_bases(normalized[pos+2]) {
                    var index: i64 = 0;
                    let triplet: u8[3] = [a,b,c];
                    for base in triplet {
                        let digit: i64 = match base { 'T' => 0, 'C' => 1, 'A' => 2, _ => 3 };
                        index = index * 4 + digit;
                    }
                    let aa = code.amino[index];
                    var seen = false;
                    for x in amino { if x == aa { seen = true; } }
                    if !seen { amino.push(aa); }
                    if code.starts[index] != '1' { all_start = false; }
                    if code.stops[index] != '1' { all_stop = false; }
                }
            }
        }
        var aa: u8 = 'X';
        if amino.len == 1 { aa = amino[0]; }
        if amino.len == 2 {
            var d = false; var n = false; var e = false;
            var q = false; var i = false; var l = false;
            for x in amino {
                if x == 'D' { d = true; } if x == 'N' { n = true; }
                if x == 'E' { e = true; } if x == 'Q' { q = true; }
                if x == 'I' { i = true; } if x == 'L' { l = true; }
            }
            if d && n { aa = 'B'; } if e && q { aa = 'Z'; } if i && l { aa = 'J'; }
        }
        if options.cds {
            if pos == frame {
                if !all_start { return SequenceResult { "", "invalid CDS start codon" }; }
                aa = 'M';
            } else if pos + 3 == normalized.len {
                if !all_stop { return SequenceResult { "", "missing CDS terminal stop" }; }
                break;
            } else if aa == '*' { return SequenceResult { "", "internal CDS stop" }; }
        }
        if options.to_stop && aa == '*' { break; }
        out.push(aa);
        pos += 3;
    }
    return SequenceResult { copy(out), "" };
}

fn translate(text: u8[:], rna: bool = false, frame: i64 = 0) -> SequenceResult {
    return translate_with_options(text, TranslationOptions { rna: rna, frame: frame });
}

// All validated IUPAC bases count in the denominator.
fn gc_content(text: u8[:], rna: bool = false) -> GCResult {
    let result = normalize_sequence(text, rna);
    if result.error.len > 0 { return GCResult { 0, copy(result.error) }; }
    if text.len == 0 { return GCResult { 0, "empty sequence" }; }
    var count: i64 = 0;
    for c in result.value { if c == 'G' || c == 'C' { count++; } }
    return GCResult { (count as f64) / text.len, "" };
}

fn kmers(text: u8[:], k: i64, rna: bool = false) -> KmerResult {
    if k <= 0 { return KmerResult { [], "k must be positive" }; }
    let result = normalize_sequence(text, rna);
    if result.error.len > 0 { return KmerResult { [], copy(result.error) }; }
    var out: u8[][>..] = [];
    if k <= text.len {
        for i in text.len - k + 1 { out.push(str(result.value[i..i+k])); }
    }
    return KmerResult { copy(out), "" };
}
