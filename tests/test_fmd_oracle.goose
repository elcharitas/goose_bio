// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import std;
import bio from "..";
import bio.search.fmd;
fn main() {
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 9 && s2.reverse == 17 && s2.size == 4 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 4);
        for h, k in h1.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'G', true);
        assert(s3.error.len == 0 && s3.forward == 9 && s3.reverse == 13 && s3.size == 4 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 4);
        for h, k in h2.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 1 && h.end == 4); } }
        for h, k in h2.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 4); } }
        for h, k in h2.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 3); } }
        for h, k in h2.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 9 && s4.reverse == 9 && s4.size == 4 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 4);
        for h, k in h3.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 0 && h.end == 4); } }
        for h, k in h3.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 4); } }
        for h, k in h3.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 4); } }
        for h, k in h3.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 4); } }
        let s5 = bio::fmd_extend(idx, s4, 'N', true);
        assert(s5.error.len == 0 && s5.forward == 11 && s5.reverse == 23 && s5.size == 2 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 2);
        for h, k in h4.hits { if k == 0 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 5); } }
        for h, k in h4.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 5); } }
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 13 && s6.reverse == 30 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', true);
        assert(s7.error.len == 0 && s7.forward == 13 && s7.reverse == 31 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 13 && s8.reverse == 32 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 5 { assert(m.state.forward == 11 && m.state.reverse == 23 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 8 { assert(m.state.forward == 8 && m.state.reverse == 31 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 4 && m.end == 6 { assert(m.state.forward == 23 && m.state.reverse == 28 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 5 { found0 = true; } } assert(found0);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 6 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 8 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 2);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 9 && s2.reverse == 17 && s2.size == 4 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 4);
        for h, k in h1.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'G', false);
        assert(s3.error.len == 0 && s3.forward == 17 && s3.reverse == 19 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 17 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', false);
        assert(s5.error.len == 0 && s5.forward == 25 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 25 && s6.reverse == 28 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', false);
        assert(s7.error.len == 0 && s7.forward == 13 && s7.reverse == 28 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 13 && s8.reverse == 31 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 5 { assert(m.state.forward == 11 && m.state.reverse == 23 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 8 { assert(m.state.forward == 8 && m.state.reverse == 31 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 4 && m.end == 6 { assert(m.state.forward == 23 && m.state.reverse == 28 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 5 { found0 = true; } } assert(found0);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 6 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 8 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 2);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 13 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 13 && s3.reverse == 9 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 13 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', true);
        assert(s5.error.len == 0 && s5.forward == 13 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 13 && s6.reverse == 13 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', true);
        assert(s7.error.len == 0 && s7.forward == 13 && s7.reverse == 13 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 6 && m.state.reverse == 25 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 30 && m.state.reverse == 7 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 13 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 28 && s3.reverse == 13 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 28 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', false);
        assert(s5.error.len == 0 && s5.forward == 19 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 19 && s6.reverse == 13 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', false);
        assert(s7.error.len == 0 && s7.forward == 17 && s7.reverse == 13 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 6 && m.state.reverse == 25 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 30 && m.state.reverse == 7 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', true);
        assert(s1.error.len == 0 && s1.forward == 21 && s1.reverse == 21 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == false && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 2 && h.reverse == true && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 5); } }
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 25 && s2.reverse == 25 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', true);
        assert(s3.error.len == 0 && s3.forward == 25 && s3.reverse == 25 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 21 && m.state.reverse == 21 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 21 && m.state.reverse == 21 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 21 && m.state.reverse == 21 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', false);
        assert(s1.error.len == 0 && s1.forward == 21 && s1.reverse == 21 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == false && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 2 && h.reverse == true && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 5); } }
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 25 && s2.reverse == 25 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', false);
        assert(s3.error.len == 0 && s3.forward == 25 && s3.reverse == 25 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 21 && m.state.reverse == 21 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 21 && m.state.reverse == 21 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 21 && m.state.reverse == 21 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', true);
        assert(s1.error.len == 0 && s1.forward == 25 && s1.reverse == 6 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 1 && h.reverse == true && h.start == 2 && h.end == 3); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 25 && m.state.reverse == 6 && m.state.size == 7); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', false);
        assert(s1.error.len == 0 && s1.forward == 25 && s1.reverse == 6 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 1 && h.reverse == true && h.start == 2 && h.end == 3); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 25 && m.state.reverse == 6 && m.state.size == 7); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', true);
        assert(s1.error.len == 0 && s1.forward == 13 && s1.reverse == 17 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 13 && s2.reverse == 17 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', true);
        assert(s3.error.len == 0 && s3.forward == 13 && s3.reverse == 17 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 13 && s4.reverse == 17 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', true);
        assert(s5.error.len == 0 && s5.forward == 13 && s5.reverse == 17 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 13 && s6.reverse == 17 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', false);
        assert(s1.error.len == 0 && s1.forward == 13 && s1.reverse == 17 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 13 && s2.reverse == 17 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', false);
        assert(s3.error.len == 0 && s3.forward == 13 && s3.reverse == 17 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 13 && s4.reverse == 17 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', false);
        assert(s5.error.len == 0 && s5.forward == 13 && s5.reverse == 17 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 13 && s6.reverse == 17 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 9 && s2.reverse == 17 && s2.size == 4 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 4);
        for h, k in h1.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 9 && s3.reverse == 28 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 9 && s4.reverse == 19 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 9 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 9 && m.state.reverse == 17 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 9 && s2.reverse == 17 && s2.size == 4 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 4);
        for h, k in h1.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 9 && s3.reverse == 21 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 9 && s4.reverse == 17 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 9 && m.state.reverse == 17 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 9 && m.state.reverse == 17 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', true);
        assert(s1.error.len == 0 && s1.forward == 17 && s1.reverse == 13 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 17 && s2.reverse == 28 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 17 && s3.reverse == 13 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 17 && s4.reverse == 28 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', true);
        assert(s5.error.len == 0 && s5.forward == 17 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 17 && s6.reverse == 17 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 6 && m.state.reverse == 25 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 25 && m.state.reverse == 6 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 6 && m.state.reverse == 25 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 25 && m.state.reverse == 6 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', false);
        assert(s1.error.len == 0 && s1.forward == 17 && s1.reverse == 13 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 2 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 2 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 17 && s2.reverse == 28 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 28 && s3.reverse == 28 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 28 && s4.reverse == 31 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', false);
        assert(s5.error.len == 0 && s5.forward == 31 && s5.reverse == 31 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 31 && s6.reverse == 21 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 17 && m.state.reverse == 13 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 6 && m.state.reverse == 25 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 25 && m.state.reverse == 6 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 6 && m.state.reverse == 25 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 25 && m.state.reverse == 6 && m.state.size == 7); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 13 && m.state.reverse == 17 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 30 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 3); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 31 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 9 && s4.reverse == 32 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 31 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 31 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 4 { found1 = true; } } assert(found1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ACGTN" }, bio::FMDRecord { "1", "AAA" }, bio::FMDRecord { "2", "ACGTN" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 31);
        assert(idx.fm.sa[1] == 25);
        assert(idx.fm.sa[2] == 19);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 11);
        assert(idx.fm.sa[5] == 5);
        assert(idx.fm.sa[6] == 14);
        assert(idx.fm.sa[7] == 13);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 27);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 20);
        assert(idx.fm.sa[12] == 0);
        assert(idx.fm.sa[13] == 28);
        assert(idx.fm.sa[14] == 8);
        assert(idx.fm.sa[15] == 21);
        assert(idx.fm.sa[16] == 1);
        assert(idx.fm.sa[17] == 29);
        assert(idx.fm.sa[18] == 9);
        assert(idx.fm.sa[19] == 22);
        assert(idx.fm.sa[20] == 2);
        assert(idx.fm.sa[21] == 24);
        assert(idx.fm.sa[22] == 4);
        assert(idx.fm.sa[23] == 26);
        assert(idx.fm.sa[24] == 6);
        assert(idx.fm.sa[25] == 30);
        assert(idx.fm.sa[26] == 18);
        assert(idx.fm.sa[27] == 10);
        assert(idx.fm.sa[28] == 23);
        assert(idx.fm.sa[29] == 3);
        assert(idx.fm.sa[30] == 17);
        assert(idx.fm.sa[31] == 16);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 25 && s1.size == 7 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 7);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 2 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 5 { assert(h.record == 2 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 6 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 30 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 3); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 31 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 9 && s4.reverse == 32 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 31 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 31 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 4 { found1 = true; } } assert(found1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 12 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', true);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 16 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 20 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', true);
        assert(s7.error.len == 0 && s7.forward == 4 && s7.reverse == 20 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 4 && s8.reverse == 20 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 16 && m.state.reverse == 4 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 7 && m.end == 8 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        var found7: bool = false; for m in ms.matches { if m.start == 7 && m.end == 8 { found7 = true; } } assert(found7);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', false);
        assert(s3.error.len == 0 && s3.forward == 14 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 14 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', false);
        assert(s5.error.len == 0 && s5.forward == 16 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 16 && s6.reverse == 18 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', false);
        assert(s7.error.len == 0 && s7.forward == 4 && s7.reverse == 18 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 4 && s8.reverse == 20 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 16 && m.state.reverse == 4 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 7 && m.end == 8 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        var found7: bool = false; for m in ms.matches { if m.start == 7 && m.end == 8 { found7 = true; } } assert(found7);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 4 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 4);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', true);
        assert(s5.error.len == 0 && s5.forward == 8 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 8 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', true);
        assert(s7.error.len == 0 && s7.forward == 8 && s7.reverse == 8 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 16 && m.state.reverse == 4 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 4 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 4);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        for h, k in h1.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 18 && s3.reverse == 6 && s3.size == 2 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 2);
        for h, k in h2.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 3); } }
        for h, k in h2.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 4); } }
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 20 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', false);
        assert(s5.error.len == 0 && s5.forward == 16 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 16 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', false);
        assert(s7.error.len == 0 && s7.forward == 16 && s7.reverse == 8 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 16 && m.state.reverse == 4 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', true);
        assert(s1.error.len == 0 && s1.forward == 16 && s1.reverse == 16 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 16 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', true);
        assert(s3.error.len == 0 && s3.forward == 16 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', false);
        assert(s1.error.len == 0 && s1.forward == 16 && s1.reverse == 16 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 16 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', false);
        assert(s3.error.len == 0 && s3.forward == 16 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', true);
        assert(s1.error.len == 0 && s1.forward == 16 && s1.reverse == 4 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 16 && m.state.reverse == 4 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', false);
        assert(s1.error.len == 0 && s1.forward == 16 && s1.reverse == 4 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 16 && m.state.reverse == 4 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', true);
        assert(s1.error.len == 0 && s1.forward == 8 && s1.reverse == 12 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', true);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', true);
        assert(s5.error.len == 0 && s5.forward == 8 && s5.reverse == 16 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 8 && s6.reverse == 16 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', false);
        assert(s1.error.len == 0 && s1.forward == 8 && s1.reverse == 12 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', false);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', false);
        assert(s5.error.len == 0 && s5.forward == 8 && s5.reverse == 16 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 8 && s6.reverse == 16 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 20 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 16 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', true);
        assert(s1.error.len == 0 && s1.forward == 12 && s1.reverse == 8 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 14 && s2.reverse == 20 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 14 && s3.reverse == 8 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 14 && s4.reverse == 20 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', true);
        assert(s5.error.len == 0 && s5.forward == 14 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 14 && s6.reverse == 14 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 5 { assert(m.state.forward == 6 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 5 { found1 = true; } } assert(found1);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', false);
        assert(s1.error.len == 0 && s1.forward == 12 && s1.reverse == 8 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 14 && s2.reverse == 20 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 20 && s3.reverse == 20 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 20 && s4.reverse == 20 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', false);
        assert(s5.error.len == 0 && s5.forward == 20 && s5.reverse == 20 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 20 && s6.reverse == 16 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 12 && m.state.reverse == 8 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 5 { assert(m.state.forward == 6 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 8 && m.state.reverse == 12 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 5 { found1 = true; } } assert(found1);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 20 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 20 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 20 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATAT" }, bio::FMDRecord { "1", "CGCG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 19);
        assert(idx.fm.sa[1] == 14);
        assert(idx.fm.sa[2] == 9);
        assert(idx.fm.sa[3] == 4);
        assert(idx.fm.sa[4] == 7);
        assert(idx.fm.sa[5] == 2);
        assert(idx.fm.sa[6] == 5);
        assert(idx.fm.sa[7] == 0);
        assert(idx.fm.sa[8] == 17);
        assert(idx.fm.sa[9] == 12);
        assert(idx.fm.sa[10] == 15);
        assert(idx.fm.sa[11] == 10);
        assert(idx.fm.sa[12] == 18);
        assert(idx.fm.sa[13] == 13);
        assert(idx.fm.sa[14] == 16);
        assert(idx.fm.sa[15] == 11);
        assert(idx.fm.sa[16] == 8);
        assert(idx.fm.sa[17] == 3);
        assert(idx.fm.sa[18] == 6);
        assert(idx.fm.sa[19] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 16 && s1.size == 4 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 4);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 20 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 20 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 20 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 16 && m.state.size == 4); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', true);
        assert(s3.error.len == 0 && s3.forward == 7 && s3.reverse == 10 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 7 && s4.reverse == 7 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', true);
        assert(s5.error.len == 0 && s5.forward == 7 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 7 && s6.reverse == 14 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', true);
        assert(s7.error.len == 0 && s7.forward == 7 && s7.reverse == 15 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 7 && s8.reverse == 16 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 5);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 10 && m.state.reverse == 7 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 5 && m.end == 8 { assert(m.state.forward == 6 && m.state.reverse == 15 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 8 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', false);
        assert(s3.error.len == 0 && s3.forward == 11 && s3.reverse == 13 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 11 && s4.reverse == 7 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', false);
        assert(s5.error.len == 0 && s5.forward == 13 && s5.reverse == 7 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 13 && s6.reverse == 14 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', false);
        assert(s7.error.len == 0 && s7.forward == 7 && s7.reverse == 14 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 7 && s8.reverse == 15 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 5);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 10 && m.state.reverse == 7 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 5 && m.end == 8 { assert(m.state.forward == 6 && m.state.reverse == 15 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 8 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 7 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 7 && s3.reverse == 7 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 7 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', true);
        assert(s5.error.len == 0 && s5.forward == 7 && s5.reverse == 9 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 7 && s6.reverse == 10 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', true);
        assert(s7.error.len == 0 && s7.forward == 7 && s7.reverse == 10 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 14 && m.state.reverse == 5 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 6 { assert(m.state.forward == 12 && m.state.reverse == 9 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 4 && m.end == 7 { assert(m.state.forward == 12 && m.state.reverse == 9 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 6 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 7 { found4 = true; } } assert(found4);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 2);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 7 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 14 && s3.reverse == 7 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 14 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', false);
        assert(s5.error.len == 0 && s5.forward == 13 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 13 && s6.reverse == 9 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', false);
        assert(s7.error.len == 0 && s7.forward == 13 && s7.reverse == 9 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 14 && m.state.reverse == 5 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 6 { assert(m.state.forward == 12 && m.state.reverse == 9 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 4 && m.end == 7 { assert(m.state.forward == 12 && m.state.reverse == 9 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 6 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 7 { found4 = true; } } assert(found4);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 2);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', true);
        assert(s1.error.len == 0 && s1.forward == 13 && s1.reverse == 13 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 13 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', true);
        assert(s3.error.len == 0 && s3.forward == 13 && s3.reverse == 13 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', false);
        assert(s1.error.len == 0 && s1.forward == 13 && s1.reverse == 13 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 13 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', false);
        assert(s3.error.len == 0 && s3.forward == 13 && s3.reverse == 13 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', true);
        assert(s1.error.len == 0 && s1.forward == 13 && s1.reverse == 4 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', false);
        assert(s1.error.len == 0 && s1.forward == 13 && s1.reverse == 4 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', true);
        assert(s1.error.len == 0 && s1.forward == 7 && s1.reverse == 10 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 11 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 3); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'C', true);
        assert(s3.error.len == 0 && s3.forward == 9 && s3.reverse == 12 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 10 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', true);
        assert(s5.error.len == 0 && s5.forward == 10 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 10 && s6.reverse == 13 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 3 && m.end == 6 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 2 && m.end == 5 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 4 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 4 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 5 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 6 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', false);
        assert(s1.error.len == 0 && s1.forward == 7 && s1.reverse == 10 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 11 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 3); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'C', false);
        assert(s3.error.len == 0 && s3.forward == 9 && s3.reverse == 12 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 10 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', false);
        assert(s5.error.len == 0 && s5.forward == 10 && s5.reverse == 13 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 10 && s6.reverse == 13 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 3 && m.end == 6 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 2 && m.end == 5 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 4 { assert(m.state.forward == 9 && m.state.reverse == 12 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 4 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 5 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 6 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 7 && s3.reverse == 14 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 7 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 7 && s2.reverse == 13 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 7 && s3.reverse == 13 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 7 && s4.reverse == 13 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', true);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 7 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == true && h.start == 2 && h.end == 3); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 11 && s2.reverse == 14 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 11 && s3.reverse == 7 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 11 && s4.reverse == 14 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', true);
        assert(s5.error.len == 0 && s5.forward == 11 && s5.reverse == 7 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 11 && s6.reverse == 11 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 10 && m.state.reverse == 7 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', false);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 7 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 1 && h.reverse == true && h.start == 2 && h.end == 3); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 11 && s2.reverse == 14 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 14 && s3.reverse == 14 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 14 && s4.reverse == 15 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', false);
        assert(s5.error.len == 0 && s5.forward == 15 && s5.reverse == 15 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 15 && s6.reverse == 13 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 10 && m.state.reverse == 7 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 13 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 13 && m.state.reverse == 4 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 7 && m.state.reverse == 10 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 5 && s2.reverse == 14 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 3); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 15 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 7 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 6 && m.state.reverse == 15 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 4 { assert(m.state.forward == 6 && m.state.reverse == 15 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 4 { found1 = true; } } assert(found1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AAA" }, bio::FMDRecord { "1", "CCC" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 15);
        assert(idx.fm.sa[1] == 11);
        assert(idx.fm.sa[2] == 7);
        assert(idx.fm.sa[3] == 3);
        assert(idx.fm.sa[4] == 2);
        assert(idx.fm.sa[5] == 1);
        assert(idx.fm.sa[6] == 0);
        assert(idx.fm.sa[7] == 10);
        assert(idx.fm.sa[8] == 9);
        assert(idx.fm.sa[9] == 8);
        assert(idx.fm.sa[10] == 14);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 12);
        assert(idx.fm.sa[13] == 6);
        assert(idx.fm.sa[14] == 5);
        assert(idx.fm.sa[15] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 13 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 5 && s2.reverse == 14 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 3); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 15 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 7 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 6 && m.state.reverse == 15 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 4 { assert(m.state.forward == 6 && m.state.reverse == 15 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 4 { found1 = true; } } assert(found1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', true);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 6 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 6 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', true);
        assert(s7.error.len == 0 && s7.forward == 4 && s7.reverse == 6 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 4 && s8.reverse == 6 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', false);
        assert(s5.error.len == 0 && s5.forward == 6 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 6 && s6.reverse == 6 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', false);
        assert(s7.error.len == 0 && s7.forward == 4 && s7.reverse == 6 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 4 && s8.reverse == 6 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', true);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 4 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', true);
        assert(s7.error.len == 0 && s7.forward == 4 && s7.reverse == 4 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 6 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', false);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 4 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', false);
        assert(s7.error.len == 0 && s7.forward == 4 && s7.reverse == 4 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 0);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 4 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 6 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', true);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 4 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 6 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', false);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 4 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', true);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 4 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', false);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 4 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 4 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', true);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 4 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 4 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', false);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 4 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 4 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 4 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 4 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 6 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', true);
        assert(s5.error.len == 0 && s5.forward == 4 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 4 && s6.reverse == 4 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 4 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 6 && s4.reverse == 6 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', false);
        assert(s5.error.len == 0 && s5.forward == 6 && s5.reverse == 6 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 6 && s6.reverse == 4 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 6 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "" }, bio::FMDRecord { "1", "N" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 5);
        assert(idx.fm.sa[1] == 3);
        assert(idx.fm.sa[2] == 1);
        assert(idx.fm.sa[3] == 0);
        assert(idx.fm.sa[4] == 4);
        assert(idx.fm.sa[5] == 2);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 6 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 6 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 0);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 8 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'G', true);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 8 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 6 && s4.reverse == 6 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', true);
        assert(s5.error.len == 0 && s5.forward == 6 && s5.reverse == 10 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 6 && s6.reverse == 12 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', true);
        assert(s7.error.len == 0 && s7.forward == 6 && s7.reverse == 12 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 6 && s8.reverse == 12 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 5);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 7 && m.end == 8 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        var found7: bool = false; for m in ms.matches { if m.start == 7 && m.end == 8 { found7 = true; } } assert(found7);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 8 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'G', false);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 10 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 6 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', false);
        assert(s5.error.len == 0 && s5.forward == 10 && s5.reverse == 6 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 10 && s6.reverse == 12 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', false);
        assert(s7.error.len == 0 && s7.forward == 6 && s7.reverse == 12 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 6 && s8.reverse == 12 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 5);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 7 && m.end == 8 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        var found7: bool = false; for m in ms.matches { if m.start == 7 && m.end == 8 { found7 = true; } } assert(found7);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 6 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 6 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', true);
        assert(s5.error.len == 0 && s5.forward == 6 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 6 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', true);
        assert(s7.error.len == 0 && s7.forward == 6 && s7.reverse == 8 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 7);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 6 && s2.reverse == 6 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 12 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 12 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', false);
        assert(s5.error.len == 0 && s5.forward == 10 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 10 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', false);
        assert(s7.error.len == 0 && s7.forward == 8 && s7.reverse == 8 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 7);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 6 && m.end == 7 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 7 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', true);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 10 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 10 && s2.reverse == 10 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', true);
        assert(s3.error.len == 0 && s3.forward == 10 && s3.reverse == 10 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', false);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 10 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 10 && s2.reverse == 10 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', false);
        assert(s3.error.len == 0 && s3.forward == 10 && s3.reverse == 10 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', true);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 4 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', false);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 4 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', true);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 8 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 8 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', true);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 8 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', true);
        assert(s5.error.len == 0 && s5.forward == 8 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 8 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', false);
        assert(s1.error.len == 0 && s1.forward == 6 && s1.reverse == 8 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 8 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'C', false);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 8 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'C', false);
        assert(s5.error.len == 0 && s5.forward == 8 && s5.reverse == 8 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 8 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 8 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 6 && s3.reverse == 12 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 6 && s4.reverse == 10 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 8 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 8 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 10 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 8 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 8 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', true);
        assert(s1.error.len == 0 && s1.forward == 8 && s1.reverse == 6 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 12 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 8 && s3.reverse == 6 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 8 && s4.reverse == 12 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', true);
        assert(s5.error.len == 0 && s5.forward == 8 && s5.reverse == 6 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 8 && s6.reverse == 8 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', false);
        assert(s1.error.len == 0 && s1.forward == 8 && s1.reverse == 6 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == false && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 8 && s2.reverse == 12 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 12 && s3.reverse == 12 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 12 && s4.reverse == 12 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', false);
        assert(s5.error.len == 0 && s5.forward == 12 && s5.reverse == 12 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 12 && s6.reverse == 10 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 6);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 8 && m.state.reverse == 6 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 5 { assert(m.state.forward == 10 && m.state.reverse == 4 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 5 && m.end == 6 { assert(m.state.forward == 6 && m.state.reverse == 8 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 5 { found4 = true; } } assert(found4);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 6 { found5 = true; } } assert(found5);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 12 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 12 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 12 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "AC" }, bio::FMDRecord { "1", "GT" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 11);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 5);
        assert(idx.fm.sa[3] == 2);
        assert(idx.fm.sa[4] == 9);
        assert(idx.fm.sa[5] == 0);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 1);
        assert(idx.fm.sa[8] == 6);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 4);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 4 && s1.reverse == 10 && s1.size == 2 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 2);
        for h, k in h0.hits { if k == 0 { assert(h.record == 1 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 4 && s2.reverse == 12 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 12 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 4 && s4.reverse == 12 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 4 && m.state.reverse == 10 && m.state.size == 2); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 3 && s2.reverse == 15 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', true);
        assert(s3.error.len == 0 && s3.forward == 3 && s3.reverse == 10 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 3 && s4.reverse == 3 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', true);
        assert(s5.error.len == 0 && s5.forward == 3 && s5.reverse == 15 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 3 && s6.reverse == 17 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', true);
        assert(s7.error.len == 0 && s7.forward == 3 && s7.reverse == 18 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 3 && s8.reverse == 18 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 5);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 2 && m.state.reverse == 15 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 15 && m.state.reverse == 2 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 5 && m.end == 7 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 6 && m.end == 8 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 7 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 8 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 2);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 3 && s2.reverse == 15 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'G', false);
        assert(s3.error.len == 0 && s3.forward == 12 && s3.reverse == 15 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'T', true);
        assert(s4.error.len == 0 && s4.forward == 12 && s4.reverse == 3 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'N', false);
        assert(s5.error.len == 0 && s5.forward == 15 && s5.reverse == 3 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'A', true);
        assert(s6.error.len == 0 && s6.forward == 15 && s6.reverse == 16 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'A', false);
        assert(s7.error.len == 0 && s7.forward == 3 && s7.reverse == 16 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let s8 = bio::fmd_extend(idx, s7, 'A', true);
        assert(s8.error.len == 0 && s8.forward == 3 && s8.reverse == 17 && s8.size == 0 && s8.matched == 8);
        let h7 = bio::fmd_locate(idx, s8); assert(h7.error.len == 0 && h7.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACGTNAAA"); assert(ms.error.len == 0 && ms.matches.len == 5);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 2 && m.state.reverse == 15 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 8 && m.state.reverse == 8 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 15 && m.state.reverse == 2 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 5 && m.end == 7 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 6 && m.end == 8 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        var found5: bool = false; for m in ms.matches { if m.start == 5 && m.end == 7 { found5 = true; } } assert(found5);
        var found6: bool = false; for m in ms.matches { if m.start == 6 && m.end == 8 { found6 = true; } } assert(found6);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 4).matches.len == 0);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 6).matches.len == 2);
        assert(bio::fmd_smems(idx, "ACGTNAAA", 1, 7).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 3 && s2.reverse == 3 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 4 && s3.reverse == 2 && s3.size == 1 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 1);
        for h, k in h2.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 3); } }
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 5 && s4.reverse == 5 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', true);
        assert(s5.error.len == 0 && s5.forward == 5 && s5.reverse == 5 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 5 && s6.reverse == 5 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', true);
        assert(s7.error.len == 0 && s7.forward == 5 && s7.reverse == 5 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 2 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 3 && m.end == 7 { assert(m.state.forward == 14 && m.state.reverse == 5 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 7 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'T', true);
        assert(s2.error.len == 0 && s2.forward == 3 && s2.reverse == 3 && s2.size == 2 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 2);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 2); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 2); } }
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 16 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'G', true);
        assert(s4.error.len == 0 && s4.forward == 16 && s4.reverse == 5 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'G', false);
        assert(s5.error.len == 0 && s5.forward == 15 && s5.reverse == 5 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'G', true);
        assert(s6.error.len == 0 && s6.forward == 15 && s6.reverse == 5 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let s7 = bio::fmd_extend(idx, s6, 'G', false);
        assert(s7.error.len == 0 && s7.forward == 15 && s7.reverse == 5 && s7.size == 0 && s7.matched == 7);
        let h6 = bio::fmd_locate(idx, s7); assert(h6.error.len == 0 && h6.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ATTGGGG"); assert(ms.error.len == 0 && ms.matches.len == 2);
        for m in ms.matches { if m.start == 0 && m.end == 3 { assert(m.state.forward == 4 && m.state.reverse == 2 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 3 && m.end == 7 { assert(m.state.forward == 14 && m.state.reverse == 5 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 3 { found0 = true; } } assert(found0);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 7 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 4).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 5).matches.len == 1);
        assert(bio::fmd_smems(idx, "ATTGGGG", 1, 6).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', true);
        assert(s1.error.len == 0 && s1.forward == 15 && s1.reverse == 15 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 15 && s2.reverse == 15 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', true);
        assert(s3.error.len == 0 && s3.forward == 15 && s3.reverse == 15 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'N', false);
        assert(s1.error.len == 0 && s1.forward == 15 && s1.reverse == 15 && s1.size == 0 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 0);
        let s2 = bio::fmd_extend(idx, s1, 'N', true);
        assert(s2.error.len == 0 && s2.forward == 15 && s2.reverse == 15 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'N', false);
        assert(s3.error.len == 0 && s3.forward == 15 && s3.reverse == 15 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let ms = bio::fmd_smems(idx, "NNN"); assert(ms.error.len == 0 && ms.matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 0).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 1).matches.len == 0);
        assert(bio::fmd_smems(idx, "NNN", 1, 2).matches.len == 0);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', true);
        assert(s1.error.len == 0 && s1.forward == 15 && s1.reverse == 2 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 15 && m.state.reverse == 2 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'T', false);
        assert(s1.error.len == 0 && s1.forward == 15 && s1.reverse == 2 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 0 && h.end == 1); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == false && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 1 && h.end == 2); } }
        let ms = bio::fmd_smems(idx, "T"); assert(ms.error.len == 0 && ms.matches.len == 1);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 15 && m.state.reverse == 2 && m.state.size == 3); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        assert(bio::fmd_smems(idx, "T", 1, 0).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', true);
        assert(s1.error.len == 0 && s1.forward == 5 && s1.reverse == 10 && s1.size == 5 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 5);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 7 && h.end == 8); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 6 && h.end == 7); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 5 && h.end == 6); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == false && h.start == 3 && h.end == 4); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 5 && s2.reverse == 12 && s2.size == 3 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 3);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 6 && h.end == 8); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 5 && h.end == 7); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 6); } }
        let s3 = bio::fmd_extend(idx, s2, 'C', true);
        assert(s3.error.len == 0 && s3.forward == 5 && s3.reverse == 13 && s3.size == 2 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 2);
        for h, k in h2.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 5 && h.end == 8); } }
        for h, k in h2.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 7); } }
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 5 && s4.reverse == 14 && s4.size == 1 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 1);
        for h, k in h3.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 8); } }
        let s5 = bio::fmd_extend(idx, s4, 'C', true);
        assert(s5.error.len == 0 && s5.forward == 5 && s5.reverse == 15 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 5 && s6.reverse == 15 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 4 { assert(m.state.forward == 5 && m.state.reverse == 14 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 2 && m.end == 6 { assert(m.state.forward == 5 && m.state.reverse == 14 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 5 { assert(m.state.forward == 5 && m.state.reverse == 14 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 4 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 5 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 6 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'C', false);
        assert(s1.error.len == 0 && s1.forward == 5 && s1.reverse == 10 && s1.size == 5 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 5);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 7 && h.end == 8); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 6 && h.end == 7); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 5 && h.end == 6); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 5); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == false && h.start == 3 && h.end == 4); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 5 && s2.reverse == 12 && s2.size == 3 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 3);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 6 && h.end == 8); } }
        for h, k in h1.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 5 && h.end == 7); } }
        for h, k in h1.hits { if k == 2 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 6); } }
        let s3 = bio::fmd_extend(idx, s2, 'C', false);
        assert(s3.error.len == 0 && s3.forward == 5 && s3.reverse == 13 && s3.size == 2 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 2);
        for h, k in h2.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 5 && h.end == 8); } }
        for h, k in h2.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 7); } }
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 5 && s4.reverse == 14 && s4.size == 1 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 1);
        for h, k in h3.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 4 && h.end == 8); } }
        let s5 = bio::fmd_extend(idx, s4, 'C', false);
        assert(s5.error.len == 0 && s5.forward == 5 && s5.reverse == 15 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 5 && s6.reverse == 15 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "CCCCCC"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 4 { assert(m.state.forward == 5 && m.state.reverse == 14 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 2 && m.end == 6 { assert(m.state.forward == 5 && m.state.reverse == 14 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 5 { assert(m.state.forward == 5 && m.state.reverse == 14 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 4 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 5 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 6 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 2).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 3).matches.len == 3);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "CCCCCC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 3 && s2.reverse == 15 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 3 && s3.reverse == 17 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 3 && s4.reverse == 15 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 2 && m.state.reverse == 15 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 5 && m.state.reverse == 10 && m.state.size == 5); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 2 && m.state.reverse == 15 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 5 && m.state.reverse == 10 && m.state.size == 5); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'C', true);
        assert(s2.error.len == 0 && s2.forward == 3 && s2.reverse == 15 && s2.size == 0 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 0);
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 2 && s3.reverse == 15 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'C', true);
        assert(s4.error.len == 0 && s4.forward == 2 && s4.reverse == 15 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "ACAC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 1 { assert(m.state.forward == 2 && m.state.reverse == 15 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 1 && m.end == 2 { assert(m.state.forward == 5 && m.state.reverse == 10 && m.state.size == 5); } }
        for m in ms.matches { if m.start == 2 && m.end == 3 { assert(m.state.forward == 2 && m.state.reverse == 15 && m.state.size == 3); } }
        for m in ms.matches { if m.start == 3 && m.end == 4 { assert(m.state.forward == 5 && m.state.reverse == 10 && m.state.size == 5); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 1 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 2 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 3 { found2 = true; } } assert(found2);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 4 { found3 = true; } } assert(found3);
        assert(bio::fmd_smems(idx, "ACAC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 1).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "ACAC", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', true);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 5 && s1.size == 5 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 5);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 7 && h.end == 8); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 6 && h.end == 7); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 5 && h.end == 6); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == false && h.start == 4 && h.end == 5); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 11 && s2.reverse == 16 && s2.size == 1 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 1);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        let s3 = bio::fmd_extend(idx, s2, 'T', true);
        assert(s3.error.len == 0 && s3.forward == 12 && s3.reverse == 4 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 12 && s4.reverse == 16 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', true);
        assert(s5.error.len == 0 && s5.forward == 12 && s5.reverse == 4 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 12 && s6.reverse == 12 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 11 && m.state.reverse == 16 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 3 && m.state.reverse == 3 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 5 { assert(m.state.forward == 3 && m.state.reverse == 3 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 6 { assert(m.state.forward == 16 && m.state.reverse == 11 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 5 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 6 { found4 = true; } } assert(found4);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'G', false);
        assert(s1.error.len == 0 && s1.forward == 10 && s1.reverse == 5 && s1.size == 5 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 5);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == false && h.start == 7 && h.end == 8); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 3 && h.end == 4); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 6 && h.end == 7); } }
        for h, k in h0.hits { if k == 3 { assert(h.record == 0 && h.reverse == false && h.start == 5 && h.end == 6); } }
        for h, k in h0.hits { if k == 4 { assert(h.record == 0 && h.reverse == false && h.start == 4 && h.end == 5); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 11 && s2.reverse == 16 && s2.size == 1 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 1);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 4); } }
        let s3 = bio::fmd_extend(idx, s2, 'T', false);
        assert(s3.error.len == 0 && s3.forward == 17 && s3.reverse == 16 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 17 && s4.reverse == 17 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let s5 = bio::fmd_extend(idx, s4, 'T', false);
        assert(s5.error.len == 0 && s5.forward == 18 && s5.reverse == 17 && s5.size == 0 && s5.matched == 5);
        let h4 = bio::fmd_locate(idx, s5); assert(h4.error.len == 0 && h4.hits.len == 0);
        let s6 = bio::fmd_extend(idx, s5, 'C', true);
        assert(s6.error.len == 0 && s6.forward == 18 && s6.reverse == 15 && s6.size == 0 && s6.matched == 6);
        let h5 = bio::fmd_locate(idx, s6); assert(h5.error.len == 0 && h5.hits.len == 0);
        let ms = bio::fmd_smems(idx, "GATATC"); assert(ms.error.len == 0 && ms.matches.len == 4);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 11 && m.state.reverse == 16 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 3 && m.state.reverse == 3 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 3 && m.end == 5 { assert(m.state.forward == 3 && m.state.reverse == 3 && m.state.size == 2); } }
        for m in ms.matches { if m.start == 4 && m.end == 6 { assert(m.state.forward == 16 && m.state.reverse == 11 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found3: bool = false; for m in ms.matches { if m.start == 3 && m.end == 5 { found3 = true; } } assert(found3);
        var found4: bool = false; for m in ms.matches { if m.start == 4 && m.end == 6 { found4 = true; } } assert(found4);
        assert(bio::fmd_smems(idx, "GATATC", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "GATATC", 1, 2).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 3).matches.len == 1);
        assert(bio::fmd_smems(idx, "GATATC", 1, 4).matches.len == 2);
        assert(bio::fmd_smems(idx, "GATATC", 1, 5).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', true);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 2 && s2.reverse == 17 && s2.size == 1 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 1);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 3); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', true);
        assert(s3.error.len == 0 && s3.forward == 2 && s3.reverse == 18 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 2 && s4.reverse == 18 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    {
        let rs: bio::FMDRecord[>..] = [bio::FMDRecord { "0", "ATTCGGGG" }];
        let idx = bio::fmd_index(rs, "case", 3);
        assert(idx.error.len == 0);
        assert(idx.fm.sa[0] == 17);
        assert(idx.fm.sa[1] == 8);
        assert(idx.fm.sa[2] == 14);
        assert(idx.fm.sa[3] == 15);
        assert(idx.fm.sa[4] == 0);
        assert(idx.fm.sa[5] == 9);
        assert(idx.fm.sa[6] == 10);
        assert(idx.fm.sa[7] == 11);
        assert(idx.fm.sa[8] == 12);
        assert(idx.fm.sa[9] == 3);
        assert(idx.fm.sa[10] == 7);
        assert(idx.fm.sa[11] == 13);
        assert(idx.fm.sa[12] == 6);
        assert(idx.fm.sa[13] == 5);
        assert(idx.fm.sa[14] == 4);
        assert(idx.fm.sa[15] == 16);
        assert(idx.fm.sa[16] == 2);
        assert(idx.fm.sa[17] == 1);
        let s0 = bio::fmd_empty(idx);
        let s1 = bio::fmd_extend(idx, s0, 'A', false);
        assert(s1.error.len == 0 && s1.forward == 2 && s1.reverse == 15 && s1.size == 3 && s1.matched == 1);
        let h0 = bio::fmd_locate(idx, s1); assert(h0.error.len == 0 && h0.hits.len == 3);
        for h, k in h0.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 2 && h.end == 3); } }
        for h, k in h0.hits { if k == 1 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 2); } }
        for h, k in h0.hits { if k == 2 { assert(h.record == 0 && h.reverse == false && h.start == 0 && h.end == 1); } }
        let s2 = bio::fmd_extend(idx, s1, 'A', true);
        assert(s2.error.len == 0 && s2.forward == 2 && s2.reverse == 17 && s2.size == 1 && s2.matched == 2);
        let h1 = bio::fmd_locate(idx, s2); assert(h1.error.len == 0 && h1.hits.len == 1);
        for h, k in h1.hits { if k == 0 { assert(h.record == 0 && h.reverse == true && h.start == 1 && h.end == 3); } }
        let s3 = bio::fmd_extend(idx, s2, 'A', false);
        assert(s3.error.len == 0 && s3.forward == 2 && s3.reverse == 18 && s3.size == 0 && s3.matched == 3);
        let h2 = bio::fmd_locate(idx, s3); assert(h2.error.len == 0 && h2.hits.len == 0);
        let s4 = bio::fmd_extend(idx, s3, 'A', true);
        assert(s4.error.len == 0 && s4.forward == 2 && s4.reverse == 18 && s4.size == 0 && s4.matched == 4);
        let h3 = bio::fmd_locate(idx, s4); assert(h3.error.len == 0 && h3.hits.len == 0);
        let ms = bio::fmd_smems(idx, "AAAA"); assert(ms.error.len == 0 && ms.matches.len == 3);
        for m in ms.matches { if m.start == 0 && m.end == 2 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 2 && m.end == 4 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        for m in ms.matches { if m.start == 1 && m.end == 3 { assert(m.state.forward == 2 && m.state.reverse == 17 && m.state.size == 1); } }
        var found0: bool = false; for m in ms.matches { if m.start == 0 && m.end == 2 { found0 = true; } } assert(found0);
        var found1: bool = false; for m in ms.matches { if m.start == 1 && m.end == 3 { found1 = true; } } assert(found1);
        var found2: bool = false; for m in ms.matches { if m.start == 2 && m.end == 4 { found2 = true; } } assert(found2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 0).matches.len == 1);
        assert(bio::fmd_smems(idx, "AAAA", 1, 1).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 2).matches.len == 2);
        assert(bio::fmd_smems(idx, "AAAA", 1, 3).matches.len == 1);
    }
    print("FMD actual RustBio and literal checks pass");
}
