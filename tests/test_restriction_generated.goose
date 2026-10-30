import bio from "..";
import bio.sequence.restriction;
fn main() {
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("GAATTC", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAATTC", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "G"); }
if i == 1 { assert(f == "AATTC"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("GAATTC", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAATTC", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCG"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("AAAGAATTCTTTTTTTTTTTTTTTTTTTT", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAGAATTCTTTTTTTTTTTTTTTTTTTT", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAG"); }
if i == 1 { assert(f == "AATTCTTTTTTTTTTTTTTTTTTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAGAATTCTTTTTTTTTTTTTTTTTTTT", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAGAATTCTTTTTTTTTTTTTTTTTTTT", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTTTTTTTTTTTTTTTTTTTTAAAG"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAGAATTCTTT", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 21 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAGAATTCTTT", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAG"); }
if i == 1 { assert(f == "AATTCTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAGAATTCTTT", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 21 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAGAATTCTTT", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTTTAAAAAAAAAAAAAAAAAAAAG"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("GAATTCGAATTCGAATTC", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 7 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAATTCGAATTCGAATTC", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 4);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "G"); }
if i == 1 { assert(f == "AATTCG"); }
if i == 2 { assert(f == "AATTCG"); }
if i == 3 { assert(f == "AATTC"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("GAATTCGAATTCGAATTC", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 7 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAATTCGAATTCGAATTC", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCG"); }
if i == 1 { assert(f == "AATTCG"); }
if i == 2 { assert(f == "AATTCG"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("TTCAAAAAAAAAAAAAAAAAAAAGAA", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("TTCAAAAAAAAAAAAAAAAAAAAGAA", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTCAAAAAAAAAAAAAAAAAAAAGAA"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("TTCAAAAAAAAAAAAAAAAAAAAGAA", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 24 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTCAAAAAAAAAAAAAAAAAAAAGAA", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCAAAAAAAAAAAAAAAAAAAAG"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("GAATTCAAGCAAGGCGATTCCTCTTCTGGGTTACGTTTGCTCATATGTCTACTACTAAAATCTACCATGCAGATTG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAATTCAAGCAAGGCGATTCCTCTTCTGGGTTACGTTTGCTCATATGTCTACTACTAAAATCTACCATGCAGATTG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "G"); }
if i == 1 { assert(f == "AATTCAAGCAAGGCGATTCCTCTTCTGGGTTACGTTTGCTCATATGTCTACTACTAAAATCTACCATGCAGATTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GAATTCAAGCAAGGCGATTCCTCTTCTGGGTTACGTTTGCTCATATGTCTACTACTAAAATCTACCATGCAGATTG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAATTCAAGCAAGGCGATTCCTCTTCTGGGTTACGTTTGCTCATATGTCTACTACTAAAATCTACCATGCAGATTG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCAAGCAAGGCGATTCCTCTTCTGGGTTACGTTTGCTCATATGTCTACTACTAAAATCTACCATGCAGATTGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TAGTCCTCTCGACATTCATGAATTACCCGGTAGAAAGGTTGGAATTCGTCGCCATGTACGCGGTTGCCTTAGCAGG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAGTCCTCTCGACATTCATGAATTACCCGGTAGAAAGGTTGGAATTCGTCGCCATGTACGCGGTTGCCTTAGCAGG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TAGTCCTCTCGACATTCATGAATTACCCGGTAGAAAGGTTGG"); }
if i == 1 { assert(f == "AATTCGTCGCCATGTACGCGGTTGCCTTAGCAGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TAGTCCTCTCGACATTCATGAATTACCCGGTAGAAAGGTTGGAATTCGTCGCCATGTACGCGGTTGCCTTAGCAGG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAGTCCTCTCGACATTCATGAATTACCCGGTAGAAAGGTTGGAATTCGTCGCCATGTACGCGGTTGCCTTAGCAGG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCGTCGCCATGTACGCGGTTGCCTTAGCAGGTAGTCCTCTCGACATTCATGAATTACCCGGTAGAAAGGTTGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTAAGAAATGAATCACTGCGTTGTGGAGTTGATCTTTTTGGAATTCATCCAATCGTGTCAGGATAACGATTACGCG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 41 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTAAGAAATGAATCACTGCGTTGTGGAGTTGATCTTTTTGGAATTCATCCAATCGTGTCAGGATAACGATTACGCG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTAAGAAATGAATCACTGCGTTGTGGAGTTGATCTTTTTGG"); }
if i == 1 { assert(f == "AATTCATCCAATCGTGTCAGGATAACGATTACGCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTAAGAAATGAATCACTGCGTTGTGGAGTTGATCTTTTTGGAATTCATCCAATCGTGTCAGGATAACGATTACGCG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 41 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTAAGAAATGAATCACTGCGTTGTGGAGTTGATCTTTTTGGAATTCATCCAATCGTGTCAGGATAACGATTACGCG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCATCCAATCGTGTCAGGATAACGATTACGCGTTAAGAAATGAATCACTGCGTTGTGGAGTTGATCTTTTTGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCGTCCGTAATACCTGGGGAATTCTCATTTATCCGTCTTCAGACTGGGCTTGGCCAGAACTGATTTGTCCACCAGT", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 19 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCGTCCGTAATACCTGGGGAATTCTCATTTATCCGTCTTCAGACTGGGCTTGGCCAGAACTGATTTGTCCACCAGT", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCGTCCGTAATACCTGGGG"); }
if i == 1 { assert(f == "AATTCTCATTTATCCGTCTTCAGACTGGGCTTGGCCAGAACTGATTTGTCCACCAGT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCGTCCGTAATACCTGGGGAATTCTCATTTATCCGTCTTCAGACTGGGCTTGGCCAGAACTGATTTGTCCACCAGT", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 19 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCGTCCGTAATACCTGGGGAATTCTCATTTATCCGTCTTCAGACTGGGCTTGGCCAGAACTGATTTGTCCACCAGT", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTCATTTATCCGTCTTCAGACTGGGCTTGGCCAGAACTGATTTGTCCACCAGTGCGTCCGTAATACCTGGGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AAGCATGCAGTTAGAATAAGTCGGCTTAAGCGTCGGGGCTGAATTCTCGATTAAGGGGTCGGGCCCCGTGGCGGGT", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 41 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAGCATGCAGTTAGAATAAGTCGGCTTAAGCGTCGGGGCTGAATTCTCGATTAAGGGGTCGGGCCCCGTGGCGGGT", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAGCATGCAGTTAGAATAAGTCGGCTTAAGCGTCGGGGCTG"); }
if i == 1 { assert(f == "AATTCTCGATTAAGGGGTCGGGCCCCGTGGCGGGT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AAGCATGCAGTTAGAATAAGTCGGCTTAAGCGTCGGGGCTGAATTCTCGATTAAGGGGTCGGGCCCCGTGGCGGGT", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 41 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAGCATGCAGTTAGAATAAGTCGGCTTAAGCGTCGGGGCTGAATTCTCGATTAAGGGGTCGGGCCCCGTGGCGGGT", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTCGATTAAGGGGTCGGGCCCCGTGGCGGGTAAGCATGCAGTTAGAATAAGTCGGCTTAAGCGTCGGGGCTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTCGCTCGGTCGATCCCTCATCGAATCAGCCTTTCAACGTTAATCTGAATGTGAATTCTACATAGATAGTCTTCTC", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 53 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTCGCTCGGTCGATCCCTCATCGAATCAGCCTTTCAACGTTAATCTGAATGTGAATTCTACATAGATAGTCTTCTC", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTCGCTCGGTCGATCCCTCATCGAATCAGCCTTTCAACGTTAATCTGAATGTG"); }
if i == 1 { assert(f == "AATTCTACATAGATAGTCTTCTC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTCGCTCGGTCGATCCCTCATCGAATCAGCCTTTCAACGTTAATCTGAATGTGAATTCTACATAGATAGTCTTCTC", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 53 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTCGCTCGGTCGATCCCTCATCGAATCAGCCTTTCAACGTTAATCTGAATGTGAATTCTACATAGATAGTCTTCTC", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTACATAGATAGTCTTCTCTTCGCTCGGTCGATCCCTCATCGAATCAGCCTTTCAACGTTAATCTGAATGTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGAATTCAAGGTACTTACTGAAAACTGACGACGCATTATACTATATGTAAAAGGCATATGTTACTCGCAGCCCAGT", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 2 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGAATTCAAGGTACTTACTGAAAACTGACGACGCATTATACTATATGTAAAAGGCATATGTTACTCGCAGCCCAGT", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TG"); }
if i == 1 { assert(f == "AATTCAAGGTACTTACTGAAAACTGACGACGCATTATACTATATGTAAAAGGCATATGTTACTCGCAGCCCAGT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGAATTCAAGGTACTTACTGAAAACTGACGACGCATTATACTATATGTAAAAGGCATATGTTACTCGCAGCCCAGT", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 2 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGAATTCAAGGTACTTACTGAAAACTGACGACGCATTATACTATATGTAAAAGGCATATGTTACTCGCAGCCCAGT", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCAAGGTACTTACTGAAAACTGACGACGCATTATACTATATGTAAAAGGCATATGTTACTCGCAGCCCAGTTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCAGGTGAGAATTCTACACTGAACTGTACCGATTACACACACGCTCTAGTGCGGAAAAACCGCGGGGAAGGTCCAA", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 9 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCAGGTGAGAATTCTACACTGAACTGTACCGATTACACACACGCTCTAGTGCGGAAAAACCGCGGGGAAGGTCCAA", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCAGGTGAG"); }
if i == 1 { assert(f == "AATTCTACACTGAACTGTACCGATTACACACACGCTCTAGTGCGGAAAAACCGCGGGGAAGGTCCAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCAGGTGAGAATTCTACACTGAACTGTACCGATTACACACACGCTCTAGTGCGGAAAAACCGCGGGGAAGGTCCAA", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 9 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCAGGTGAGAATTCTACACTGAACTGTACCGATTACACACACGCTCTAGTGCGGAAAAACCGCGGGGAAGGTCCAA", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTACACTGAACTGTACCGATTACACACACGCTCTAGTGCGGAAAAACCGCGGGGAAGGTCCAACCAGGTGAG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ATTGATTGAAAAGTAATGTCTAGAATTCCTTTGCCTTTGTTAACGCCGCTGGGAACATGTTATACGGCTTGAGGTG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 23 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATTGATTGAAAAGTAATGTCTAGAATTCCTTTGCCTTTGTTAACGCCGCTGGGAACATGTTATACGGCTTGAGGTG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATTGATTGAAAAGTAATGTCTAG"); }
if i == 1 { assert(f == "AATTCCTTTGCCTTTGTTAACGCCGCTGGGAACATGTTATACGGCTTGAGGTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ATTGATTGAAAAGTAATGTCTAGAATTCCTTTGCCTTTGTTAACGCCGCTGGGAACATGTTATACGGCTTGAGGTG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 23 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATTGATTGAAAAGTAATGTCTAGAATTCCTTTGCCTTTGTTAACGCCGCTGGGAACATGTTATACGGCTTGAGGTG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCCTTTGCCTTTGTTAACGCCGCTGGGAACATGTTATACGGCTTGAGGTGATTGATTGAAAAGTAATGTCTAG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGGGGAATTCCAGTAGCCGCCTGTATAAGTTCCCGTCCTAGCGTTACTTACAGCTCGCTATTTCTGAAGCGCGCCG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGGGGAATTCCAGTAGCCGCCTGTATAAGTTCCCGTCCTAGCGTTACTTACAGCTCGCTATTTCTGAAGCGCGCCG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGGGG"); }
if i == 1 { assert(f == "AATTCCAGTAGCCGCCTGTATAAGTTCCCGTCCTAGCGTTACTTACAGCTCGCTATTTCTGAAGCGCGCCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGGGGAATTCCAGTAGCCGCCTGTATAAGTTCCCGTCCTAGCGTTACTTACAGCTCGCTATTTCTGAAGCGCGCCG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGGGGAATTCCAGTAGCCGCCTGTATAAGTTCCCGTCCTAGCGTTACTTACAGCTCGCTATTTCTGAAGCGCGCCG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCCAGTAGCCGCCTGTATAAGTTCCCGTCCTAGCGTTACTTACAGCTCGCTATTTCTGAAGCGCGCCGTGGGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AAGGAATTCTCTATCGATTCCGAAGACACCCCCTACCAATCAGCGGGGGCTCTGACGACAGAGAGCTTCCACTGTG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAGGAATTCTCTATCGATTCCGAAGACACCCCCTACCAATCAGCGGGGGCTCTGACGACAGAGAGCTTCCACTGTG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAGG"); }
if i == 1 { assert(f == "AATTCTCTATCGATTCCGAAGACACCCCCTACCAATCAGCGGGGGCTCTGACGACAGAGAGCTTCCACTGTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AAGGAATTCTCTATCGATTCCGAAGACACCCCCTACCAATCAGCGGGGGCTCTGACGACAGAGAGCTTCCACTGTG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAGGAATTCTCTATCGATTCCGAAGACACCCCCTACCAATCAGCGGGGGCTCTGACGACAGAGAGCTTCCACTGTG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCTCTATCGATTCCGAAGACACCCCCTACCAATCAGCGGGGGCTCTGACGACAGAGAGCTTCCACTGTGAAGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTAGCCCTGGCCAGCTTTCATGGTGGTACGGATGCTCTGAGTTCTGAATTCGATATGGGCTCTGCACGATCAATCG", "EcoRI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 46 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTAGCCCTGGCCAGCTTTCATGGTGGTACGGATGCTCTGAGTTCTGAATTCGATATGGGCTCTGCACGATCAATCG", "EcoRI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTAGCCCTGGCCAGCTTTCATGGTGGTACGGATGCTCTGAGTTCTG"); }
if i == 1 { assert(f == "AATTCGATATGGGCTCTGCACGATCAATCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTAGCCCTGGCCAGCTTTCATGGTGGTACGGATGCTCTGAGTTCTGAATTCGATATGGGCTCTGCACGATCAATCG", "EcoRI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 46 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTAGCCCTGGCCAGCTTTCATGGTGGTACGGATGCTCTGAGTTCTGAATTCGATATGGGCTCTGCACGATCAATCG", "EcoRI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATTCGATATGGGCTCTGCACGATCAATCGTTAGCCCTGGCCAGCTTTCATGGTGGTACGGATGCTCTGAGTTCTG"); }
}
assert(total == 76);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAAGAATTCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAAGAATTCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("EcoRI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "EcoRI" && m.start == 3); assert(m.cuts_in == [0, 2] && m.blocked_in == [1]); }
}
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("CCCGGG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 3 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCGGG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCC"); }
if i == 1 { assert(f == "GGG"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("CCCGGG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 3 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCGGG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCCC"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("AAACCCGGGTTTTTTTTTTTTTTTTTTTT", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 6 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACCCGGGTTTTTTTTTTTTTTTTTTTT", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAACCC"); }
if i == 1 { assert(f == "GGGTTTTTTTTTTTTTTTTTTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAACCCGGGTTTTTTTTTTTTTTTTTTTT", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 6 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACCCGGGTTTTTTTTTTTTTTTTTTTT", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGTTTTTTTTTTTTTTTTTTTTAAACCC"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAACCCGGGTTT", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 23 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAACCCGGGTTT", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAACCC"); }
if i == 1 { assert(f == "GGGTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAACCCGGGTTT", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 23 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAACCCGGGTTT", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGTTTAAAAAAAAAAAAAAAAAAAACCC"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("CCCGGGCCCGGGCCCGGG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 3 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 9 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 15 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCGGGCCCGGGCCCGGG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 4);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCC"); }
if i == 1 { assert(f == "GGGCCC"); }
if i == 2 { assert(f == "GGGCCC"); }
if i == 3 { assert(f == "GGG"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("CCCGGGCCCGGGCCCGGG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 3 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 9 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 15 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCGGGCCCGGGCCCGGG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCCC"); }
if i == 1 { assert(f == "GGGCCC"); }
if i == 2 { assert(f == "GGGCCC"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("GGGAAAAAAAAAAAAAAAAAAAACCC", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("GGGAAAAAAAAAAAAAAAAAAAACCC", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGAAAAAAAAAAAAAAAAAAAACCC"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("GGGAAAAAAAAAAAAAAAAAAAACCC", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 0 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGGAAAAAAAAAAAAAAAAAAAACCC", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGAAAAAAAAAAAAAAAAAAAACCC"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("GCCCAGCATCGAGGCCACCCGGGCATACATGAGCATGAGTGATACTTGCCAAATCTGAACTCTTGATCTCTTGACG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 20 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCCCAGCATCGAGGCCACCCGGGCATACATGAGCATGAGTGATACTTGCCAAATCTGAACTCTTGATCTCTTGACG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCCCAGCATCGAGGCCACCC"); }
if i == 1 { assert(f == "GGGCATACATGAGCATGAGTGATACTTGCCAAATCTGAACTCTTGATCTCTTGACG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCCCAGCATCGAGGCCACCCGGGCATACATGAGCATGAGTGATACTTGCCAAATCTGAACTCTTGATCTCTTGACG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 20 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCCCAGCATCGAGGCCACCCGGGCATACATGAGCATGAGTGATACTTGCCAAATCTGAACTCTTGATCTCTTGACG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCATACATGAGCATGAGTGATACTTGCCAAATCTGAACTCTTGATCTCTTGACGGCCCAGCATCGAGGCCACCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGGTAAGTGTGGAAGGTTTTACGTGGGTTGCGATTCCCGGGTGAGAATTTAACTGCTTCATAACTTCGAGGGAACC", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 38 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGGTAAGTGTGGAAGGTTTTACGTGGGTTGCGATTCCCGGGTGAGAATTTAACTGCTTCATAACTTCGAGGGAACC", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGGTAAGTGTGGAAGGTTTTACGTGGGTTGCGATTCCC"); }
if i == 1 { assert(f == "GGGTGAGAATTTAACTGCTTCATAACTTCGAGGGAACC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGGTAAGTGTGGAAGGTTTTACGTGGGTTGCGATTCCCGGGTGAGAATTTAACTGCTTCATAACTTCGAGGGAACC", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 38 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGGTAAGTGTGGAAGGTTTTACGTGGGTTGCGATTCCCGGGTGAGAATTTAACTGCTTCATAACTTCGAGGGAACC", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGTGAGAATTTAACTGCTTCATAACTTCGAGGGAACCTGGTAAGTGTGGAAGGTTTTACGTGGGTTGCGATTCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CGCCGCGTAGGTGCGTTTTGGGCTAGTGTCGGGACGAAGACAATACATCCCGGGCAACAAGTGGTACTCGGCGGTG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 51 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCCGCGTAGGTGCGTTTTGGGCTAGTGTCGGGACGAAGACAATACATCCCGGGCAACAAGTGGTACTCGGCGGTG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGCCGCGTAGGTGCGTTTTGGGCTAGTGTCGGGACGAAGACAATACATCCC"); }
if i == 1 { assert(f == "GGGCAACAAGTGGTACTCGGCGGTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CGCCGCGTAGGTGCGTTTTGGGCTAGTGTCGGGACGAAGACAATACATCCCGGGCAACAAGTGGTACTCGGCGGTG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 51 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCCGCGTAGGTGCGTTTTGGGCTAGTGTCGGGACGAAGACAATACATCCCGGGCAACAAGTGGTACTCGGCGGTG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCAACAAGTGGTACTCGGCGGTGCGCCGCGTAGGTGCGTTTTGGGCTAGTGTCGGGACGAAGACAATACATCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ACACTGTCGATGAGTGGCCCCGGGTGCTTTAGACGTAGGTTACTGTAAGATCGACAACAGCGCACCAGCCCGACAA", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 21 { found = true; } } assert(found); }
let d = bio::catalog_digest("ACACTGTCGATGAGTGGCCCCGGGTGCTTTAGACGTAGGTTACTGTAAGATCGACAACAGCGCACCAGCCCGACAA", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ACACTGTCGATGAGTGGCCCC"); }
if i == 1 { assert(f == "GGGTGCTTTAGACGTAGGTTACTGTAAGATCGACAACAGCGCACCAGCCCGACAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ACACTGTCGATGAGTGGCCCCGGGTGCTTTAGACGTAGGTTACTGTAAGATCGACAACAGCGCACCAGCCCGACAA", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 21 { found = true; } } assert(found); }
let d = bio::catalog_digest("ACACTGTCGATGAGTGGCCCCGGGTGCTTTAGACGTAGGTTACTGTAAGATCGACAACAGCGCACCAGCCCGACAA", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGTGCTTTAGACGTAGGTTACTGTAAGATCGACAACAGCGCACCAGCCCGACAAACACTGTCGATGAGTGGCCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ACTACACAGATAACTGGCTCAGTCTGGTTGACCTTTTTTGAGCCCCCGGGATATATAGTGCATAAACATATGGGTT", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 47 { found = true; } } assert(found); }
let d = bio::catalog_digest("ACTACACAGATAACTGGCTCAGTCTGGTTGACCTTTTTTGAGCCCCCGGGATATATAGTGCATAAACATATGGGTT", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ACTACACAGATAACTGGCTCAGTCTGGTTGACCTTTTTTGAGCCCCC"); }
if i == 1 { assert(f == "GGGATATATAGTGCATAAACATATGGGTT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ACTACACAGATAACTGGCTCAGTCTGGTTGACCTTTTTTGAGCCCCCGGGATATATAGTGCATAAACATATGGGTT", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 47 { found = true; } } assert(found); }
let d = bio::catalog_digest("ACTACACAGATAACTGGCTCAGTCTGGTTGACCTTTTTTGAGCCCCCGGGATATATAGTGCATAAACATATGGGTT", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGATATATAGTGCATAAACATATGGGTTACTACACAGATAACTGGCTCAGTCTGGTTGACCTTTTTTGAGCCCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCGGCGGAAAGCGGTACCCGGGGCGCGTGTACGTAGATACGAGGTCGTAGGCTTACCATCAGACATTGTTGATAGA", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 19 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGGCGGAAAGCGGTACCCGGGGCGCGTGTACGTAGATACGAGGTCGTAGGCTTACCATCAGACATTGTTGATAGA", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCGGCGGAAAGCGGTACCC"); }
if i == 1 { assert(f == "GGGGCGCGTGTACGTAGATACGAGGTCGTAGGCTTACCATCAGACATTGTTGATAGA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCGGCGGAAAGCGGTACCCGGGGCGCGTGTACGTAGATACGAGGTCGTAGGCTTACCATCAGACATTGTTGATAGA", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 19 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGGCGGAAAGCGGTACCCGGGGCGCGTGTACGTAGATACGAGGTCGTAGGCTTACCATCAGACATTGTTGATAGA", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGGCGCGTGTACGTAGATACGAGGTCGTAGGCTTACCATCAGACATTGTTGATAGACCGGCGGAAAGCGGTACCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CTAAACTCCCACGGGAAAACTCTGGCATCGGAGTTGACGCTATTAAGTGTTTCATACTGCCCGGGGGCCGAATCTG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 62 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTAAACTCCCACGGGAAAACTCTGGCATCGGAGTTGACGCTATTAAGTGTTTCATACTGCCCGGGGGCCGAATCTG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTAAACTCCCACGGGAAAACTCTGGCATCGGAGTTGACGCTATTAAGTGTTTCATACTGCCC"); }
if i == 1 { assert(f == "GGGGGCCGAATCTG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CTAAACTCCCACGGGAAAACTCTGGCATCGGAGTTGACGCTATTAAGTGTTTCATACTGCCCGGGGGCCGAATCTG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 62 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTAAACTCCCACGGGAAAACTCTGGCATCGGAGTTGACGCTATTAAGTGTTTCATACTGCCCGGGGGCCGAATCTG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGGGCCGAATCTGCTAAACTCCCACGGGAAAACTCTGGCATCGGAGTTGACGCTATTAAGTGTTTCATACTGCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GGCCTATCCAGTGATCAGGATTCTAGGCGTCAAGTACAGCTAACTTGGGAACGACCCGGGACAAGGATAGTACCTA", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 57 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGCCTATCCAGTGATCAGGATTCTAGGCGTCAAGTACAGCTAACTTGGGAACGACCCGGGACAAGGATAGTACCTA", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGCCTATCCAGTGATCAGGATTCTAGGCGTCAAGTACAGCTAACTTGGGAACGACCC"); }
if i == 1 { assert(f == "GGGACAAGGATAGTACCTA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GGCCTATCCAGTGATCAGGATTCTAGGCGTCAAGTACAGCTAACTTGGGAACGACCCGGGACAAGGATAGTACCTA", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 57 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGCCTATCCAGTGATCAGGATTCTAGGCGTCAAGTACAGCTAACTTGGGAACGACCCGGGACAAGGATAGTACCTA", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGACAAGGATAGTACCTAGGCCTATCCAGTGATCAGGATTCTAGGCGTCAAGTACAGCTAACTTGGGAACGACCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCGGAAACGTTGCGGTCGGCTTTAAAATTCGTCAGTCAGCCCGGGTTCAAATGGAGGACGGCCGGTATTCTTTAGC", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGGAAACGTTGCGGTCGGCTTTAAAATTCGTCAGTCAGCCCGGGTTCAAATGGAGGACGGCCGGTATTCTTTAGC", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCGGAAACGTTGCGGTCGGCTTTAAAATTCGTCAGTCAGCCC"); }
if i == 1 { assert(f == "GGGTTCAAATGGAGGACGGCCGGTATTCTTTAGC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCGGAAACGTTGCGGTCGGCTTTAAAATTCGTCAGTCAGCCCGGGTTCAAATGGAGGACGGCCGGTATTCTTTAGC", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGGAAACGTTGCGGTCGGCTTTAAAATTCGTCAGTCAGCCCGGGTTCAAATGGAGGACGGCCGGTATTCTTTAGC", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGTTCAAATGGAGGACGGCCGGTATTCTTTAGCCCGGAAACGTTGCGGTCGGCTTTAAAATTCGTCAGTCAGCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCGCAATGCAATTTTTGAGGCGCATGCCAGCCGCCCCCGGGCAATATAGATAGGAGGATAGTAACGATGCGAATAA", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 38 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCGCAATGCAATTTTTGAGGCGCATGCCAGCCGCCCCCGGGCAATATAGATAGGAGGATAGTAACGATGCGAATAA", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCGCAATGCAATTTTTGAGGCGCATGCCAGCCGCCCCC"); }
if i == 1 { assert(f == "GGGCAATATAGATAGGAGGATAGTAACGATGCGAATAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCGCAATGCAATTTTTGAGGCGCATGCCAGCCGCCCCCGGGCAATATAGATAGGAGGATAGTAACGATGCGAATAA", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 38 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCGCAATGCAATTTTTGAGGCGCATGCCAGCCGCCCCCGGGCAATATAGATAGGAGGATAGTAACGATGCGAATAA", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCAATATAGATAGGAGGATAGTAACGATGCGAATAAGCGCAATGCAATTTTTGAGGCGCATGCCAGCCGCCCCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TATCTCAACCCGGGCGATCGCCAGCTGTCTTTTGAGTCCGTTGTCCCGGCAGTCTACAAGTCGGGACGTGTTCCGG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
let d = bio::catalog_digest("TATCTCAACCCGGGCGATCGCCAGCTGTCTTTTGAGTCCGTTGTCCCGGCAGTCTACAAGTCGGGACGTGTTCCGG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TATCTCAACCC"); }
if i == 1 { assert(f == "GGGCGATCGCCAGCTGTCTTTTGAGTCCGTTGTCCCGGCAGTCTACAAGTCGGGACGTGTTCCGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TATCTCAACCCGGGCGATCGCCAGCTGTCTTTTGAGTCCGTTGTCCCGGCAGTCTACAAGTCGGGACGTGTTCCGG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
let d = bio::catalog_digest("TATCTCAACCCGGGCGATCGCCAGCTGTCTTTTGAGTCCGTTGTCCCGGCAGTCTACAAGTCGGGACGTGTTCCGG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCGATCGCCAGCTGTCTTTTGAGTCCGTTGTCCCGGCAGTCTACAAGTCGGGACGTGTTCCGGTATCTCAACCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGGCGGGCAAATTAGAAGTCCGCCCGGGCACCGCTATTTTACTAGAGAACCCTTCATGATGACATTTTTTTTAAG", "SmaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 26 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGGCGGGCAAATTAGAAGTCCGCCCGGGCACCGCTATTTTACTAGAGAACCCTTCATGATGACATTTTTTTTAAG", "SmaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAGGCGGGCAAATTAGAAGTCCGCCC"); }
if i == 1 { assert(f == "GGGCACCGCTATTTTACTAGAGAACCCTTCATGATGACATTTTTTTTAAG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGGCGGGCAAATTAGAAGTCCGCCCGGGCACCGCTATTTTACTAGAGAACCCTTCATGATGACATTTTTTTTAAG", "SmaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 26 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGGCGGGCAAATTAGAAGTCCGCCCGGGCACCGCTATTTTACTAGAGAACCCTTCATGATGACATTTTTTTTAAG", "SmaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGCACCGCTATTTTACTAGAGAACCCTTCATGATGACATTTTTTTTAAGCAGGCGGGCAAATTAGAAGTCCGCCC"); }
}
assert(total == 76);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAACCCGGGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAACCCGGGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("SmaI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "SmaI" && m.start == 3); assert(m.cuts_in == [0, 2] && m.blocked_in == [1]); }
}
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("CTGCAG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGCAG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTGCA"); }
if i == 1 { assert(f == "G"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("CTGCAG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGCAG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCTGCA"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("AAACTGCAGTTTTTTTTTTTTTTTTTTTT", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACTGCAGTTTTTTTTTTTTTTTTTTTT", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAACTGCA"); }
if i == 1 { assert(f == "GTTTTTTTTTTTTTTTTTTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAACTGCAGTTTTTTTTTTTTTTTTTTTT", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACTGCAGTTTTTTTTTTTTTTTTTTTT", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTTTTTTTTTTTTTTTTTTTAAACTGCA"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAACTGCAGTTT", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 25 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAACTGCAGTTT", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAACTGCA"); }
if i == 1 { assert(f == "GTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAACTGCAGTTT", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 25 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAACTGCAGTTT", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTTAAAAAAAAAAAAAAAAAAAACTGCA"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("CTGCAGCTGCAGCTGCAG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 17 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGCAGCTGCAGCTGCAG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 4);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTGCA"); }
if i == 1 { assert(f == "GCTGCA"); }
if i == 2 { assert(f == "GCTGCA"); }
if i == 3 { assert(f == "G"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("CTGCAGCTGCAGCTGCAG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 17 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGCAGCTGCAGCTGCAG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCTGCA"); }
if i == 1 { assert(f == "GCTGCA"); }
if i == 2 { assert(f == "GCTGCA"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("CAGAAAAAAAAAAAAAAAAAAAACTG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("CAGAAAAAAAAAAAAAAAAAAAACTG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAGAAAAAAAAAAAAAAAAAAAACTG"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("CAGAAAAAAAAAAAAAAAAAAAACTG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 2 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGAAAAAAAAAAAAAAAAAAAACTG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAAAAAAAAAAAAAAAAAAAACTGCA"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("CAGAGAAGACCTGCTTGTGATAACCCTGCAGCCTGGAAAGGTTCCGCTTAAGAAAACCACTGGGTCTTTTATCAGT", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 30 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGAGAAGACCTGCTTGTGATAACCCTGCAGCCTGGAAAGGTTCCGCTTAAGAAAACCACTGGGTCTTTTATCAGT", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAGAGAAGACCTGCTTGTGATAACCCTGCA"); }
if i == 1 { assert(f == "GCCTGGAAAGGTTCCGCTTAAGAAAACCACTGGGTCTTTTATCAGT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGAGAAGACCTGCTTGTGATAACCCTGCAGCCTGGAAAGGTTCCGCTTAAGAAAACCACTGGGTCTTTTATCAGT", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 30 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGAGAAGACCTGCTTGTGATAACCCTGCAGCCTGGAAAGGTTCCGCTTAAGAAAACCACTGGGTCTTTTATCAGT", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCCTGGAAAGGTTCCGCTTAAGAAAACCACTGGGTCTTTTATCAGTCAGAGAAGACCTGCTTGTGATAACCCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGCGCATTACCTTTTAGTTCGCAAATAGAGCCAATCCGGCCCTCAGTTCCATGAGCTGCAGTCGGCTTAGACAGTT", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 60 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGCGCATTACCTTTTAGTTCGCAAATAGAGCCAATCCGGCCCTCAGTTCCATGAGCTGCAGTCGGCTTAGACAGTT", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGCGCATTACCTTTTAGTTCGCAAATAGAGCCAATCCGGCCCTCAGTTCCATGAGCTGCA"); }
if i == 1 { assert(f == "GTCGGCTTAGACAGTT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TGCGCATTACCTTTTAGTTCGCAAATAGAGCCAATCCGGCCCTCAGTTCCATGAGCTGCAGTCGGCTTAGACAGTT", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 60 { found = true; } } assert(found); }
let d = bio::catalog_digest("TGCGCATTACCTTTTAGTTCGCAAATAGAGCCAATCCGGCCCTCAGTTCCATGAGCTGCAGTCGGCTTAGACAGTT", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTCGGCTTAGACAGTTTGCGCATTACCTTTTAGTTCGCAAATAGAGCCAATCCGGCCCTCAGTTCCATGAGCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCTAGCTGCAGCCGCCAATCGGTTTTCGAGAGGATAGTTAACCCCGGCGCGCCTGTATCGCTCCAGCTTCGCGTAA", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCTAGCTGCAGCCGCCAATCGGTTTTCGAGAGGATAGTTAACCCCGGCGCGCCTGTATCGCTCCAGCTTCGCGTAA", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCTAGCTGCA"); }
if i == 1 { assert(f == "GCCGCCAATCGGTTTTCGAGAGGATAGTTAACCCCGGCGCGCCTGTATCGCTCCAGCTTCGCGTAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCTAGCTGCAGCCGCCAATCGGTTTTCGAGAGGATAGTTAACCCCGGCGCGCCTGTATCGCTCCAGCTTCGCGTAA", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCTAGCTGCAGCCGCCAATCGGTTTTCGAGAGGATAGTTAACCCCGGCGCGCCTGTATCGCTCCAGCTTCGCGTAA", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCCGCCAATCGGTTTTCGAGAGGATAGTTAACCCCGGCGCGCCTGTATCGCTCCAGCTTCGCGTAACCTAGCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCTAGTTTTTGCACACGCCCATCTGTAAGTCTGCAGATTTCGAATCTAGATTGCATTGTGTTTCATAGACTAAGCG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCTAGTTTTTGCACACGCCCATCTGTAAGTCTGCAGATTTCGAATCTAGATTGCATTGTGTTTCATAGACTAAGCG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCTAGTTTTTGCACACGCCCATCTGTAAGTCTGCA"); }
if i == 1 { assert(f == "GATTTCGAATCTAGATTGCATTGTGTTTCATAGACTAAGCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCTAGTTTTTGCACACGCCCATCTGTAAGTCTGCAGATTTCGAATCTAGATTGCATTGTGTTTCATAGACTAAGCG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCTAGTTTTTGCACACGCCCATCTGTAAGTCTGCAGATTTCGAATCTAGATTGCATTGTGTTTCATAGACTAAGCG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GATTTCGAATCTAGATTGCATTGTGTTTCATAGACTAAGCGGCTAGTTTTTGCACACGCCCATCTGTAAGTCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CGCGACGCTATCCACCACACAGGTGAGTATTTAGCAACTATGACTGCAGTTCGCTGCGATGTCGCTAGACCCCCGG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 48 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCGACGCTATCCACCACACAGGTGAGTATTTAGCAACTATGACTGCAGTTCGCTGCGATGTCGCTAGACCCCCGG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGCGACGCTATCCACCACACAGGTGAGTATTTAGCAACTATGACTGCA"); }
if i == 1 { assert(f == "GTTCGCTGCGATGTCGCTAGACCCCCGG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CGCGACGCTATCCACCACACAGGTGAGTATTTAGCAACTATGACTGCAGTTCGCTGCGATGTCGCTAGACCCCCGG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 48 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCGACGCTATCCACCACACAGGTGAGTATTTAGCAACTATGACTGCAGTTCGCTGCGATGTCGCTAGACCCCCGG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTCGCTGCGATGTCGCTAGACCCCCGGCGCGACGCTATCCACCACACAGGTGAGTATTTAGCAACTATGACTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCGTTTACTTTAACCTGAGACGTTGTGCTGTTACTGCAGTTCATGAATAAAGGACTCAGTCCGCAAATGAACCAAA", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 38 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGTTTACTTTAACCTGAGACGTTGTGCTGTTACTGCAGTTCATGAATAAAGGACTCAGTCCGCAAATGAACCAAA", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCGTTTACTTTAACCTGAGACGTTGTGCTGTTACTGCA"); }
if i == 1 { assert(f == "GTTCATGAATAAAGGACTCAGTCCGCAAATGAACCAAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCGTTTACTTTAACCTGAGACGTTGTGCTGTTACTGCAGTTCATGAATAAAGGACTCAGTCCGCAAATGAACCAAA", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 38 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGTTTACTTTAACCTGAGACGTTGTGCTGTTACTGCAGTTCATGAATAAAGGACTCAGTCCGCAAATGAACCAAA", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTCATGAATAAAGGACTCAGTCCGCAAATGAACCAAACCGTTTACTTTAACCTGAGACGTTGTGCTGTTACTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GAAGATATCCTTCCGAGTGTCATGGTTACACACATTTTGCGATGCTGCAGAAGGCGCCCACATAATGGTCACTCAG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 49 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAAGATATCCTTCCGAGTGTCATGGTTACACACATTTTGCGATGCTGCAGAAGGCGCCCACATAATGGTCACTCAG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAAGATATCCTTCCGAGTGTCATGGTTACACACATTTTGCGATGCTGCA"); }
if i == 1 { assert(f == "GAAGGCGCCCACATAATGGTCACTCAG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GAAGATATCCTTCCGAGTGTCATGGTTACACACATTTTGCGATGCTGCAGAAGGCGCCCACATAATGGTCACTCAG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 49 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAAGATATCCTTCCGAGTGTCATGGTTACACACATTTTGCGATGCTGCAGAAGGCGCCCACATAATGGTCACTCAG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAAGGCGCCCACATAATGGTCACTCAGGAAGATATCCTTCCGAGTGTCATGGTTACACACATTTTGCGATGCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GACTGCAGGATACGTCAGCGCGCCATCGAATCCTAAGGCGCTCTGTATGAGGCCTAATCGCGCGCTGGCGTCACGC", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 7 { found = true; } } assert(found); }
let d = bio::catalog_digest("GACTGCAGGATACGTCAGCGCGCCATCGAATCCTAAGGCGCTCTGTATGAGGCCTAATCGCGCGCTGGCGTCACGC", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GACTGCA"); }
if i == 1 { assert(f == "GGATACGTCAGCGCGCCATCGAATCCTAAGGCGCTCTGTATGAGGCCTAATCGCGCGCTGGCGTCACGC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GACTGCAGGATACGTCAGCGCGCCATCGAATCCTAAGGCGCTCTGTATGAGGCCTAATCGCGCGCTGGCGTCACGC", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 7 { found = true; } } assert(found); }
let d = bio::catalog_digest("GACTGCAGGATACGTCAGCGCGCCATCGAATCCTAAGGCGCTCTGTATGAGGCCTAATCGCGCGCTGGCGTCACGC", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGATACGTCAGCGCGCCATCGAATCCTAAGGCGCTCTGTATGAGGCCTAATCGCGCGCTGGCGTCACGCGACTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AATCAGGACGCCATCTGGGGCCGGGCCGCAACGTAGGTTCTGCAGCACTATAGATGGACTTGAGAGATTGGCAATG", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 44 { found = true; } } assert(found); }
let d = bio::catalog_digest("AATCAGGACGCCATCTGGGGCCGGGCCGCAACGTAGGTTCTGCAGCACTATAGATGGACTTGAGAGATTGGCAATG", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATCAGGACGCCATCTGGGGCCGGGCCGCAACGTAGGTTCTGCA"); }
if i == 1 { assert(f == "GCACTATAGATGGACTTGAGAGATTGGCAATG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AATCAGGACGCCATCTGGGGCCGGGCCGCAACGTAGGTTCTGCAGCACTATAGATGGACTTGAGAGATTGGCAATG", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 44 { found = true; } } assert(found); }
let d = bio::catalog_digest("AATCAGGACGCCATCTGGGGCCGGGCCGCAACGTAGGTTCTGCAGCACTATAGATGGACTTGAGAGATTGGCAATG", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCACTATAGATGGACTTGAGAGATTGGCAATGAATCAGGACGCCATCTGGGGCCGGGCCGCAACGTAGGTTCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCTAGCCGCACTCGTATATCAACTACGCATTCTGCAGGCTAGATCGACGAGGCCTGCGAGTAGGGTTCTCGCGTTT", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 36 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCTAGCCGCACTCGTATATCAACTACGCATTCTGCAGGCTAGATCGACGAGGCCTGCGAGTAGGGTTCTCGCGTTT", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCTAGCCGCACTCGTATATCAACTACGCATTCTGCA"); }
if i == 1 { assert(f == "GGCTAGATCGACGAGGCCTGCGAGTAGGGTTCTCGCGTTT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCTAGCCGCACTCGTATATCAACTACGCATTCTGCAGGCTAGATCGACGAGGCCTGCGAGTAGGGTTCTCGCGTTT", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 36 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCTAGCCGCACTCGTATATCAACTACGCATTCTGCAGGCTAGATCGACGAGGCCTGCGAGTAGGGTTCTCGCGTTT", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGCTAGATCGACGAGGCCTGCGAGTAGGGTTCTCGCGTTTGCTAGCCGCACTCGTATATCAACTACGCATTCTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ATGCCCCCAGTGATAGCACGGGACTCACAACTGCAGAGAGATAAGCCCTACGATATCTGAAACTAGGTGACGATGA", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATGCCCCCAGTGATAGCACGGGACTCACAACTGCAGAGAGATAAGCCCTACGATATCTGAAACTAGGTGACGATGA", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGCCCCCAGTGATAGCACGGGACTCACAACTGCA"); }
if i == 1 { assert(f == "GAGAGATAAGCCCTACGATATCTGAAACTAGGTGACGATGA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ATGCCCCCAGTGATAGCACGGGACTCACAACTGCAGAGAGATAAGCCCTACGATATCTGAAACTAGGTGACGATGA", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATGCCCCCAGTGATAGCACGGGACTCACAACTGCAGAGAGATAAGCCCTACGATATCTGAAACTAGGTGACGATGA", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAGAGATAAGCCCTACGATATCTGAAACTAGGTGACGATGAATGCCCCCAGTGATAGCACGGGACTCACAACTGCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GTTATTTCTGCAGCAATTTGAACAGCGACAGCACCCTGTAGCAATTGGAGCCATGGCATGTTGTAACGTTGTGGTT", "PstI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 12 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTTATTTCTGCAGCAATTTGAACAGCGACAGCACCCTGTAGCAATTGGAGCCATGGCATGTTGTAACGTTGTGGTT", "PstI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTATTTCTGCA"); }
if i == 1 { assert(f == "GCAATTTGAACAGCGACAGCACCCTGTAGCAATTGGAGCCATGGCATGTTGTAACGTTGTGGTT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GTTATTTCTGCAGCAATTTGAACAGCGACAGCACCCTGTAGCAATTGGAGCCATGGCATGTTGTAACGTTGTGGTT", "PstI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 12 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTTATTTCTGCAGCAATTTGAACAGCGACAGCACCCTGTAGCAATTGGAGCCATGGCATGTTGTAACGTTGTGGTT", "PstI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCAATTTGAACAGCGACAGCACCCTGTAGCAATTGGAGCCATGGCATGTTGTAACGTTGTGGTTGTTATTTCTGCA"); }
}
assert(total == 76);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAACTGCAGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAACTGCAGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("PstI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "PstI" && m.start == 3); assert(m.cuts_in == [0, 2] && m.blocked_in == [1]); }
}
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("GGTCTC", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("GGTCTC", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTCTC"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("GGTCTC", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTCTC", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTCTCG"); }
}
assert(total == 6);
}
{
let r = bio::catalog_search("AAAGGTCTCTTTTTTTTTTTTTTTTTTTT", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAGGTCTCTTTTTTTTTTTTTTTTTTTT", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAGGTCTCT"); }
if i == 1 { assert(f == "TTTTTTTTTTTTTTTTTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAGGTCTCTTTTTTTTTTTTTTTTTTTT", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAGGTCTCTTTTTTTTTTTTTTTTTTTT", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTTTTTTTTTTTTTTTTTTAAAGGTCTCT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAGAGACCTTT", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 15 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAGAGACCTTT", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAA"); }
if i == 1 { assert(f == "AAAAAGAGACCTTT"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAGAGACCTTT", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 15 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAGAGACCTTT", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAGAGACCTTTAAAAAAAAAAAAAAA"); }
}
assert(total == 29);
}
{
let r = bio::catalog_search("GGTCTCGGTCTCGGTCTC", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 2);
{ var found = false; for t in tops { if t == 7 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTCTCGGTCTCGGTCTC", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTCTCG"); }
if i == 1 { assert(f == "GTCTCG"); }
if i == 2 { assert(f == "GTCTC"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("GGTCTCGGTCTCGGTCTC", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 1 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 7 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTCTCGGTCTCGGTCTC", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTCTCG"); }
if i == 1 { assert(f == "GTCTCG"); }
if i == 2 { assert(f == "GTCTCG"); }
}
assert(total == 18);
}
{
let r = bio::catalog_search("CTCAAAAAAAAAAAAAAAAAAAAGGT", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("CTCAAAAAAAAAAAAAAAAAAAAGGT", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTCAAAAAAAAAAAAAAAAAAAAGGT"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("CTCAAAAAAAAAAAAAAAAAAAAGGT", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTCAAAAAAAAAAAAAAAAAAAAGGT", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAGGTCTCA"); }
}
assert(total == 26);
}
{
let r = bio::catalog_search("GCCTTTACCTTAACCTGTTATTGTAGCGTGACGACGGTCTCAGTCGACTAAGGGGAGCTATCACAGCTCTGAAGGA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCCTTTACCTTAACCTGTTATTGTAGCGTGACGACGGTCTCAGTCGACTAAGGGGAGCTATCACAGCTCTGAAGGA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCCTTTACCTTAACCTGTTATTGTAGCGTGACGACGGTCTCA"); }
if i == 1 { assert(f == "GTCGACTAAGGGGAGCTATCACAGCTCTGAAGGA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCCTTTACCTTAACCTGTTATTGTAGCGTGACGACGGTCTCAGTCGACTAAGGGGAGCTATCACAGCTCTGAAGGA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCCTTTACCTTAACCTGTTATTGTAGCGTGACGACGGTCTCAGTCGACTAAGGGGAGCTATCACAGCTCTGAAGGA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTCGACTAAGGGGAGCTATCACAGCTCTGAAGGAGCCTTTACCTTAACCTGTTATTGTAGCGTGACGACGGTCTCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ATCAACGAATGCTCAGACTGACCTGAAATTAATTCGACCGATGCGGGTATTGGTCTCGTAGTGCGTCTTACCCTCA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 58 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATCAACGAATGCTCAGACTGACCTGAAATTAATTCGACCGATGCGGGTATTGGTCTCGTAGTGCGTCTTACCCTCA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATCAACGAATGCTCAGACTGACCTGAAATTAATTCGACCGATGCGGGTATTGGTCTCG"); }
if i == 1 { assert(f == "TAGTGCGTCTTACCCTCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("ATCAACGAATGCTCAGACTGACCTGAAATTAATTCGACCGATGCGGGTATTGGTCTCGTAGTGCGTCTTACCCTCA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 58 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATCAACGAATGCTCAGACTGACCTGAAATTAATTCGACCGATGCGGGTATTGGTCTCGTAGTGCGTCTTACCCTCA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TAGTGCGTCTTACCCTCAATCAACGAATGCTCAGACTGACCTGAAATTAATTCGACCGATGCGGGTATTGGTCTCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTTAAGAAGGATGCTGACGCCAGTGCAGTGCAGGGTCTCGTTTTTCGTGATCTATATTTACTTCACATAACAAGCT", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 40 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTTAAGAAGGATGCTGACGCCAGTGCAGTGCAGGGTCTCGTTTTTCGTGATCTATATTTACTTCACATAACAAGCT", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTTAAGAAGGATGCTGACGCCAGTGCAGTGCAGGGTCTCG"); }
if i == 1 { assert(f == "TTTTTCGTGATCTATATTTACTTCACATAACAAGCT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TTTAAGAAGGATGCTGACGCCAGTGCAGTGCAGGGTCTCGTTTTTCGTGATCTATATTTACTTCACATAACAAGCT", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 40 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTTAAGAAGGATGCTGACGCCAGTGCAGTGCAGGGTCTCGTTTTTCGTGATCTATATTTACTTCACATAACAAGCT", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTTTTCGTGATCTATATTTACTTCACATAACAAGCTTTTAAGAAGGATGCTGACGCCAGTGCAGTGCAGGGTCTCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TCACTGGCAGAGGATTGGCACGGGAACAATTAACAACTGCGTGCTGCAGTTTCTTTGGCGGTCTCGGGAGTCGTCG", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 66 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCACTGGCAGAGGATTGGCACGGGAACAATTAACAACTGCGTGCTGCAGTTTCTTTGGCGGTCTCGGGAGTCGTCG", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCACTGGCAGAGGATTGGCACGGGAACAATTAACAACTGCGTGCTGCAGTTTCTTTGGCGGTCTCG"); }
if i == 1 { assert(f == "GGAGTCGTCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TCACTGGCAGAGGATTGGCACGGGAACAATTAACAACTGCGTGCTGCAGTTTCTTTGGCGGTCTCGGGAGTCGTCG", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 66 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCACTGGCAGAGGATTGGCACGGGAACAATTAACAACTGCGTGCTGCAGTTTCTTTGGCGGTCTCGGGAGTCGTCG", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGAGTCGTCGTCACTGGCAGAGGATTGGCACGGGAACAATTAACAACTGCGTGCTGCAGTTTCTTTGGCGGTCTCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GTTGCAGGCGCTCATTAGTGCGTTTGGAATCTTTTCGGTCTCATGGACCCTTGACTCGTGGCATCGAGTCTGTTTC", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 43 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTTGCAGGCGCTCATTAGTGCGTTTGGAATCTTTTCGGTCTCATGGACCCTTGACTCGTGGCATCGAGTCTGTTTC", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTGCAGGCGCTCATTAGTGCGTTTGGAATCTTTTCGGTCTCA"); }
if i == 1 { assert(f == "TGGACCCTTGACTCGTGGCATCGAGTCTGTTTC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GTTGCAGGCGCTCATTAGTGCGTTTGGAATCTTTTCGGTCTCATGGACCCTTGACTCGTGGCATCGAGTCTGTTTC", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 43 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTTGCAGGCGCTCATTAGTGCGTTTGGAATCTTTTCGGTCTCATGGACCCTTGACTCGTGGCATCGAGTCTGTTTC", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGGACCCTTGACTCGTGGCATCGAGTCTGTTTCGTTGCAGGCGCTCATTAGTGCGTTTGGAATCTTTTCGGTCTCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TAGCCCGCCTAGCACGTACCCCTTTTCTCGGGAGGGTCTCACCTCATCGCACGCTTTCTACAGGTGGGTGCCCGGA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 41 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAGCCCGCCTAGCACGTACCCCTTTTCTCGGGAGGGTCTCACCTCATCGCACGCTTTCTACAGGTGGGTGCCCGGA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TAGCCCGCCTAGCACGTACCCCTTTTCTCGGGAGGGTCTCA"); }
if i == 1 { assert(f == "CCTCATCGCACGCTTTCTACAGGTGGGTGCCCGGA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("TAGCCCGCCTAGCACGTACCCCTTTTCTCGGGAGGGTCTCACCTCATCGCACGCTTTCTACAGGTGGGTGCCCGGA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 41 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAGCCCGCCTAGCACGTACCCCTTTTCTCGGGAGGGTCTCACCTCATCGCACGCTTTCTACAGGTGGGTGCCCGGA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCTCATCGCACGCTTTCTACAGGTGGGTGCCCGGATAGCCCGCCTAGCACGTACCCCTTTTCTCGGGAGGGTCTCA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AATATCCTCCGGTTTTTACAGACCTCGCGTTGGCTCCGGGGTATCTGCAGGTCTCGCGCAAATCACTCGTGCAGAC", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 56 { found = true; } } assert(found); }
let d = bio::catalog_digest("AATATCCTCCGGTTTTTACAGACCTCGCGTTGGCTCCGGGGTATCTGCAGGTCTCGCGCAAATCACTCGTGCAGAC", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AATATCCTCCGGTTTTTACAGACCTCGCGTTGGCTCCGGGGTATCTGCAGGTCTCG"); }
if i == 1 { assert(f == "CGCAAATCACTCGTGCAGAC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("AATATCCTCCGGTTTTTACAGACCTCGCGTTGGCTCCGGGGTATCTGCAGGTCTCGCGCAAATCACTCGTGCAGAC", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 56 { found = true; } } assert(found); }
let d = bio::catalog_digest("AATATCCTCCGGTTTTTACAGACCTCGCGTTGGCTCCGGGGTATCTGCAGGTCTCGCGCAAATCACTCGTGCAGAC", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGCAAATCACTCGTGCAGACAATATCCTCCGGTTTTTACAGACCTCGCGTTGGCTCCGGGGTATCTGCAGGTCTCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCAGTAACTTAATATCGGTAGAGGATGACTAGGTAAGAGGCCTCAGGGTCTCTTCGGGTCTATTAAAATTCCCGTA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 53 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCAGTAACTTAATATCGGTAGAGGATGACTAGGTAAGAGGCCTCAGGGTCTCTTCGGGTCTATTAAAATTCCCGTA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCAGTAACTTAATATCGGTAGAGGATGACTAGGTAAGAGGCCTCAGGGTCTCT"); }
if i == 1 { assert(f == "TCGGGTCTATTAAAATTCCCGTA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GCAGTAACTTAATATCGGTAGAGGATGACTAGGTAAGAGGCCTCAGGGTCTCTTCGGGTCTATTAAAATTCCCGTA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 53 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCAGTAACTTAATATCGGTAGAGGATGACTAGGTAAGAGGCCTCAGGGTCTCTTCGGGTCTATTAAAATTCCCGTA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCGGGTCTATTAAAATTCCCGTAGCAGTAACTTAATATCGGTAGAGGATGACTAGGTAAGAGGCCTCAGGGTCTCT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGAATTCATTCTATAGATCGGAGTCAAGCCCTTCGGCTATGCGTGTACTGATTCGGGTCTCCGTTATTCTCCGAA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 63 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGAATTCATTCTATAGATCGGAGTCAAGCCCTTCGGCTATGCGTGTACTGATTCGGGTCTCCGTTATTCTCCGAA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAGAATTCATTCTATAGATCGGAGTCAAGCCCTTCGGCTATGCGTGTACTGATTCGGGTCTCC"); }
if i == 1 { assert(f == "GTTATTCTCCGAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGAATTCATTCTATAGATCGGAGTCAAGCCCTTCGGCTATGCGTGTACTGATTCGGGTCTCCGTTATTCTCCGAA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 63 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGAATTCATTCTATAGATCGGAGTCAAGCCCTTCGGCTATGCGTGTACTGATTCGGGTCTCCGTTATTCTCCGAA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTTATTCTCCGAACAGAATTCATTCTATAGATCGGAGTCAAGCCCTTCGGCTATGCGTGTACTGATTCGGGTCTCC"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGATTGCTTAGTAAACTTTAATCAACTGGTCTCTAGGCCCGGGCACTCCACCATGTGGGGGTCGTAGCGGATTAA", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGATTGCTTAGTAAACTTTAATCAACTGGTCTCTAGGCCCGGGCACTCCACCATGTGGGGGTCGTAGCGGATTAA", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAGATTGCTTAGTAAACTTTAATCAACTGGTCTCT"); }
if i == 1 { assert(f == "AGGCCCGGGCACTCCACCATGTGGGGGTCGTAGCGGATTAA"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CAGATTGCTTAGTAAACTTTAATCAACTGGTCTCTAGGCCCGGGCACTCCACCATGTGGGGGTCGTAGCGGATTAA", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAGATTGCTTAGTAAACTTTAATCAACTGGTCTCTAGGCCCGGGCACTCCACCATGTGGGGGTCGTAGCGGATTAA", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AGGCCCGGGCACTCCACCATGTGGGGGTCGTAGCGGATTAACAGATTGCTTAGTAAACTTTAATCAACTGGTCTCT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCTGGGGGCCCGATGAAGCTAACCTATTCCCAACGCCACGGGTCTCGCCTTTTCAACAGCGTGTCGCCTCATGAAT", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 47 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCTGGGGGCCCGATGAAGCTAACCTATTCCCAACGCCACGGGTCTCGCCTTTTCAACAGCGTGTCGCCTCATGAAT", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCTGGGGGCCCGATGAAGCTAACCTATTCCCAACGCCACGGGTCTCG"); }
if i == 1 { assert(f == "CCTTTTCAACAGCGTGTCGCCTCATGAAT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("CCTGGGGGCCCGATGAAGCTAACCTATTCCCAACGCCACGGGTCTCGCCTTTTCAACAGCGTGTCGCCTCATGAAT", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 47 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCTGGGGGCCCGATGAAGCTAACCTATTCCCAACGCCACGGGTCTCGCCTTTTCAACAGCGTGTCGCCTCATGAAT", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCTTTTCAACAGCGTGTCGCCTCATGAATCCTGGGGGCCCGATGAAGCTAACCTATTCCCAACGCCACGGGTCTCG"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GATGCAATTGCACAGAAAGGTCTCTTCCGCACGCGACTGGGCGAGCCCTTACGTAGAATTCGCGGGGCTATATGCT", "BsaI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 25 { found = true; } } assert(found); }
let d = bio::catalog_digest("GATGCAATTGCACAGAAAGGTCTCTTCCGCACGCGACTGGGCGAGCCCTTACGTAGAATTCGCGGGGCTATATGCT", "BsaI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GATGCAATTGCACAGAAAGGTCTCT"); }
if i == 1 { assert(f == "TCCGCACGCGACTGGGCGAGCCCTTACGTAGAATTCGCGGGGCTATATGCT"); }
}
assert(total == 76);
}
{
let r = bio::catalog_search("GATGCAATTGCACAGAAAGGTCTCTTCCGCACGCGACTGGGCGAGCCCTTACGTAGAATTCGCGGGGCTATATGCT", "BsaI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 25 { found = true; } } assert(found); }
let d = bio::catalog_digest("GATGCAATTGCACAGAAAGGTCTCTTCCGCACGCGACTGGGCGAGCCCTTACGTAGAATTCGCGGGGCTATATGCT", "BsaI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCCGCACGCGACTGGGCGAGCCCTTACGTAGAATTCGCGGGGCTATATGCTGATGCAATTGCACAGAAAGGTCTCT"); }
}
assert(total == 76);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAAGGTCTCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAAGAGACCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("BsaI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "BsaI" && m.start == 3); assert(m.cuts_in == [0] && m.blocked_in == [1, 2]); }
}
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("CACCTGC", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("CACCTGC", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CACCTGC"); }
}
assert(total == 7);
}
{
let r = bio::catalog_search("CACCTGC", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
let d = bio::catalog_digest("CACCTGC", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGCCACC"); }
}
assert(total == 7);
}
{
let r = bio::catalog_search("AAACACCTGCTTTTTTTTTTTTTTTTTTTT", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 14 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACACCTGCTTTTTTTTTTTTTTTTTTTT", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAACACCTGCTTTT"); }
if i == 1 { assert(f == "TTTTTTTTTTTTTTTT"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAACACCTGCTTTTTTTTTTTTTTTTTTTT", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 14 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACACCTGCTTTTTTTTTTTTTTTTTTTT", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTTTTTTTTTTTTTTTAAACACCTGCTTTT"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAGCAGGTGTTT", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 12 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAGCAGGTGTTT", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAA"); }
if i == 1 { assert(f == "AAAAAAAAGCAGGTGTTT"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAGCAGGTGTTT", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 12 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAGCAGGTGTTT", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAGCAGGTGTTTAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("CACCTGCCACCTGCCACCTGC", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
let d = bio::catalog_digest("CACCTGCCACCTGCCACCTGC", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CACCTGCCACC"); }
if i == 1 { assert(f == "TGCCACCTGC"); }
}
assert(total == 21);
}
{
let r = bio::catalog_search("CACCTGCCACCTGCCACCTGC", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 4 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 18 { found = true; } } assert(found); }
let d = bio::catalog_digest("CACCTGCCACCTGCCACCTGC", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGCCACC"); }
if i == 1 { assert(f == "TGCCACC"); }
if i == 2 { assert(f == "TGCCACC"); }
}
assert(total == 21);
}
{
let r = bio::catalog_search("CTGCAAAAAAAAAAAAAAAAAAAACAC", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("CTGCAAAAAAAAAAAAAAAAAAAACAC", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTGCAAAAAAAAAAAAAAAAAAAACAC"); }
}
assert(total == 27);
}
{
let r = bio::catalog_search("CTGCAAAAAAAAAAAAAAAAAAAACAC", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGCAAAAAAAAAAAAAAAAAAAACAC", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAACACCTGCAAAA"); }
}
assert(total == 27);
}
{
let r = bio::catalog_search("TAAATAGGTTCACTTTATAAAAAACACCTGCTGAATGCGTATGTGTAATGACGTATAGAGGGGCACATGCTGGATCT", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAAATAGGTTCACTTTATAAAAAACACCTGCTGAATGCGTATGTGTAATGACGTATAGAGGGGCACATGCTGGATCT", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TAAATAGGTTCACTTTATAAAAAACACCTGCTGAA"); }
if i == 1 { assert(f == "TGCGTATGTGTAATGACGTATAGAGGGGCACATGCTGGATCT"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TAAATAGGTTCACTTTATAAAAAACACCTGCTGAATGCGTATGTGTAATGACGTATAGAGGGGCACATGCTGGATCT", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAAATAGGTTCACTTTATAAAAAACACCTGCTGAATGCGTATGTGTAATGACGTATAGAGGGGCACATGCTGGATCT", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGCGTATGTGTAATGACGTATAGAGGGGCACATGCTGGATCTTAAATAGGTTCACTTTATAAAAAACACCTGCTGAA"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("GCATGCTCCAGCCTCGGCGACGGTAACCTGGTCCCACCTGCAATGCCCCAAAAGAACTAAAACACCGCGCTTCAACG", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 45 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCATGCTCCAGCCTCGGCGACGGTAACCTGGTCCCACCTGCAATGCCCCAAAAGAACTAAAACACCGCGCTTCAACG", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCATGCTCCAGCCTCGGCGACGGTAACCTGGTCCCACCTGCAATG"); }
if i == 1 { assert(f == "CCCCAAAAGAACTAAAACACCGCGCTTCAACG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("GCATGCTCCAGCCTCGGCGACGGTAACCTGGTCCCACCTGCAATGCCCCAAAAGAACTAAAACACCGCGCTTCAACG", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 45 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCATGCTCCAGCCTCGGCGACGGTAACCTGGTCCCACCTGCAATGCCCCAAAAGAACTAAAACACCGCGCTTCAACG", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCCCAAAAGAACTAAAACACCGCGCTTCAACGGCATGCTCCAGCCTCGGCGACGGTAACCTGGTCCCACCTGCAATG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("GGTAATTGGTTTATGGGAGGGTCTTTATTGAGCTGTGTTCTGCCTAGGGTACACGCGGCACCTGCGACGCACATTTA", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 69 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTAATTGGTTTATGGGAGGGTCTTTATTGAGCTGTGTTCTGCCTAGGGTACACGCGGCACCTGCGACGCACATTTA", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTAATTGGTTTATGGGAGGGTCTTTATTGAGCTGTGTTCTGCCTAGGGTACACGCGGCACCTGCGACG"); }
if i == 1 { assert(f == "CACATTTA"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("GGTAATTGGTTTATGGGAGGGTCTTTATTGAGCTGTGTTCTGCCTAGGGTACACGCGGCACCTGCGACGCACATTTA", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 69 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTAATTGGTTTATGGGAGGGTCTTTATTGAGCTGTGTTCTGCCTAGGGTACACGCGGCACCTGCGACGCACATTTA", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CACATTTAGGTAATTGGTTTATGGGAGGGTCTTTATTGAGCTGTGTTCTGCCTAGGGTACACGCGGCACCTGCGACG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("CGCGGGGTGTCCCTTGAGAGATACGATATGAATGAACACCTGCCAGCCTTACCTATCCGACCAGATTGTGGCACATC", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 47 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCGGGGTGTCCCTTGAGAGATACGATATGAATGAACACCTGCCAGCCTTACCTATCCGACCAGATTGTGGCACATC", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGCGGGGTGTCCCTTGAGAGATACGATATGAATGAACACCTGCCAGC"); }
if i == 1 { assert(f == "CTTACCTATCCGACCAGATTGTGGCACATC"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("CGCGGGGTGTCCCTTGAGAGATACGATATGAATGAACACCTGCCAGCCTTACCTATCCGACCAGATTGTGGCACATC", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 47 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCGGGGTGTCCCTTGAGAGATACGATATGAATGAACACCTGCCAGCCTTACCTATCCGACCAGATTGTGGCACATC", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTTACCTATCCGACCAGATTGTGGCACATCCGCGGGGTGTCCCTTGAGAGATACGATATGAATGAACACCTGCCAGC"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("ATACTGGTCTTGATCGCTGTATATATTCCGTGGAGCCTAACTGACAGCGCACTACACCTGCACCTAGGTAATTTCCG", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 65 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATACTGGTCTTGATCGCTGTATATATTCCGTGGAGCCTAACTGACAGCGCACTACACCTGCACCTAGGTAATTTCCG", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATACTGGTCTTGATCGCTGTATATATTCCGTGGAGCCTAACTGACAGCGCACTACACCTGCACCT"); }
if i == 1 { assert(f == "AGGTAATTTCCG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("ATACTGGTCTTGATCGCTGTATATATTCCGTGGAGCCTAACTGACAGCGCACTACACCTGCACCTAGGTAATTTCCG", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 65 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATACTGGTCTTGATCGCTGTATATATTCCGTGGAGCCTAACTGACAGCGCACTACACCTGCACCTAGGTAATTTCCG", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AGGTAATTTCCGATACTGGTCTTGATCGCTGTATATATTCCGTGGAGCCTAACTGACAGCGCACTACACCTGCACCT"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("CTGTCTTTGTGGGAGCATCGCGATCATGCACCTGCCCATTCTTGCATGATAATACTGCACCCCGAATTGTAGACCGA", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 39 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGTCTTTGTGGGAGCATCGCGATCATGCACCTGCCCATTCTTGCATGATAATACTGCACCCCGAATTGTAGACCGA", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTGTCTTTGTGGGAGCATCGCGATCATGCACCTGCCCAT"); }
if i == 1 { assert(f == "TCTTGCATGATAATACTGCACCCCGAATTGTAGACCGA"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("CTGTCTTTGTGGGAGCATCGCGATCATGCACCTGCCCATTCTTGCATGATAATACTGCACCCCGAATTGTAGACCGA", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 39 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGTCTTTGTGGGAGCATCGCGATCATGCACCTGCCCATTCTTGCATGATAATACTGCACCCCGAATTGTAGACCGA", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCTTGCATGATAATACTGCACCCCGAATTGTAGACCGACTGTCTTTGTGGGAGCATCGCGATCATGCACCTGCCCAT"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TCACCTGCATCCTGGGTAGAGGGCCTTGTGGTCCAAGCGGACAGCCCTTCCACATCATTCTGTTAAGTAAATCACGA", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 12 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCACCTGCATCCTGGGTAGAGGGCCTTGTGGTCCAAGCGGACAGCCCTTCCACATCATTCTGTTAAGTAAATCACGA", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCACCTGCATCC"); }
if i == 1 { assert(f == "TGGGTAGAGGGCCTTGTGGTCCAAGCGGACAGCCCTTCCACATCATTCTGTTAAGTAAATCACGA"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TCACCTGCATCCTGGGTAGAGGGCCTTGTGGTCCAAGCGGACAGCCCTTCCACATCATTCTGTTAAGTAAATCACGA", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 12 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCACCTGCATCCTGGGTAGAGGGCCTTGTGGTCCAAGCGGACAGCCCTTCCACATCATTCTGTTAAGTAAATCACGA", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGGGTAGAGGGCCTTGTGGTCCAAGCGGACAGCCCTTCCACATCATTCTGTTAAGTAAATCACGATCACCTGCATCC"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("GCTAACCCGTCTATTGGACGCAGTAACCAGAGTACCGGTACCACCTGCCGGGTTCTGCCTCAGGGGTTCTGCGCCGC", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 52 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCTAACCCGTCTATTGGACGCAGTAACCAGAGTACCGGTACCACCTGCCGGGTTCTGCCTCAGGGGTTCTGCGCCGC", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCTAACCCGTCTATTGGACGCAGTAACCAGAGTACCGGTACCACCTGCCGGG"); }
if i == 1 { assert(f == "TTCTGCCTCAGGGGTTCTGCGCCGC"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("GCTAACCCGTCTATTGGACGCAGTAACCAGAGTACCGGTACCACCTGCCGGGTTCTGCCTCAGGGGTTCTGCGCCGC", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 52 { found = true; } } assert(found); }
let d = bio::catalog_digest("GCTAACCCGTCTATTGGACGCAGTAACCAGAGTACCGGTACCACCTGCCGGGTTCTGCCTCAGGGGTTCTGCGCCGC", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTCTGCCTCAGGGGTTCTGCGCCGCGCTAACCCGTCTATTGGACGCAGTAACCAGAGTACCGGTACCACCTGCCGGG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("CTGACCTACACTGCTGTCTCCGAGCCGTTGGGGGCTCTCATTCCCAAGCCCCACCTGCATAGTGACCGCCTTAGATT", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 62 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGACCTACACTGCTGTCTCCGAGCCGTTGGGGGCTCTCATTCCCAAGCCCCACCTGCATAGTGACCGCCTTAGATT", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTGACCTACACTGCTGTCTCCGAGCCGTTGGGGGCTCTCATTCCCAAGCCCCACCTGCATAG"); }
if i == 1 { assert(f == "TGACCGCCTTAGATT"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("CTGACCTACACTGCTGTCTCCGAGCCGTTGGGGGCTCTCATTCCCAAGCCCCACCTGCATAGTGACCGCCTTAGATT", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 62 { found = true; } } assert(found); }
let d = bio::catalog_digest("CTGACCTACACTGCTGTCTCCGAGCCGTTGGGGGCTCTCATTCCCAAGCCCCACCTGCATAGTGACCGCCTTAGATT", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TGACCGCCTTAGATTCTGACCTACACTGCTGTCTCCGAGCCGTTGGGGGCTCTCATTCCCAAGCCCCACCTGCATAG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("ATACACCTGCTTGATAGGCCAGTCTGTCTTCTTAACCACTTTCCCATCCAAGGGGTGAAGCTACAGCGGGCGAAGGG", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 14 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATACACCTGCTTGATAGGCCAGTCTGTCTTCTTAACCACTTTCCCATCCAAGGGGTGAAGCTACAGCGGGCGAAGGG", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATACACCTGCTTGA"); }
if i == 1 { assert(f == "TAGGCCAGTCTGTCTTCTTAACCACTTTCCCATCCAAGGGGTGAAGCTACAGCGGGCGAAGGG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("ATACACCTGCTTGATAGGCCAGTCTGTCTTCTTAACCACTTTCCCATCCAAGGGGTGAAGCTACAGCGGGCGAAGGG", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 14 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATACACCTGCTTGATAGGCCAGTCTGTCTTCTTAACCACTTTCCCATCCAAGGGGTGAAGCTACAGCGGGCGAAGGG", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TAGGCCAGTCTGTCTTCTTAACCACTTTCCCATCCAAGGGGTGAAGCTACAGCGGGCGAAGGGATACACCTGCTTGA"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TAATGGGTGAAGTGGTAGATCGTGACGTTTTTAGATAGACACGCCACCTGCTTCACTGCGACTAAGGTATGACCATG", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 55 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAATGGGTGAAGTGGTAGATCGTGACGTTTTTAGATAGACACGCCACCTGCTTCACTGCGACTAAGGTATGACCATG", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TAATGGGTGAAGTGGTAGATCGTGACGTTTTTAGATAGACACGCCACCTGCTTCA"); }
if i == 1 { assert(f == "CTGCGACTAAGGTATGACCATG"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TAATGGGTGAAGTGGTAGATCGTGACGTTTTTAGATAGACACGCCACCTGCTTCACTGCGACTAAGGTATGACCATG", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 55 { found = true; } } assert(found); }
let d = bio::catalog_digest("TAATGGGTGAAGTGGTAGATCGTGACGTTTTTAGATAGACACGCCACCTGCTTCACTGCGACTAAGGTATGACCATG", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTGCGACTAAGGTATGACCATGTAATGGGTGAAGTGGTAGATCGTGACGTTTTTAGATAGACACGCCACCTGCTTCA"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TCATTACGCATTCGGCCCCAAACACCTGCTCCTGCATTCATCGTGGCAACTTTGCCTAAAGAATGAAACCCATCCCT", "AarI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 33 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCATTACGCATTCGGCCCCAAACACCTGCTCCTGCATTCATCGTGGCAACTTTGCCTAAAGAATGAAACCCATCCCT", "AarI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCATTACGCATTCGGCCCCAAACACCTGCTCCT"); }
if i == 1 { assert(f == "GCATTCATCGTGGCAACTTTGCCTAAAGAATGAAACCCATCCCT"); }
}
assert(total == 77);
}
{
let r = bio::catalog_search("TCATTACGCATTCGGCCCCAAACACCTGCTCCTGCATTCATCGTGGCAACTTTGCCTAAAGAATGAAACCCATCCCT", "AarI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 33 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCATTACGCATTCGGCCCCAAACACCTGCTCCTGCATTCATCGTGGCAACTTTGCCTAAAGAATGAAACCCATCCCT", "AarI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GCATTCATCGTGGCAACTTTGCCTAAAGAATGAAACCCATCCCTTCATTACGCATTCGGCCCCAAACACCTGCTCCT"); }
}
assert(total == 77);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAACACCTGCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAAGCAGGTGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("AarI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "AarI" && m.start == 3); assert(m.cuts_in == [0] && m.blocked_in == [1, 2]); }
}
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("GGTGA", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("GGTGA", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTGA"); }
}
assert(total == 5);
}
{
let r = bio::catalog_search("GGTGA", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 3 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTGA", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAGGT"); }
}
assert(total == 5);
}
{
let r = bio::catalog_search("AAAGGTGATTTTTTTTTTTTTTTTTTTT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 16 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAGGTGATTTTTTTTTTTTTTTTTTTT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAGGTGATTTTTTTT"); }
if i == 1 { assert(f == "TTTTTTTTTTTT"); }
}
assert(total == 28);
}
{
let r = bio::catalog_search("AAAGGTGATTTTTTTTTTTTTTTTTTTT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 16 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAGGTGATTTTTTTTTTTTTTTTTTTT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTTTTTTTTTTTAAAGGTGATTTTTTTT"); }
}
assert(total == 28);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAATCACCTTT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAATCACCTTT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAA"); }
if i == 1 { assert(f == "AAAAAAATCACCTTT"); }
}
assert(total == 28);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAATCACCTTT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAATCACCTTT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAATCACCTTTAAAAAAAAAAAAA"); }
}
assert(total == 28);
}
{
let r = bio::catalog_search("GGTGAGGTGAGGTGA", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTGAGGTGAGGTGA", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTGAGGTGAGGT"); }
if i == 1 { assert(f == "GA"); }
}
assert(total == 15);
}
{
let r = bio::catalog_search("GGTGAGGTGAGGTGA", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 3 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTGAGGTGAGGTGA", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAGGT"); }
if i == 1 { assert(f == "GAGGT"); }
if i == 2 { assert(f == "GAGGT"); }
}
assert(total == 15);
}
{
let r = bio::catalog_search("GAAAAAAAAAAAAAAAAAAAAAGGT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("GAAAAAAAAAAAAAAAAAAAAAGGT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAAAAAAAAAAAAAAAAAAAAAGGT"); }
}
assert(total == 25);
}
{
let r = bio::catalog_search("GAAAAAAAAAAAAAAAAAAAAAGGT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("GAAAAAAAAAAAAAAAAAAAAAGGT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAGGTGAAAAAAAAA"); }
}
assert(total == 25);
}
{
let r = bio::catalog_search("CGTAAGAGGCTCCGAGCGCGGTTTACGCAGGACTCCGCAGTAGCGCACGGGTAATGGTGACTGAGAAAGAACACA", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 68 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGTAAGAGGCTCCGAGCGCGGTTTACGCAGGACTCCGCAGTAGCGCACGGGTAATGGTGACTGAGAAAGAACACA", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGTAAGAGGCTCCGAGCGCGGTTTACGCAGGACTCCGCAGTAGCGCACGGGTAATGGTGACTGAGAAA"); }
if i == 1 { assert(f == "GAACACA"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CGTAAGAGGCTCCGAGCGCGGTTTACGCAGGACTCCGCAGTAGCGCACGGGTAATGGTGACTGAGAAAGAACACA", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 68 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGTAAGAGGCTCCGAGCGCGGTTTACGCAGGACTCCGCAGTAGCGCACGGGTAATGGTGACTGAGAAAGAACACA", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GAACACACGTAAGAGGCTCCGAGCGCGGTTTACGCAGGACTCCGCAGTAGCGCACGGGTAATGGTGACTGAGAAA"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("TACGTCTTCAGTCGTAGGTGATTCCAGAGGATCCCATATTTTGAATCCGGCACGCAGAAAGTCGCGACTGGCCAT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 29 { found = true; } } assert(found); }
let d = bio::catalog_digest("TACGTCTTCAGTCGTAGGTGATTCCAGAGGATCCCATATTTTGAATCCGGCACGCAGAAAGTCGCGACTGGCCAT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TACGTCTTCAGTCGTAGGTGATTCCAGAG"); }
if i == 1 { assert(f == "GATCCCATATTTTGAATCCGGCACGCAGAAAGTCGCGACTGGCCAT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("TACGTCTTCAGTCGTAGGTGATTCCAGAGGATCCCATATTTTGAATCCGGCACGCAGAAAGTCGCGACTGGCCAT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 29 { found = true; } } assert(found); }
let d = bio::catalog_digest("TACGTCTTCAGTCGTAGGTGATTCCAGAGGATCCCATATTTTGAATCCGGCACGCAGAAAGTCGCGACTGGCCAT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GATCCCATATTTTGAATCCGGCACGCAGAAAGTCGCGACTGGCCATTACGTCTTCAGTCGTAGGTGATTCCAGAG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("TATGGTCTAGTTAATAAATTAGGATGCCGTCAAGCATTGGAAGATTGCCCTGAGCCGGAGGTGATAAAAACGCGG", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 72 { found = true; } } assert(found); }
let d = bio::catalog_digest("TATGGTCTAGTTAATAAATTAGGATGCCGTCAAGCATTGGAAGATTGCCCTGAGCCGGAGGTGATAAAAACGCGG", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TATGGTCTAGTTAATAAATTAGGATGCCGTCAAGCATTGGAAGATTGCCCTGAGCCGGAGGTGATAAAAACG"); }
if i == 1 { assert(f == "CGG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("TATGGTCTAGTTAATAAATTAGGATGCCGTCAAGCATTGGAAGATTGCCCTGAGCCGGAGGTGATAAAAACGCGG", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 72 { found = true; } } assert(found); }
let d = bio::catalog_digest("TATGGTCTAGTTAATAAATTAGGATGCCGTCAAGCATTGGAAGATTGCCCTGAGCCGGAGGTGATAAAAACGCGG", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGGTATGGTCTAGTTAATAAATTAGGATGCCGTCAAGCATTGGAAGATTGCCCTGAGCCGGAGGTGATAAAAACG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CAAACTGTCCTCATGCTGCGCCATCCCGTGAGTCCCAGATGTGGCAGGTGAGGAGCCGCTCCGAGTTCATTTACC", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 59 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAAACTGTCCTCATGCTGCGCCATCCCGTGAGTCCCAGATGTGGCAGGTGAGGAGCCGCTCCGAGTTCATTTACC", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAAACTGTCCTCATGCTGCGCCATCCCGTGAGTCCCAGATGTGGCAGGTGAGGAGCCGC"); }
if i == 1 { assert(f == "TCCGAGTTCATTTACC"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CAAACTGTCCTCATGCTGCGCCATCCCGTGAGTCCCAGATGTGGCAGGTGAGGAGCCGCTCCGAGTTCATTTACC", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 59 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAAACTGTCCTCATGCTGCGCCATCCCGTGAGTCCCAGATGTGGCAGGTGAGGAGCCGCTCCGAGTTCATTTACC", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCCGAGTTCATTTACCCAAACTGTCCTCATGCTGCGCCATCCCGTGAGTCCCAGATGTGGCAGGTGAGGAGCCGC"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CGTCCGCAACGGGTGAATCGATAATTGCTGCGGAACAGAGCCTACTACAAGCTTCACGCCCAGCGTTTCACTTTG", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 24 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGTCCGCAACGGGTGAATCGATAATTGCTGCGGAACAGAGCCTACTACAAGCTTCACGCCCAGCGTTTCACTTTG", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGTCCGCAACGGGTGAATCGATAA"); }
if i == 1 { assert(f == "TTGCTGCGGAACAGAGCCTACTACAAGCTTCACGCCCAGCGTTTCACTTTG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CGTCCGCAACGGGTGAATCGATAATTGCTGCGGAACAGAGCCTACTACAAGCTTCACGCCCAGCGTTTCACTTTG", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 24 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGTCCGCAACGGGTGAATCGATAATTGCTGCGGAACAGAGCCTACTACAAGCTTCACGCCCAGCGTTTCACTTTG", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTGCTGCGGAACAGAGCCTACTACAAGCTTCACGCCCAGCGTTTCACTTTGCGTCCGCAACGGGTGAATCGATAA"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CCTCATACCCGTCAGCCTGTACGACGCCGCGGTCACCTGGTGATACTAACGGGGAAAAGCGCTCCAACTAGATCT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 2);
{ var found = false; for t in tops { if t == 25 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 51 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCTCATACCCGTCAGCCTGTACGACGCCGCGGTCACCTGGTGATACTAACGGGGAAAAGCGCTCCAACTAGATCT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCTCATACCCGTCAGCCTGTACGAC"); }
if i == 1 { assert(f == "GCCGCGGTCACCTGGTGATACTAACG"); }
if i == 2 { assert(f == "GGGAAAAGCGCTCCAACTAGATCT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CCTCATACCCGTCAGCCTGTACGACGCCGCGGTCACCTGGTGATACTAACGGGGAAAAGCGCTCCAACTAGATCT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 2);
{ var found = false; for t in tops { if t == 25 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 51 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCTCATACCCGTCAGCCTGTACGACGCCGCGGTCACCTGGTGATACTAACGGGGAAAAGCGCTCCAACTAGATCT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGGAAAAGCGCTCCAACTAGATCTCCTCATACCCGTCAGCCTGTACGAC"); }
if i == 1 { assert(f == "GCCGCGGTCACCTGGTGATACTAACG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CCCCGTCGCGATAAGTGTAGGGTGATCCTCTGGAAAGGTTTTGGACATACCAAACTTGCTACTGTTTAATTGAGC", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 33 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCCGTCGCGATAAGTGTAGGGTGATCCTCTGGAAAGGTTTTGGACATACCAAACTTGCTACTGTTTAATTGAGC", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCCCGTCGCGATAAGTGTAGGGTGATCCTCTGG"); }
if i == 1 { assert(f == "AAAGGTTTTGGACATACCAAACTTGCTACTGTTTAATTGAGC"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CCCCGTCGCGATAAGTGTAGGGTGATCCTCTGGAAAGGTTTTGGACATACCAAACTTGCTACTGTTTAATTGAGC", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 33 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCCGTCGCGATAAGTGTAGGGTGATCCTCTGGAAAGGTTTTGGACATACCAAACTTGCTACTGTTTAATTGAGC", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAGGTTTTGGACATACCAAACTTGCTACTGTTTAATTGAGCCCCCGTCGCGATAAGTGTAGGGTGATCCTCTGG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("GGTGACTATGCCTTCTTCTGTGCAATCAGGCAATTGTGACACGCGCGCTACCCATGAACAGCATTCTCGTTGCAT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTGACTATGCCTTCTTCTGTGCAATCAGGCAATTGTGACACGCGCGCTACCCATGAACAGCATTCTCGTTGCAT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTGACTATGCCT"); }
if i == 1 { assert(f == "TCTTCTGTGCAATCAGGCAATTGTGACACGCGCGCTACCCATGAACAGCATTCTCGTTGCAT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("GGTGACTATGCCTTCTTCTGTGCAATCAGGCAATTGTGACACGCGCGCTACCCATGAACAGCATTCTCGTTGCAT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 13 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTGACTATGCCTTCTTCTGTGCAATCAGGCAATTGTGACACGCGCGCTACCCATGAACAGCATTCTCGTTGCAT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCTTCTGTGCAATCAGGCAATTGTGACACGCGCGCTACCCATGAACAGCATTCTCGTTGCATGGTGACTATGCCT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("ACTGATGTAGCACGTTCTCGACTGGAATTGACCTCCGGGCTCAGGTGACAGCCTTAATTTCAAAGGGACGAGCCT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 56 { found = true; } } assert(found); }
let d = bio::catalog_digest("ACTGATGTAGCACGTTCTCGACTGGAATTGACCTCCGGGCTCAGGTGACAGCCTTAATTTCAAAGGGACGAGCCT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ACTGATGTAGCACGTTCTCGACTGGAATTGACCTCCGGGCTCAGGTGACAGCCTTA"); }
if i == 1 { assert(f == "ATTTCAAAGGGACGAGCCT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("ACTGATGTAGCACGTTCTCGACTGGAATTGACCTCCGGGCTCAGGTGACAGCCTTAATTTCAAAGGGACGAGCCT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 56 { found = true; } } assert(found); }
let d = bio::catalog_digest("ACTGATGTAGCACGTTCTCGACTGGAATTGACCTCCGGGCTCAGGTGACAGCCTTAATTTCAAAGGGACGAGCCT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATTTCAAAGGGACGAGCCTACTGATGTAGCACGTTCTCGACTGGAATTGACCTCCGGGCTCAGGTGACAGCCTTA"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CCGATGACTGCTGCGGCTGCCGTAACCCACTCGGGTGACTACACGGATTCTCCACGATGGTGGGACTCTTACCAG", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 46 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGATGACTGCTGCGGCTGCCGTAACCCACTCGGGTGACTACACGGATTCTCCACGATGGTGGGACTCTTACCAG", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCGATGACTGCTGCGGCTGCCGTAACCCACTCGGGTGACTACACGG"); }
if i == 1 { assert(f == "ATTCTCCACGATGGTGGGACTCTTACCAG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("CCGATGACTGCTGCGGCTGCCGTAACCCACTCGGGTGACTACACGGATTCTCCACGATGGTGGGACTCTTACCAG", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 46 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCGATGACTGCTGCGGCTGCCGTAACCCACTCGGGTGACTACACGGATTCTCCACGATGGTGGGACTCTTACCAG", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATTCTCCACGATGGTGGGACTCTTACCAGCCGATGACTGCTGCGGCTGCCGTAACCCACTCGGGTGACTACACGG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("GTCGGACGCCGTTTACATCGCGCTACCATCAGGGTGACAGTGACTCAACTTTCCGCGTACCACGCGCTTCCGTGG", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 45 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTCGGACGCCGTTTACATCGCGCTACCATCAGGGTGACAGTGACTCAACTTTCCGCGTACCACGCGCTTCCGTGG", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTCGGACGCCGTTTACATCGCGCTACCATCAGGGTGACAGTGACT"); }
if i == 1 { assert(f == "CAACTTTCCGCGTACCACGCGCTTCCGTGG"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("GTCGGACGCCGTTTACATCGCGCTACCATCAGGGTGACAGTGACTCAACTTTCCGCGTACCACGCGCTTCCGTGG", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 45 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTCGGACGCCGTTTACATCGCGCTACCATCAGGGTGACAGTGACTCAACTTTCCGCGTACCACGCGCTTCCGTGG", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAACTTTCCGCGTACCACGCGCTTCCGTGGGTCGGACGCCGTTTACATCGCGCTACCATCAGGGTGACAGTGACT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("GGTCAACTCTTCATAAATTTGACCAGGGCTAGCCGGATCTGGGATATTTGCTCTGGTGACCCCACAACTTCCCAT", "HphI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 67 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTCAACTCTTCATAAATTTGACCAGGGCTAGCCGGATCTGGGATATTTGCTCTGGTGACCCCACAACTTCCCAT", "HphI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGTCAACTCTTCATAAATTTGACCAGGGCTAGCCGGATCTGGGATATTTGCTCTGGTGACCCCACAA"); }
if i == 1 { assert(f == "CTTCCCAT"); }
}
assert(total == 75);
}
{
let r = bio::catalog_search("GGTCAACTCTTCATAAATTTGACCAGGGCTAGCCGGATCTGGGATATTTGCTCTGGTGACCCCACAACTTCCCAT", "HphI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 67 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGTCAACTCTTCATAAATTTGACCAGGGCTAGCCGGATCTGGGATATTTGCTCTGGTGACCCCACAACTTCCCAT", "HphI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CTTCCCATGGTCAACTCTTCATAAATTTGACCAGGGCTAGCCGGATCTGGGATATTTGCTCTGGTGACCCCACAA"); }
}
assert(total == 75);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAAGGTGATTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAATCACCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("HphI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "HphI" && m.start == 3); assert(m.cuts_in == [0] && m.blocked_in == [1, 2]); }
}
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"); }
}
assert(total == 30);
}
{
let r = bio::catalog_search("CCAAAAAAATGG", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCAAAAAAATGG", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCAAAAAA"); }
if i == 1 { assert(f == "ATGG"); }
}
assert(total == 12);
}
{
let r = bio::catalog_search("CCAAAAAAATGG", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCAAAAAAATGG", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGCCAAAAAA"); }
}
assert(total == 12);
}
{
let r = bio::catalog_search("AAACCAAAAAAATGGTTTTTTTTTTTTTTTTTTTT", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACCAAAAAAATGGTTTTTTTTTTTTTTTTTTTT", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAACCAAAAAA"); }
if i == 1 { assert(f == "ATGGTTTTTTTTTTTTTTTTTTTT"); }
}
assert(total == 35);
}
{
let r = bio::catalog_search("AAACCAAAAAAATGGTTTTTTTTTTTTTTTTTTTT", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 11 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAACCAAAAAAATGGTTTTTTTTTTTTTTTTTTTT", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGTTTTTTTTTTTTTTTTTTTTAAACCAAAAAA"); }
}
assert(total == 35);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAACCATTTTTTTGGTTT", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 28 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAACCATTTTTTTGGTTT", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAAAAAAAAAAAAAAAACCATTTTT"); }
if i == 1 { assert(f == "TTGGTTT"); }
}
assert(total == 35);
}
{
let r = bio::catalog_search("AAAAAAAAAAAAAAAAAAAACCATTTTTTTGGTTT", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 28 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAAAAAAAAAAAAAAAACCATTTTTTTGGTTT", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTGGTTTAAAAAAAAAAAAAAAAAAAACCATTTTT"); }
}
assert(total == 35);
}
{
let r = bio::catalog_search("CCAAAAAAATGGCCAAAAAAATGGCCAAAAAAATGG", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 20 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 32 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCAAAAAAATGGCCAAAAAAATGGCCAAAAAAATGG", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 4);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCAAAAAA"); }
if i == 1 { assert(f == "ATGGCCAAAAAA"); }
if i == 2 { assert(f == "ATGGCCAAAAAA"); }
if i == 3 { assert(f == "ATGG"); }
}
assert(total == 36);
}
{
let r = bio::catalog_search("CCAAAAAAATGGCCAAAAAAATGGCCAAAAAAATGG", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 3);
{ var found = false; for t in tops { if t == 8 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 20 { found = true; } } assert(found); }
{ var found = false; for t in tops { if t == 32 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCAAAAAAATGGCCAAAAAAATGGCCAAAAAAATGG", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 3);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGCCAAAAAA"); }
if i == 1 { assert(f == "ATGGCCAAAAAA"); }
if i == 2 { assert(f == "ATGGCCAAAAAA"); }
}
assert(total == 36);
}
{
let r = bio::catalog_search("AAAAAATGGAAAAAAAAAAAAAAAAAAAACCA", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 0);
let d = bio::catalog_digest("AAAAAATGGAAAAAAAAAAAAAAAAAAAACCA", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AAAAAATGGAAAAAAAAAAAAAAAAAAAACCA"); }
}
assert(total == 32);
}
{
let r = bio::catalog_search("AAAAAATGGAAAAAAAAAAAAAAAAAAAACCA", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 5 { found = true; } } assert(found); }
let d = bio::catalog_digest("AAAAAATGGAAAAAAAAAAAAAAAAAAAACCA", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGAAAAAAAAAAAAAAAAAAAACCAAAAAA"); }
}
assert(total == 32);
}
{
let r = bio::catalog_search("CACTCCTTCCGAACCAAAAAAATGGCAACACTGTCATCGGACCCGGCCTAATCACAATATTCATTTCTCCTCTCAACTGTAC", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 21 { found = true; } } assert(found); }
let d = bio::catalog_digest("CACTCCTTCCGAACCAAAAAAATGGCAACACTGTCATCGGACCCGGCCTAATCACAATATTCATTTCTCCTCTCAACTGTAC", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CACTCCTTCCGAACCAAAAAA"); }
if i == 1 { assert(f == "ATGGCAACACTGTCATCGGACCCGGCCTAATCACAATATTCATTTCTCCTCTCAACTGTAC"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CACTCCTTCCGAACCAAAAAAATGGCAACACTGTCATCGGACCCGGCCTAATCACAATATTCATTTCTCCTCTCAACTGTAC", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 21 { found = true; } } assert(found); }
let d = bio::catalog_digest("CACTCCTTCCGAACCAAAAAAATGGCAACACTGTCATCGGACCCGGCCTAATCACAATATTCATTTCTCCTCTCAACTGTAC", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGCAACACTGTCATCGGACCCGGCCTAATCACAATATTCATTTCTCCTCTCAACTGTACCACTCCTTCCGAACCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CCCAAAAAAATGGAAGTCTACCCCGCCCGCGCTCGAACGTACAGAACCATGCCGAGGGAAGACTATCAATGCTATCTATTTA", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 9 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCAAAAAAATGGAAGTCTACCCCGCCCGCGCTCGAACGTACAGAACCATGCCGAGGGAAGACTATCAATGCTATCTATTTA", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CCCAAAAAA"); }
if i == 1 { assert(f == "ATGGAAGTCTACCCCGCCCGCGCTCGAACGTACAGAACCATGCCGAGGGAAGACTATCAATGCTATCTATTTA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CCCAAAAAAATGGAAGTCTACCCCGCCCGCGCTCGAACGTACAGAACCATGCCGAGGGAAGACTATCAATGCTATCTATTTA", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 9 { found = true; } } assert(found); }
let d = bio::catalog_digest("CCCAAAAAAATGGAAGTCTACCCCGCCCGCGCTCGAACGTACAGAACCATGCCGAGGGAAGACTATCAATGCTATCTATTTA", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGAAGTCTACCCCGCCCGCGCTCGAACGTACAGAACCATGCCGAGGGAAGACTATCAATGCTATCTATTTACCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("TCGAGTTCGGGCGGTGGGAGCTTATCGAAATCCAAAAAAATGGAAACGGTCTAGAGGTGGGATTCGAAGCGCACTTATCATG", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 39 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCGAGTTCGGGCGGTGGGAGCTTATCGAAATCCAAAAAAATGGAAACGGTCTAGAGGTGGGATTCGAAGCGCACTTATCATG", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TCGAGTTCGGGCGGTGGGAGCTTATCGAAATCCAAAAAA"); }
if i == 1 { assert(f == "ATGGAAACGGTCTAGAGGTGGGATTCGAAGCGCACTTATCATG"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("TCGAGTTCGGGCGGTGGGAGCTTATCGAAATCCAAAAAAATGGAAACGGTCTAGAGGTGGGATTCGAAGCGCACTTATCATG", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 39 { found = true; } } assert(found); }
let d = bio::catalog_digest("TCGAGTTCGGGCGGTGGGAGCTTATCGAAATCCAAAAAAATGGAAACGGTCTAGAGGTGGGATTCGAAGCGCACTTATCATG", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGAAACGGTCTAGAGGTGGGATTCGAAGCGCACTTATCATGTCGAGTTCGGGCGGTGGGAGCTTATCGAAATCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CGCCAAAAAAATGGGTATCACTGGGAGCAGTGATGGCTCTCTTTGAGCGACCCTTCACTAGATATCACCGAAGCGCGTTACA", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCCAAAAAAATGGGTATCACTGGGAGCAGTGATGGCTCTCTTTGAGCGACCCTTCACTAGATATCACCGAAGCGCGTTACA", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGCCAAAAAA"); }
if i == 1 { assert(f == "ATGGGTATCACTGGGAGCAGTGATGGCTCTCTTTGAGCGACCCTTCACTAGATATCACCGAAGCGCGTTACA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CGCCAAAAAAATGGGTATCACTGGGAGCAGTGATGGCTCTCTTTGAGCGACCCTTCACTAGATATCACCGAAGCGCGTTACA", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 10 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCCAAAAAAATGGGTATCACTGGGAGCAGTGATGGCTCTCTTTGAGCGACCCTTCACTAGATATCACCGAAGCGCGTTACA", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGGTATCACTGGGAGCAGTGATGGCTCTCTTTGAGCGACCCTTCACTAGATATCACCGAAGCGCGTTACACGCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("AACCGTACTTAGCAACTTGACACCAAAAAAATGGCAGGGGACGACCTAAAAAAGAAGGCAGCGCCCAGACTGGCGCGCTGAC", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 30 { found = true; } } assert(found); }
let d = bio::catalog_digest("AACCGTACTTAGCAACTTGACACCAAAAAAATGGCAGGGGACGACCTAAAAAAGAAGGCAGCGCCCAGACTGGCGCGCTGAC", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "AACCGTACTTAGCAACTTGACACCAAAAAA"); }
if i == 1 { assert(f == "ATGGCAGGGGACGACCTAAAAAAGAAGGCAGCGCCCAGACTGGCGCGCTGAC"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("AACCGTACTTAGCAACTTGACACCAAAAAAATGGCAGGGGACGACCTAAAAAAGAAGGCAGCGCCCAGACTGGCGCGCTGAC", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 30 { found = true; } } assert(found); }
let d = bio::catalog_digest("AACCGTACTTAGCAACTTGACACCAAAAAAATGGCAGGGGACGACCTAAAAAAGAAGGCAGCGCCCAGACTGGCGCGCTGAC", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGCAGGGGACGACCTAAAAAAGAAGGCAGCGCCCAGACTGGCGCGCTGACAACCGTACTTAGCAACTTGACACCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("GGCCTACATCATCATACTGCATCTCTTCTTTAACACTAATATCACGCAAGTTCCAAAAAAATGGCGCAGCGGGATGAATCGC", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 60 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGCCTACATCATCATACTGCATCTCTTCTTTAACACTAATATCACGCAAGTTCCAAAAAAATGGCGCAGCGGGATGAATCGC", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GGCCTACATCATCATACTGCATCTCTTCTTTAACACTAATATCACGCAAGTTCCAAAAAA"); }
if i == 1 { assert(f == "ATGGCGCAGCGGGATGAATCGC"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("GGCCTACATCATCATACTGCATCTCTTCTTTAACACTAATATCACGCAAGTTCCAAAAAAATGGCGCAGCGGGATGAATCGC", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 60 { found = true; } } assert(found); }
let d = bio::catalog_digest("GGCCTACATCATCATACTGCATCTCTTCTTTAACACTAATATCACGCAAGTTCCAAAAAAATGGCGCAGCGGGATGAATCGC", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGCGCAGCGGGATGAATCGCGGCCTACATCATCATACTGCATCTCTTCTTTAACACTAATATCACGCAAGTTCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("GTAAACGTAGGCCGGACGACCGGCACTCCAAAAAAATGGCCCAGCCCTGTCGTCGACGGCTCTCGATGGCCGGACTGTGGAT", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTAAACGTAGGCCGGACGACCGGCACTCCAAAAAAATGGCCCAGCCCTGTCGTCGACGGCTCTCGATGGCCGGACTGTGGAT", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTAAACGTAGGCCGGACGACCGGCACTCCAAAAAA"); }
if i == 1 { assert(f == "ATGGCCCAGCCCTGTCGTCGACGGCTCTCGATGGCCGGACTGTGGAT"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("GTAAACGTAGGCCGGACGACCGGCACTCCAAAAAAATGGCCCAGCCCTGTCGTCGACGGCTCTCGATGGCCGGACTGTGGAT", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 35 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTAAACGTAGGCCGGACGACCGGCACTCCAAAAAAATGGCCCAGCCCTGTCGTCGACGGCTCTCGATGGCCGGACTGTGGAT", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGCCCAGCCCTGTCGTCGACGGCTCTCGATGGCCGGACTGTGGATGTAAACGTAGGCCGGACGACCGGCACTCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("GTATCTACCAAAAAAATGGGCAGAACAACGAAAGAAATGACGAAGGCAGGTTCGCTGAAGGAACCACCCGACGCTTAATTTA", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 15 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTATCTACCAAAAAAATGGGCAGAACAACGAAAGAAATGACGAAGGCAGGTTCGCTGAAGGAACCACCCGACGCTTAATTTA", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "GTATCTACCAAAAAA"); }
if i == 1 { assert(f == "ATGGGCAGAACAACGAAAGAAATGACGAAGGCAGGTTCGCTGAAGGAACCACCCGACGCTTAATTTA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("GTATCTACCAAAAAAATGGGCAGAACAACGAAAGAAATGACGAAGGCAGGTTCGCTGAAGGAACCACCCGACGCTTAATTTA", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 15 { found = true; } } assert(found); }
let d = bio::catalog_digest("GTATCTACCAAAAAAATGGGCAGAACAACGAAAGAAATGACGAAGGCAGGTTCGCTGAAGGAACCACCCGACGCTTAATTTA", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGGCAGAACAACGAAAGAAATGACGAAGGCAGGTTCGCTGAAGGAACCACCCGACGCTTAATTTAGTATCTACCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("TTGGCCCGTATTGCGTCCGGCTCAATTTAGTTGGCCAAAAAAATGGTCTGGAGCCACGCAGATGACGTATCAAGCTAGGAGC", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTGGCCCGTATTGCGTCCGGCTCAATTTAGTTGGCCAAAAAAATGGTCTGGAGCCACGCAGATGACGTATCAAGCTAGGAGC", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "TTGGCCCGTATTGCGTCCGGCTCAATTTAGTTGGCCAAAAAA"); }
if i == 1 { assert(f == "ATGGTCTGGAGCCACGCAGATGACGTATCAAGCTAGGAGC"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("TTGGCCCGTATTGCGTCCGGCTCAATTTAGTTGGCCAAAAAAATGGTCTGGAGCCACGCAGATGACGTATCAAGCTAGGAGC", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 42 { found = true; } } assert(found); }
let d = bio::catalog_digest("TTGGCCCGTATTGCGTCCGGCTCAATTTAGTTGGCCAAAAAAATGGTCTGGAGCCACGCAGATGACGTATCAAGCTAGGAGC", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGTCTGGAGCCACGCAGATGACGTATCAAGCTAGGAGCTTGGCCCGTATTGCGTCCGGCTCAATTTAGTTGGCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("ATTACCCGCTTTTCGTCATCACTCCGCCGGAGGATCGCTAGCAGGACGCTGATTCTCCAAAAAAATGGGCACCATCATGCAT", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 64 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATTACCCGCTTTTCGTCATCACTCCGCCGGAGGATCGCTAGCAGGACGCTGATTCTCCAAAAAAATGGGCACCATCATGCAT", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATTACCCGCTTTTCGTCATCACTCCGCCGGAGGATCGCTAGCAGGACGCTGATTCTCCAAAAAA"); }
if i == 1 { assert(f == "ATGGGCACCATCATGCAT"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("ATTACCCGCTTTTCGTCATCACTCCGCCGGAGGATCGCTAGCAGGACGCTGATTCTCCAAAAAAATGGGCACCATCATGCAT", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 64 { found = true; } } assert(found); }
let d = bio::catalog_digest("ATTACCCGCTTTTCGTCATCACTCCGCCGGAGGATCGCTAGCAGGACGCTGATTCTCCAAAAAAATGGGCACCATCATGCAT", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGGCACCATCATGCATATTACCCGCTTTTCGTCATCACTCCGCCGGAGGATCGCTAGCAGGACGCTGATTCTCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CAACATCTAAGTCTATCCAAAAAAATGGTCTGCCATAAGCTTGCTTTAGGTCCACTGATTCGTGTGCGATCAGAATGATCCG", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 24 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAACATCTAAGTCTATCCAAAAAAATGGTCTGCCATAAGCTTGCTTTAGGTCCACTGATTCGTGTGCGATCAGAATGATCCG", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CAACATCTAAGTCTATCCAAAAAA"); }
if i == 1 { assert(f == "ATGGTCTGCCATAAGCTTGCTTTAGGTCCACTGATTCGTGTGCGATCAGAATGATCCG"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CAACATCTAAGTCTATCCAAAAAAATGGTCTGCCATAAGCTTGCTTTAGGTCCACTGATTCGTGTGCGATCAGAATGATCCG", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 24 { found = true; } } assert(found); }
let d = bio::catalog_digest("CAACATCTAAGTCTATCCAAAAAAATGGTCTGCCATAAGCTTGCTTTAGGTCCACTGATTCGTGTGCGATCAGAATGATCCG", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGTCTGCCATAAGCTTGCTTTAGGTCCACTGATTCGTGTGCGATCAGAATGATCCGCAACATCTAAGTCTATCCAAAAAA"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CGCATGTTTAGCTGTACTCCACTTTCTACCAAAAAAATGGAATTCCTCTGGATGAGATCAAGGGATAGGCTTTGGGCGCATC", "BstXI", false); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 36 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCATGTTTAGCTGTACTCCACTTTCTACCAAAAAAATGGAATTCCTCTGGATGAGATCAAGGGATAGGCTTTGGGCGCATC", "BstXI", false); assert(d.error.len == 0 && d.fragments.len == 2);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "CGCATGTTTAGCTGTACTCCACTTTCTACCAAAAAA"); }
if i == 1 { assert(f == "ATGGAATTCCTCTGGATGAGATCAAGGGATAGGCTTTGGGCGCATC"); }
}
assert(total == 82);
}
{
let r = bio::catalog_search("CGCATGTTTAGCTGTACTCCACTTTCTACCAAAAAAATGGAATTCCTCTGGATGAGATCAAGGGATAGGCTTTGGGCGCATC", "BstXI", true); assert(r.error.len == 0);
var tops: i64[>..] = []; for h in r.cuts { tops.push(h.top); }
assert(tops.len == 1);
{ var found = false; for t in tops { if t == 36 { found = true; } } assert(found); }
let d = bio::catalog_digest("CGCATGTTTAGCTGTACTCCACTTTCTACCAAAAAAATGGAATTCCTCTGGATGAGATCAAGGGATAGGCTTTGGGCGCATC", "BstXI", true); assert(d.error.len == 0 && d.fragments.len == 1);
var total: i64 = 0; for f, i in d.fragments { total += f.len;
if i == 0 { assert(f == "ATGGAATTCCTCTGGATGAGATCAAGGGATAGGCTTTGGGCGCATCCGCATGTTTAGCTGTACTCCACTTTCTACCAAAAAA"); }
}
assert(total == 82);
}
{
let c = bio::catalog_caps([bio::restriction_copy("AAACCAAAAAAATGGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),bio::restriction_copy("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),bio::restriction_copy("AAACCATTTTTTTGGTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")], [bio::restriction_copy("BstXI")]); assert(c.error.len == 0 && c.markers.len == 1);
for m, i in c.markers {
if i == 0 { assert(m.enzyme == "BstXI" && m.start == 3); assert(m.cuts_in == [0, 2] && m.blocked_in == [1]); }
}
}
}
