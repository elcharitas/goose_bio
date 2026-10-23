namespace bio;
import math;

/* Empty error means success, classified finite or zero. Errors are invalid, overflow, or underflow,
 * with an unusable zero placeholder. Nonzero subnormals count as finite. Signed scales and signed zero
 * work; NaN/infinite scales reject even when k>n. */
struct CombinationsResult { value: f64, classification: u8[], error: u8[] }

/* Returns scale times the coefficient, dividing by j+1 before multiplying by n-j for min(k,n-k)
 * iterations. Counts are 0..2^53-1, with at most 1,000,000 iterations before arithmetic; negative
 * counts reject. k>n gives zero; k=0 or k=n gives scale. Overflow errors explicitly rather than
 * returning Rust infinity. A division from nonzero to zero is underflow, defensive here because
 * accumulator growth prevents it after the first multiplication. */
fn scaled_combinations(n: i64, k: i64, scale: f64) -> CombinationsResult {
    if n < 0 || k < 0 || n > 9007199254740991 || k > 9007199254740991 {
        return CombinationsResult {0, "invalid", "counts outside 0..2^53-1"};
    }
    if is_nan(scale) || is_inf(scale) {
        return CombinationsResult {0, "invalid", "finite scale required"};
    }
    if k > n { return CombinationsResult {0, "zero", ""}; }
    let steps = if k < n-k { k } else { n-k };
    if steps > 1000000 {
        return CombinationsResult {0, "invalid", "iteration limit exceeded"};
    }
    var value = scale;
    for j in steps {
        let divided = value / (j+1);
        if value != 0 && divided == 0 {
            return CombinationsResult {0, "underflow", "division underflow"};
        }
        value = divided * (n-j);
        if is_inf(value) {
            return CombinationsResult {0, "overflow", "multiplication overflow"};
        }
    }
    return CombinationsResult {value, if value == 0 { "zero" } else { "finite" }, ""};
}

/* Counts subsets without enumeration. Binary64 intermediates may lose subnormal units even for
 * exactly representable results; no arbitrary precision or correctly rounded coefficient guarantee.
 * Nonzero finite scale cannot yield mathematical zero since the coefficient is at least one.
 * Smallest subnormals can lose precision. Rust-Bio MIT notice remains in
 * tests/reference/combinatorics/RUST_BIO_LICENSE.md. */
fn combinations(n: i64, k: i64) -> CombinationsResult {
    return scaled_combinations(n, k, 1.0);
}

/* Counts multisets using n+k-1 choose k, checking addition before it occurs. The transformed count
 * also caps at 2^53-1. Results are one for (0,0) and (n,0), and zero for (0,k>0). No enumeration
 * occurs. */
fn combinations_with_repl(n: i64, k: i64) -> CombinationsResult {
    if n < 0 || k < 0 || n > 9007199254740991 || k > 9007199254740991 {
        return CombinationsResult {0, "invalid", "counts outside 0..2^53-1"};
    }
    if n == 0 {
        return CombinationsResult {if k == 0 { 1.0 } else { 0.0 },
            if k == 0 { "finite" } else { "zero" }, ""};
    }
    if k > 9007199254740991 - (n-1) {
        return CombinationsResult {0, "invalid", "repetition count exceeds 2^53-1"};
    }
    return combinations(n-1+k, k);
}
