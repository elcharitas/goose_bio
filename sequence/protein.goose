/* Tables derive from Biopython 1.88 IUPACData, ProtParamData, and IsoelectricPoint; see
 * docs/BIOPYTHON_LICENSE.rst. Biopython contributors retain copyright, including Yair Benita (2003)
 * and Tianyi Shi (2020) for isoelectric point code. */
namespace bio;
import std;

// Biopython 1.88 data; see docs/BIOPYTHON_LICENSE.rst.
// Linear unmodified chains; free termini, water lost per peptide bond.
// Only the 20 standard residues; lowercase is normalized, empty rejected.

/* Check error before using fields. Fractions range from 0 to 1. GRAVY uses Kyte-Doolittle values;
 * aromaticity counts F, W, and Y. Extinction uses 5500/W, 1490/Y, and 125/cystine pair in M^-1 cm^-1,
 * rounding odd cysteine counts down. Helix/turn/sheet propensities use overlapping EMALK/NPGSD/VIYFWLT
 * sets; these are not structural predictions. */
struct ProteinProperties {
    sequence:           u8[], counts: i64[], fractions: f64[],
    molecular_weight:   f64, aromaticity: f64, gravy: f64,
    charge:             f64, isoelectric_point: f64,
    extinction_reduced: i64, extinction_disulfide: i64,
    helix:              f64, turn: f64, sheet: f64, error: u8[],
}

/* Counts and fractions follow ACDEFGHIKLMNPQRSTVWY order. Input accepts lowercase standard residues;
 * empty chains, whitespace, stops, ambiguity, U, and O reject. */
fn protein_index(c: u8) -> i64 {
    for aa, i in "ACDEFGHIKLMNPQRSTVWY" { if aa == c { return i; } }
    return -1;
}
// Bjellqvist pKas with sequence-specific terminal corrections.

/* Uses Bjellqvist pKas and terminal corrections. Supported pH is 0..14; pI uses bracket 4.05..12 and
 * stopping width 0.0001. Extreme compositions can reach bracket limits. */
fn protein_charge(sequence: const u8[:], counts: const i64[:], ph: f64) -> f64 {
    var nt = 7.5; var ct = 3.55;
    if sequence[0] == 'A' { nt = 7.59; }
    if sequence[0] == 'M' { nt = 7.0; }
    if sequence[0] == 'S' { nt = 6.93; }
    if sequence[0] == 'P' { nt = 8.36; }
    if sequence[0] == 'T' { nt = 6.82; }
    if sequence[0] == 'V' { nt = 7.44; }
    if sequence[0] == 'E' { nt = 7.7; }
    if sequence[sequence.len - 1] == 'D' { ct = 4.55; }
    if sequence[sequence.len - 1] == 'E' { ct = 4.75; }
    var charge = 1.0 / (pow(10.0, ph - nt) + 1.0) - 1.0 / (pow(10.0, ct - ph) + 1.0);
    charge += counts[8] / (pow(10.0, ph - 10.0) + 1.0);
    charge += counts[14] / (pow(10.0, ph - 12.0) + 1.0);
    charge += counts[6] / (pow(10.0, ph - 5.98) + 1.0);
    charge -= counts[2] / (pow(10.0, 4.05 - ph) + 1.0);
    charge -= counts[3] / (pow(10.0, 4.45 - ph) + 1.0);
    charge -= counts[1] / (pow(10.0, 9.0 - ph) + 1.0);
    charge -= counts[19] / (pow(10.0, 10.0 - ph) + 1.0);
    return charge;
}
// pI uses the [4.05,12] bracket and 0.0001 stopping width.

/* Defaults are pH 7.0 and average masses. Mass describes a linear unmodified chain with free termini:
 * sum free residue masses minus water per peptide bond. Water is 18.0153 average or 18.010565
 * monoisotopic daltons. No instability, flexibility, aliphatic index, custom hydropathy windows,
 * modified residues, cyclic proteins, or disulfide-specific masses. */
fn protein_properties(text: const u8[:], ph: f64 = 7.0,
    monoisotopic: bool = false) -> ProteinProperties {
    if text.len == 0 || !(ph >= 0.0 && ph <= 14.0) {
        return ProteinProperties { "", [], [], 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0.0, 0.0, 0.0, "empty protein or invalid pH" };
    }
    var sequence: u8[>..] = []; var counts: i64[>..] = [];
    for k in 20 { counts.push(0); }
    for c in text {
        let aa = if c >= 'a' && c <= 'z' { c - 32 } else { c };
        let index = protein_index(aa);
        if index < 0 {
            return ProteinProperties { "", [], [], 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0.0, 0.0, 0.0, "unsupported protein residue" };
        }
        sequence.push(aa); counts[index] += 1;
    }
    let average: f64[] = [89.0932, 121.1582, 133.1027, 147.1293, 165.1891, 75.0666, 155.1546, 131.1729, 146.1876, 131.1729, 149.2113, 132.1179, 115.1305, 146.1445, 174.201, 105.0926, 119.1192, 117.1463, 204.2252, 181.1885];
    let mono:    f64[] = [89.047678, 121.019749, 133.037508, 147.053158, 165.078979, 75.032028, 155.069477, 131.094629, 146.105528, 131.094629, 149.051049, 132.053492, 115.063329, 146.069142, 174.111676, 105.042593, 119.058243, 117.078979, 204.089878, 181.073893];
    let kd:      f64[] = [1.8, 2.5, -3.5, -3.5, 2.8, -0.4, -3.2, 4.5, -3.9, 3.8, 1.9, -3.5, -1.6, -3.5, -4.5, -0.8, -0.7, 4.2, -0.9, -1.3];
    var weight = 0.0; var gravy = 0.0; var fractions: f64[>..] = [];
    for n, i in counts {
        weight += n * (if monoisotopic { mono[i] } else { average[i] });
        gravy += n * kd[i]; fractions.push(n / text.len as f64);
    }
    weight -= (text.len - 1) * (if monoisotopic { 18.010565 } else { 18.0153 });
    var low = 4.05; var high = 12.0; var pi = 7.775;
    while high - low > 0.0001 {
        if protein_charge(sequence, counts, pi) > 0.0 { low = pi; } else { high = pi; }
        pi = (low + high) / 2.0;
    }
    var helix = 0.0; var turn = 0.0; var sheet = 0.0;
    for c in "EMALK" { helix += fractions[protein_index(c)]; }
    for c in "NPGSD" { turn += fractions[protein_index(c)]; }
    for c in "VIYFWLT" { sheet += fractions[protein_index(c)]; }
    let extinction = counts[18] * 5500 + counts[19] * 1490;
    return ProteinProperties { copy(sequence), copy(counts), copy(fractions), weight,
        fractions[4] + fractions[18] + fractions[19], gravy / text.len,
        protein_charge(sequence, counts, ph), pi, extinction,
        extinction + counts[1] / 2 * 125, helix, turn, sheet, "" };
}
