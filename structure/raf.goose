// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import .scop;
struct RafResidue { chain: u8[], id: u8[], atom: u8, seqres: u8 }
/* Uses a 38-byte header and seven-byte residues, versions 0.01/0.02. Letters uppercase and dots
 * become X. Each residue retains chain/original ID. Maps are borrowed and selections own copies.
 * Source attribution credits Crooks, Chang, and Finkelstein under Biopython/BSD. */
struct RafMap { pdb: u8[], chain: u8[], version: u8[], date: u8[], flags: u8[], residues: RafResidue[], error: u8[] }
struct RafSelection { map: RafMap, atom: u8[], seqres: u8[], error: u8[] }
fn raf_bad(s: u8[:]) -> RafMap { return RafMap { "", "", "", "", "", [], str(s) }; }
fn raf_letter(c: u8) -> u8 { if c == '.' { return 'X'; } if c >= 'a' && c <= 'z' { return c - 32; } return c; }
/*
Input caps at 64 MiB and one million residues. PDB/version/date must match when
combining; differing flags clear flags.
*/
fn parse_raf(text: u8[:]) -> RafMap {
    if text.len > 67108864 { return raf_bad("input limit"); } var s = text;
    while s.len > 0 && (s[s.len - 1] == '\n' || s[s.len - 1] == '\r') { s = s[..s.len - 1]; }
    if s.len < 38 || (s.len - 38) % 7 != 0 || (s.len - 38) / 7 > 1000000 { return raf_bad("truncated RAF or residue limit"); }
    if s[6..10] != "0.01" && s[6..10] != "0.02" { return raf_bad("RAF version"); }
    var residues: RafResidue[>..] = [];
    var i = 38; while i < s.len {
        let id = str(trim(s[i..i + 5]));
        if id.len == 0 { return raf_bad("empty RAF residue ID"); }
        let a = raf_letter(s[i + 5]); let b = raf_letter(s[i + 6]);
        if a < 'A' || a > 'Z' || b < 'A' || b > 'Z' { return raf_bad("invalid RAF letter"); }
        residues.push(RafResidue { str(s[4..5]), copy(id), a, b }); i += 7;
    }
    return RafMap { str(s[..4]), str(s[4..5]), str(s[6..10]), str(s[14..20]), str(s[21..27]), copy(residues), "" };
}
/*
Only single-chain maps with six flags serialize; mixed chains or cleared flags yield
empty text. Reserved header bytes become spaces.
*/
fn raf_write(m: const RafMap&) -> u8[] {
    if m.error.len > 0 || m.pdb.len != 4 || m.chain.len != 1 || m.version.len != 4 || m.date.len != 6 || m.flags.len != 6 || m.residues.len > 1000000 { return ""; }
    var out: u8[>..] = []; out.append(m.pdb); out.append(m.chain); out.push(' '); out.append(m.version); out.append("    "); out.append(m.date); out.push(' '); out.append(m.flags); out.append("           ");
    for r in m.residues { if r.chain != m.chain || r.id.len > 5 { return ""; } var i = r.id.len; while i < 5 { out.push(' '); i += 1; } out.append(r.id); out.push(r.atom); out.push(r.seqres); } out.push('\n'); return copy(out);
}
/*
First matching endpoints in RAF order are inclusive; repeated fragments retain
duplicates. Missing/reversed endpoints fail. Paired ATOM/SEQRES retain X positions.
Caps: one million output residues and ten million map/endpoint checks.
*/
fn raf_select(d: const ScopDomain&, maps: const RafMap[:]) -> RafSelection {
    var pdb:  u8[>..]            = []; var chain_out: u8[>..] = []; var version: u8[>..] = []; var date: u8[>..] = []; var flags: u8[>..] = []; var rows: RafResidue[>..] = []; var atom: u8[>..] = []; var seqres: u8[>..] = []; var first = true; var work = 0;
    var refs: const RafMap&[>..] = []; for m in maps { refs.push(m); }
    for f in d.fragments {
        let chain = if f.chain == "" || f.chain == " " || f.chain == "-" { "_" } else { f.chain }; var found = -1;
        for m, i in maps { work += 1; if work > 10000000 { return RafSelection { raf_bad(""), "", "", "work limit" }; } if m.pdb == d.pdb && m.chain == chain { if found >= 0 { return RafSelection { raf_bad(""), "", "", "duplicate RAF key" }; } found = i; } }
        if found < 0 { return RafSelection { raf_bad(""), "", "", "missing RAF chain" }; }
        let m = refs[found]; { if m.error.len > 0 { return RafSelection { raf_bad(""), "", "", "invalid RAF" }; }
            if first { pdb.append(m.pdb); chain_out.append(m.chain); version.append(m.version); date.append(m.date); flags.append(m.flags); first = false; } else {
                if pdb != m.pdb || version != m.version || date != m.date { return RafSelection { raf_bad(""), "", "", "incompatible RAF" }; }
                if flags != m.flags { flags.clear(); }
            }
            var start = if f.start.len == 0 { 0 } else { -1 }; var end = if f.end.len == 0 { m.residues.len - 1 } else { -1 };
            for r, i in m.residues { work += 1; if work > 10000000 { return RafSelection { raf_bad(""), "", "", "work limit" }; } if f.start.len > 0 && r.id == f.start && start < 0 { start = i; } if f.end.len > 0 && r.id == f.end && end < 0 { end = i; } }
            if start < 0 || end < start { return RafSelection { raf_bad(""), "", "", "missing or reversed endpoint" }; }
            if rows.len + end - start + 1 > 1000000 { return RafSelection { raf_bad(""), "", "", "output limit" }; }
            for r, ri in m.residues { if ri >= start && ri <= end { rows.push(copy(r)); atom.push(r.atom); seqres.push(r.seqres); } }
        } }
    return RafSelection { RafMap { copy(pdb), copy(chain_out), copy(version), copy(date), copy(flags), copy(rows), "" }, copy(atom), copy(seqres), "" };
}
