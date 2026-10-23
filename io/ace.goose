// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import std;
import .alignment_io;

struct AceClip { start: i64, end: i64, usable: bool }
struct AceRead { name: u8[], sequence: u8[], info_items: i64, read_tags: i64, quality_clip: AceClip, alignment_clip: AceClip, has_ds: bool, ds: u8[] }
struct AcePlacement { name: u8[], orientation: u8[], padded_start: i64 }
struct AceSegment { padded_start: i64, padded_end: i64, name: u8[] }
struct AceContig { name: u8[], padded_bases: i64, declared_reads: i64, declared_segments: i64, orientation: u8[], consensus: u8[], qualities: i64[], placements: AcePlacement[], segments: AceSegment[], reads: AceRead[] }
// Body lines retain metadata/comment interleaving and delimiters.
struct AceTag { kind: u8[], header: u8[][], body: u8[][], contig_index: i64, read_index: i64 }
struct AceAssembly { declared_contigs: i64, declared_reads: i64, contigs: AceContig[], tags: AceTag[] }
struct AceResult { assembly: AceAssembly, error: u8[] }
struct AceCursor { lines: const u8[:][], position: i64 }
struct AceMaps { padded_to_unpadded: i64[], unpadded_to_padded: i64[] }
struct AceConsensus { sequence: u8[], qualities: i64[] }
struct AcePlacedBase { read_padded: i64, contig_padded: i64, contig_unpadded: i64, base: u8, in_contig: bool, quality_usable: bool, alignment_usable: bool }
struct AceInspection { bases: AcePlacedBase[], error: u8[] }
fn ace_fail(message: u8[:]) -> AceResult { return AceResult { AceAssembly { 0, 0, [], [] }, str(message) }; }
fn ace_skip(c: AceCursor&) { while c.position < c.lines.len && trim(c.lines[c.position]).len == 0 { c.position += 1; } }
fn ace_line(c: AceCursor&) -> u8[] { ace_skip(c); if c.position >= c.lines.len { return ""; } let s = str(trim(c.lines[c.position])); c.position += 1; return s; }
fn ace_number(s: u8[:]) -> i64 {
    if s.len == 0 || s.len > 10 { return -100000001; }
    var start = 0; if s[0] == '-' { start = 1; }
    if start == s.len { return -100000001; }
    for b in s[start..] { if b < '0' || b > '9' { return -100000001; } }
    let n, ok = parse_int(s); if !ok || n < -100000000 || n > 100000000 { return -100000001; } return n;
}
fn ace_orientation(s: u8[:]) -> bool { return s == "U" || s == "C"; }
fn ace_sequence(c: AceCursor&) -> u8[] {
    var out: u8[>..] = [];
    while c.position < c.lines.len {
        let s = trim(c.lines[c.position]); c.position += 1;
        if s.len == 0 { break; }
        for b in s {
            var ok = false; for a in "ACGTRYSWKMBDHVNXacgtryswkmbdhvnx*" { if a == b { ok = true; } }
            if !ok { return ""; }
        }
        out.append(s);
    }
    return copy(out);
}
fn ace_clip(a: i64, b: i64, length: i64) -> bool { return (a == -1 && b == -1) || (a == 0 && b == 0) || (a >= 1 && a <= b && b <= length); }
/*
ACE coordinates are one-based inclusive; AF starts may be zero/negative. Map indices are
zero-based, values one-based; padded-to-unpadded uses zero for pads.
*/
fn ace_coordinate_maps(sequence: u8[:]) -> AceMaps {
    var p: i64[>..] = []; var u: i64[>..] = []; var n = 0;
    for b, i in sequence { if b == '*' { p.push(0); } else { n += 1; p.push(n); u.push(i+1); } }
    return AceMaps { copy(p), copy(u) };
}
/*
Removes only stars and copies BQ in nonpad order. All-pad consensus yields empty
sequence and qualities.
*/
fn ace_unpadded_consensus(contig: AceContig) -> AceConsensus {
    var s: u8[>..] = []; for b in contig.consensus { if b != '*' { s.push(b); } }
    return AceConsensus { copy(s), copy(contig.qualities) };
}
/*
Returns each stored RD base, signed contig coordinate, overlap/map, and separate clip
memberships. C orientation is retained without reversing RD/clips: RD already uses
assembly orientation. Original instrument orientation is not inferred.
*/
/*
QA quality/alignment clips stay distinct; matching -1/-1 or 0/0 sentinels are unusable.
Reversed/mixed sentinels fail. AF must overlap; BS fits contig and named read placement;
usable alignment clips fit contig. Quality clips may extend beyond alignment clips.
*/
fn ace_inspect_placement(contig: AceContig, name: u8[:]) -> AceInspection {
    let maps = ace_coordinate_maps(contig.consensus);
    for af in contig.placements { if af.name == name { for r in contig.reads { if r.name == name {
        var bases: AcePlacedBase[>..] = [];
        for b, i in r.sequence {
            let p = af.padded_start+i; let inside = p >= 1 && p <= contig.consensus.len;
            bases.push(AcePlacedBase { i+1, p, if inside { maps.padded_to_unpadded[p-1] } else { 0 }, b, inside, r.quality_clip.usable && i+1 >= r.quality_clip.start && i+1 <= r.quality_clip.end, r.alignment_clip.usable && i+1 >= r.alignment_clip.start && i+1 <= r.alignment_clip.end });
        }
        return AceInspection { copy(bases), "" };
    } } } }
    return AceInspection { [], "unknown placement" };
}
/*
Global tags retain encounter order and resolved contig/read indices. CT/WA keep ordered
metadata and COMMENT delimiters; RT/WR may contain multiple entries. Header
dates/program/noTrans survive. COMMENT closes with exact C}; opaque text rejects braces.
Optional DS retains its complete ordered text without typed chromatogram metadata.
*/
fn ace_parse_tag(c: AceCursor&, line: u8[:], tags: AceTag[>..]&) -> u8[] {
    let kind = str(line[..2]); var closed = false; var comment = false;
    var header: u8[][>..] = []; var body: u8[][>..] = [];
    while c.position < c.lines.len {
        let raw = str(trim(c.lines[c.position])); c.position += 1;
        if comment {
            if raw == "}" || raw == "CT{" || raw == "RT{" || raw == "WR{" || raw == "WA{" || starts_with(raw, "COMMENT{") { return "unmatched comment"; }
            if raw != "C}" { for b in raw { if b == '{' || b == '}' { return "brace in comment text"; } } }
            body.push(copy(raw)); if raw == "C}" { comment = false; } continue;
        }
        if raw == "}" { closed = true; break; }
        if starts_with(raw, "COMMENT{") {
            for b in raw[8..] { if b == '{' || b == '}' { return "brace in comment text"; } }
            if header.len == 0 || kind == "WR" || kind == "WA" { return str("misplaced COMMENT"); }
            comment = true; body.push(copy(raw)); continue;
        }
        if raw.len == 0 { body.push(copy(raw)); continue; }
        for b in raw { if b == '{' || b == '}' { return "unknown nested structural block"; } }
        let h_tokens = alignment_words(raw); var h: u8[:][>..] = []; for token in h_tokens.fields { h.push(token); }
        if header.len == 0 { for token in h { header.push(str(token)); } }
        else if kind == "RT" || kind == "WR" {
            if tags.len >= 65536 { return "tag entry limit"; }
            tags.push(AceTag { copy(kind), copy(header), copy(body), -1, -1 }); header.clear(); for token in h { header.push(str(token)); } body.clear();
        } else { body.push(copy(raw)); }
    }
    if !closed || comment || header.len == 0 || tags.len >= 65536 { return str("truncated or empty tag"); }
    tags.push(AceTag { copy(kind), copy(header), copy(body), -1, -1 }); return "";
}
/*
Buffers one complete AS assembly; errors return an empty assembly. CO/AF/BS/RD retain
source order independently; AF need not match RD order. Validates declared totals,
lengths, BQ count, unique IDs, AF/RD equality, references, orientations, and bounds.
*/
/*
Zero contigs/reads, unknown structural records, nested tags, unmatched braces/comments,
missing QA, duplicate DS, truncation, and unresolved tags fail. BQ is 0-97; sequence is
case-preserved IUPAC DNA plus X/star, excluding U. Metadata is opaque text.
*/
/*
Limits: 16 MiB input, 64 KiB/line, 262144 lines, 4096 contigs, 65536 reads,
segments/contig, and tag entries, and one million padded bases/sequence. Numeric tokens
cap at ten bytes and absolute 100 million; AF starts are at least -1 million.
*/
/* Copies raise peak memory; duplicate/reference checks are quadratic. RD info/tag counts are
 * nonnegative declarations, not DS/global tag counts. Inspection/export require parser-valid
 * reconstructed structs. No writer, assembler, chromatogram reader, random- access index. */
fn parse_ace(text: u8[:]) -> AceResult {
    if text.len == 0 || text.len > 16777216 { return ace_fail("empty ACE or input exceeds 16 MiB"); }
    var lines: const u8[:][>..] = [];
    for s in split(text, '\n') {
        if s.len > 65536 || lines.len >= 262144 { return ace_fail("ACE line limit"); }
        for b in s { if (b < 32 && b != '\r' && b != '\t') || b > 126 { return ace_fail("non-text ACE"); } }
        lines.push(s);
    }
    var c = AceCursor { copy(lines), 0 };
    let assembly_header_tokens = alignment_words(ace_line(c)); var assembly_header: u8[:][>..] = []; for token in assembly_header_tokens.fields { assembly_header.push(token); }
    if assembly_header.len != 3 || assembly_header[0] != "AS" { return ace_fail("expected AS"); }
    let nc = ace_number(assembly_header[1]); let nr = ace_number(assembly_header[2]);
    if nc < 1 || nc > 4096 || nr < 1 || nr > 65536 { return ace_fail("invalid AS totals"); }
    var contigs: AceContig[>..] = []; var tags: AceTag[>..] = [];
    while true {
        ace_skip(c); if c.position == c.lines.len { break; }
        let line = ace_line(c); let w_tokens = alignment_words(line); var w: u8[:][>..] = []; for token in w_tokens.fields { w.push(token); }
        if line == "CT{" || line == "RT{" || line == "WR{" || line == "WA{" {
            let error = ace_parse_tag(c, line, tags); if error.len > 0 { return ace_fail(error); } continue;
        }
        if w.len != 6 || w[0] != "CO" || contigs.len >= nc { return ace_fail("expected CO or known tag"); }
        let nb = ace_number(w[2]); let reads = ace_number(w[3]); let segments = ace_number(w[4]);
        if nb < 1 || nb > 1000000 || reads < 1 || reads > nr || segments < 0 || segments > 65536 || !ace_orientation(w[5]) { return ace_fail("invalid CO"); }
        for x in contigs { if x.name == w[1] { return ace_fail("duplicate contig ID"); } }
        let seq = ace_sequence(c); if seq.len != nb { return ace_fail("CO sequence length"); }
        if ace_line(c) != "BQ" { return ace_fail("expected BQ"); }
        var qualities: i64[>..] = [];
        while c.position < c.lines.len {
            let s = trim(c.lines[c.position]); c.position += 1; if s.len == 0 { break; }
            for q in alignment_words(s).fields { let n = ace_number(q); if n < 0 || n > 97 { return ace_fail("invalid BQ quality"); } qualities.push(n); }
        }
        if qualities.len != ace_coordinate_maps(seq).unpadded_to_padded.len { return ace_fail("BQ cardinality"); }
        var af: AcePlacement[>..] = []; var bs: AceSegment[>..] = []; var rd: AceRead[>..] = [];
        for i in reads {
            let a_tokens = alignment_words(ace_line(c)); var a: u8[:][>..] = []; for token in a_tokens.fields { a.push(token); }
            if a.len != 4 || a[0] != "AF" || !ace_orientation(a[2]) { return ace_fail("expected AF"); }
            let start = ace_number(a[3]); if start < -1000000 || start > nb { return ace_fail("AF start bounds"); }
            for x in af { if x.name == a[1] { return ace_fail("duplicate AF ID"); } }
            af.push(AcePlacement { str(a[1]), str(a[2]), start });
        }
        for i in segments {
            let b_tokens = alignment_words(ace_line(c)); var b: u8[:][>..] = []; for token in b_tokens.fields { b.push(token); }
            if b.len != 4 || b[0] != "BS" { return ace_fail("expected BS"); }
            let a = ace_number(b[1]); let end = ace_number(b[2]); if a < 1 || end < a || end > nb { return ace_fail("BS bounds"); }
            bs.push(AceSegment { a, end, str(b[3]) });
        }
        // Resolve tag targets only after all contigs are available.
        for i in reads {
            while true {
                ace_skip(c); if c.position >= c.lines.len { break; }
                let next = trim(c.lines[c.position]);
                if next != "CT{" && next != "RT{" && next != "WR{" && next != "WA{" { break; }
                let tag_line = ace_line(c); let error = ace_parse_tag(c, tag_line, tags);
                if error.len > 0 { return ace_fail(error); }
            }
            let r_tokens = alignment_words(ace_line(c)); var r: u8[:][>..] = []; for token in r_tokens.fields { r.push(token); }
            if r.len != 5 || r[0] != "RD" { return ace_fail("expected RD"); }
            let length = ace_number(r[2]); let info = ace_number(r[3]); let nt = ace_number(r[4]);
            if length < 1 || length > 1000000 || info < 0 || nt < 0 { return ace_fail("invalid RD counts"); }
            for x in rd { if x.name == r[1] { return ace_fail("duplicate read ID"); } }
            for x in contigs { for y in x.reads { if y.name == r[1] { return ace_fail("duplicate read ID"); } } }
            let sequence = ace_sequence(c); if sequence.len != length { return ace_fail("RD sequence length"); }
            let q_tokens = alignment_words(ace_line(c)); var q: u8[:][>..] = []; for token in q_tokens.fields { q.push(token); }
            if q.len != 5 || q[0] != "QA" { return ace_fail("expected QA"); }
            let a = ace_number(q[1]); let b = ace_number(q[2]); let d = ace_number(q[3]); let e = ace_number(q[4]);
            if !ace_clip(a,b,length) || !ace_clip(d,e,length) { return ace_fail("invalid QA clipping"); }
            ace_skip(c); var ds: u8[>..] = []; var has_ds = false;
            if c.position < c.lines.len && starts_with(trim(c.lines[c.position]), "DS ") {
                let raw = format_line(c.lines[c.position]); var begin = 0;
                while begin < raw.len && (raw[begin] == ' ' || raw[begin] == '\t') { begin += 1; }
                ds.append(raw[begin+3..]); c.position += 1; has_ds = true;
            }
            rd.push(AceRead { str(r[1]), copy(sequence), info, nt, AceClip { a,b,a>0 }, AceClip { d,e,d>0 }, has_ds, copy(ds) });
        }
        for a in af {
            var found = false; for r in rd { if r.name == a.name {
                found = true;
                if a.padded_start+r.sequence.len-1 < 1 { return ace_fail("placement outside contig"); }
                if r.alignment_clip.usable && (a.padded_start+r.alignment_clip.start-1 < 1 || a.padded_start+r.alignment_clip.end-1 > nb) { return ace_fail("aligned clip outside contig"); }
            } }
            if !found { return ace_fail("unresolved AF"); }
        }
        for b in bs { var found = false; for a in af { if a.name == b.name { found = true; for r in rd { if r.name == a.name && (b.padded_start < a.padded_start || b.padded_end >= a.padded_start+r.sequence.len) { return ace_fail("BS outside read"); } } } } if !found { return ace_fail("unresolved BS"); } }
        contigs.push(AceContig { str(w[1]), nb, reads, segments, str(w[5]), copy(seq), copy(qualities), copy(af), copy(bs), copy(rd) });
    }
    var count = 0; for x in contigs { count += x.reads.len; }
    if contigs.len != nc || count != nr { return ace_fail("AS totals mismatch"); }
    var resolved: AceTag[>..] = [];
    for tag in tags {
        var h: u8[:][>..] = []; for token in tag.header { h.push(token); } var ci = -1; var ri = -1; var length = 0;
        if tag.kind == "WA" { if h.len != 3 { return ace_fail("invalid WA"); } }
        else {
            for x, i in contigs {
                if tag.kind == "CT" && x.name == h[0] { ci = i; length = x.padded_bases; }
                if tag.kind != "CT" { for r, j in x.reads { if r.name == h[0] { ci = i; ri = j; length = r.sequence.len; } } }
            }
            if ci < 0 { return ace_fail("unresolved tag target"); }
            if tag.kind == "WR" { if h.len != 4 { return ace_fail("invalid WR"); } }
            else {
                if h.len < 6 || h.len > (if tag.kind == "CT" { 7 } else { 6 }) { return ace_fail("invalid coordinate tag"); }
                let a = ace_number(h[3]); let b = ace_number(h[4]); if a < 1 || b < a || b > length { return ace_fail("tag bounds"); }
            }
        }
        resolved.push(AceTag { copy(tag.kind), copy(tag.header), copy(tag.body), ci, ri });
    }
    return AceResult { AceAssembly { nc, nr, copy(contigs), copy(resolved) }, "" };
}
