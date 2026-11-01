namespace bio;
import std;
import math;

struct GenotypeValue { allele: i64, phased: bool, vector_end: bool, valid: bool }
struct GenotypeStrings { samples: u8[][], error: u8[] }

fn decode_genotype(value: i32) -> GenotypeValue {
    if value == -2147483647 { return GenotypeValue { -1, false, true, true }; }
    if value < 0 { return GenotypeValue { -1, false, false, false }; }
    GenotypeValue { (value as i64) / 2 - 1, value % 2 == 1, false, true }
}

fn encode_genotype(allele: i64, phased: bool = false) -> i32, bool {
    if allele < -1 || allele > 1073741822 { return 0, false; }
    return ((allele + 1) * 2 + (if phased { 1 } else { 0 })) as i32, true;
}

// FORMAT values are sample-major; vector-end pads shorter ploidies.
fn genotype_strings(values: const i32[:], sample_count: i64) -> GenotypeStrings {
    if sample_count < 0 || (sample_count == 0 && values.len != 0) {
        return GenotypeStrings { [], "invalid genotype sample count" };
    }
    if sample_count == 0 { return GenotypeStrings { [], "" }; }
    if values.len == 0 || values.len % sample_count != 0 {
        return GenotypeStrings { [], "invalid genotype dimensions" };
    }
    let width = values.len / sample_count;
    var samples: u8[][>..] = [];
    for sample in sample_count {
        var text: u8[>..] = [];
        var ended = false;
        for column in width {
            let call = decode_genotype(values[sample * width + column]);
            if !call.valid { return GenotypeStrings { [], "invalid encoded genotype" }; }
            if call.vector_end { ended = true; continue; }
            if ended { return GenotypeStrings { [], "genotype after vector end" }; }
            if column > 0 { text.push(if call.phased { '|' } else { '/' }); }
            if call.allele == -1 { text.push('.'); }
            else { text.append(str(call.allele)); }
        }
        if text.len == 0 { return GenotypeStrings { [], "empty genotype sample" }; }
        samples.push(copy(text));
    }
    GenotypeStrings { copy(samples), "" }
}

struct CigarOperation { length: i64, operation: u8 }
struct CigarResult { operations: CigarOperation[], error: u8[] }

fn parse_cigar(text: const u8[:]) -> CigarResult {
    if text == "*" { return CigarResult { [], "" }; }
    if text.len == 0 { return CigarResult { [], "empty CIGAR" }; }
    var operations: CigarOperation[>..] = [];
    var length:     i64                 = 0;
    var digits = false;
    for c in text {
        if c >= '0' && c <= '9' {
            let digit = (c - '0') as i64;
            if length > (268435455 - digit) / 10 {
                return CigarResult { [], "CIGAR length exceeds BAM limit" };
            }
            length = length * 10 + digit; digits = true;
        } else {
            var valid = false;
            for op in "MIDNSHP=X" { if c == op { valid = true; } }
            if !valid || !digits || length == 0 { return CigarResult { [], "invalid CIGAR operation" }; }
            operations.push(CigarOperation { length, c });
            length = 0; digits = false;
        }
    }
    if digits { return CigarResult { [], "unterminated CIGAR length" }; }
    CigarResult { copy(operations), "" }
}

fn cigar_span(operations: const CigarOperation[:], reference: bool) -> i64 {
    var total: i64 = 0;
    for op in operations {
        assert(op.length > 0 && op.length <= 268435455);
        if op.operation == 'M' || op.operation == '=' || op.operation == 'X' ||
           (reference && (op.operation == 'D' || op.operation == 'N')) ||
           (!reference && (op.operation == 'I' || op.operation == 'S')) {
            assert(total <= 9223372036854775807 - op.length);
            total += op.length;
        } else {
            assert(op.operation == 'I' || op.operation == 'D' || op.operation == 'N' ||
                   op.operation == 'S' || op.operation == 'H' || op.operation == 'P');
        }
    }
    total
}

struct BCFFloatValue { value: f64, kind: i64 }

// kind: -1 invalid, 0 numeric, 1 missing, 2 vector end, 3 other NaN.
fn decode_bcf_float(bits: i64) -> BCFFloatValue {
    if bits < 0 || bits > 4294967295 { return BCFFloatValue { 0.0, -1 }; }
    if bits == 2139095041 { return BCFFloatValue { 0.0, 1 }; }
    if bits == 2139095042 { return BCFFloatValue { 0.0, 2 }; }
    let exponent = (bits >> 23) & 255;
    let fraction = bits & 8388607;
    if exponent == 255 && fraction != 0 { return BCFFloatValue { 0.0, 3 }; }
    var value = 0.0;
    if exponent == 255 { value = -log(0.0); }
    else if exponent == 0 { value = fraction * pow(2.0, -149.0); }
    else { value = (1.0 + fraction / 8388608.0) * pow(2.0, exponent - 127.0); }
    if (bits & 2147483648) != 0 { value = -value; }
    BCFFloatValue { value, 0 }
}
