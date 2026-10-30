import bio from "../..";
import bio.sequence.sequence;
import bio.alignment.pairwise;
import bio.sequence.annotations;
import bio.search.motifs;
fn emit(result: bio::SequenceResult) {
    if result.error.len > 0 { print("ERROR"); }
    else { print(result.value); }
}
fn main() {
    let dna: u8[][] = ["", "A", "acgt", "ACGTRYSWKMBDHVN", "NNNN", "T"];
    for text in dna {
        emit(bio::complement(text));
        emit(bio::reverse_complement(text));
        emit(bio::transcribe(text));
    }
    let rna: u8[][] = ["", "U", "augc", "ACGURYSWKMBDHVN", "NNNN"];
    for text in rna {
        emit(bio::complement(text, true));
        emit(bio::reverse_complement(text, true));
        emit(bio::transcribe(text, true));
    }
    let bases = "TCAG";
    for a in bases { for b in bases { for c in bases {
        let codon: u8[3] = [a, b, c];
        emit(bio::translate(codon));
    } } }
    let codons: u8[][] = ["", "ATGTTTTAA", "NNN", "GCN", "TAR", "AT", "AATG", "AAATG"];
    for text, i in codons {
        emit(bio::translate(text, false, if i == 6 { 1 } else if i == 7 { 2 } else { 0 }));
    }
    let table_ids: i64[] = [1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 15, 16, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
    let ambiguous = "TCAGRYWSKMBDHVN";
    for table in table_ids {
        for a in ambiguous { for b in ambiguous { for c in ambiguous {
            let codon: u8[3] = [a,b,c];
            emit(bio::translate_with_options(codon, bio::TranslationOptions { table: table }));
        } } }
    }
    emit(bio::translate_with_options("ATGA", bio::TranslationOptions { allow_partial: true }));
    emit(bio::translate_with_options("AT", bio::TranslationOptions { allow_partial: true }));
    emit(bio::translate_with_options("ATGTAAATG", bio::TranslationOptions { to_stop: true }));
    emit(bio::translate_with_options("ATG---TAA", bio::TranslationOptions { gap: '-' }));
    emit(bio::translate_with_options("ATG-A-TAA", bio::TranslationOptions { gap: '-' }));
    emit(bio::translate_with_options("ATGTAAATGTAA", bio::TranslationOptions { cds: true }));
    emit(bio::translate_with_options("ATGAA", bio::TranslationOptions { cds: true, allow_partial: true }));
    emit(bio::translate_with_options("ATGAAA", bio::TranslationOptions { cds: true }));
    emit(bio::translate_with_options("AAAATGTAA", bio::TranslationOptions { cds: true }));
    emit(bio::translate_with_options("ATGTANTAA", bio::TranslationOptions { cds: true }));
    emit(bio::translate_with_options("ATGTARTAA", bio::TranslationOptions { cds: true }));
    emit(bio::translate_with_options("ATGTGA", bio::TranslationOptions { table: 27, cds: true }));
    emit(bio::translate_with_options("ATGTGA", bio::TranslationOptions { table: 27, to_stop: true }));
    emit(bio::translate_with_options("AUGGCNUAR", bio::TranslationOptions { rna: true }));
    emit(bio::translate_with_options("AATGTAA", bio::TranslationOptions { frame: 1, cds: true }));
    emit(bio::translate_with_options("AAA", bio::TranslationOptions { gap: 'A' }));
    emit(bio::translate_with_options("GGA", bio::TranslationOptions { gap: 'G' }));
    emit(bio::translate_with_options("TAA???", bio::TranslationOptions { to_stop: true }));
    emit(bio::translate_with_options("ATG?", bio::TranslationOptions { allow_partial: true }));
    emit(bio::translate_with_options("AUG", bio::TranslationOptions {  }));
    emit(bio::translate_with_options("ATU", bio::TranslationOptions {  }));
    emit(bio::translate_with_options("augatu", bio::TranslationOptions {  }));
    emit(bio::translate_with_options("ATG???", bio::TranslationOptions {  }));
    emit(bio::translate_with_options("???TAA", bio::TranslationOptions { to_stop: true }));
    emit(bio::translate_with_options("ATG??", bio::TranslationOptions { allow_partial: true }));
    emit(bio::translate_with_options("ATG?AA", bio::TranslationOptions { allow_partial: true }));
    emit(bio::translate_with_options("?ATG", bio::TranslationOptions { frame: 1 }));
    emit(bio::translate_with_options("ATGTAA???", bio::TranslationOptions { to_stop: true }));
    emit(bio::translate_with_options("ATG---TAA", bio::TranslationOptions { gap: '-', cds: true }));
    emit(bio::translate_with_options("ATGAAATAA", bio::TranslationOptions { gap: 'A', cds: true }));
    emit(bio::translate_with_options("AUGATUTAA", bio::TranslationOptions { rna: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("TTGGCTTGA", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("CTGGCTTGA", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 1, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATTGCTAGA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATTGCTAGG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATCGCTAGA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATCGCTAGG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATAGCTAGA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATAGCTAGG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATGGCTAGA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATGGCTAGG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("GTGGCTAGA", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("GTGGCTAGG", bio::TranslationOptions { table: 2, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 3, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAG", bio::TranslationOptions { table: 3, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 3, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 3, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 3, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 3, cds: true }));
    emit(bio::translate_with_options("TTAGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("TTAGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 4, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAA", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAG", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAA", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAG", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAG", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 5, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 6, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 9, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 9, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 9, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 9, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 10, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 10, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("TTGGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("CTGGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATTGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATCGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATAGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("GTGGCTTGA", bio::TranslationOptions { table: 11, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 12, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 12, cds: true }));
    emit(bio::translate_with_options("CTGGCTTGA", bio::TranslationOptions { table: 12, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 12, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 12, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 12, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAG", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 13, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 14, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 15, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 15, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 16, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 16, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 21, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 21, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 21, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 21, cds: true }));
    emit(bio::translate_with_options("ATGGCTTCA", bio::TranslationOptions { table: 22, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 22, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 22, cds: true }));
    emit(bio::translate_with_options("ATTGCTTTA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAG", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATTGCTTGA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATGGCTTTA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("GTGGCTTTA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("GTGGCTTGA", bio::TranslationOptions { table: 23, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 24, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 25, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 25, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 25, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 25, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 25, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 25, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 26, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 26, cds: true }));
    emit(bio::translate_with_options("CTGGCTTGA", bio::TranslationOptions { table: 26, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 26, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 26, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 26, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 27, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 28, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 28, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 28, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 29, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 30, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 31, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 31, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("TTGGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("CTGGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATTGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATTGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATCGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATCGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATAGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATAGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("ATGGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("GTGGCTTGA", bio::TranslationOptions { table: 32, cds: true }));
    emit(bio::translate_with_options("TTGGCTTAG", bio::TranslationOptions { table: 33, cds: true }));
    emit(bio::translate_with_options("CTGGCTTAG", bio::TranslationOptions { table: 33, cds: true }));
    emit(bio::translate_with_options("ATGGCTTAG", bio::TranslationOptions { table: 33, cds: true }));
    emit(bio::translate_with_options("GTGGCTTAG", bio::TranslationOptions { table: 33, cds: true }));
    let words: u8[][] = ["A", "C", "AA", "AC", "CA", "CC", "AAA", "ACA", "NN", "ACGT", "AGT"];
    for local in 2 { for a in words { for b in words {
        print(bio::affine_alignment(a, b, 2, -1, 3, 1, local == 1).score);
    } } }
    print(bio::affine_alignment("", "", 2, -1, 3, 1).score);
    print(bio::affine_alignment("AAA", "", 2, -1, 3, 1).score);
    print(bio::affine_alignment("", "AAA", 2, -1, 3, 1).score);
    let feature = bio::AnnotatedFeature { "CDS", [
        bio::LocationPart { 0, 2, 1, false },
        bio::LocationPart { 4, 6, -1, false }
    ], [] };
    emit(bio::extract_feature("ACGTAGTC", copy(feature)));
    let record = bio::AnnotatedRecord { "id", "", "ACGTAGTC", [], [copy(feature)], false };
    let reversed = bio::reverse_complement_record(copy(record));
    print(reversed.record.sequence);
    for f in reversed.record.features {
        emit(bio::extract_feature(reversed.record.sequence, copy(f)));
        for p in f.parts { print(p.start); print(p.end); print(p.strand); }
    }
    let sites: u8[][] = ["AC", "AT"];
    let counts = bio::motif_counts(sites);
    let pwm = bio::motif_pwm(counts, 1.0);
    let bg: f64[4] = [0.25, 0.25, 0.25, 0.25];
    let pssm = bio::motif_pssm(pwm, bg);
    for v in counts.values { print(v); }
    for v in pwm.values { print(v); }
    for v in pssm.values { print(v); }
}
