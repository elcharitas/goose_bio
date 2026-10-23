// Copyright (c) 2026 Jonathan Irhodia. MIT License.
namespace bio;
import .restriction_catalog;

/* The versioned catalog contains all 1,088 Bio 1.88 enzymes. Only known single double-strand cutters
 * execute; unknown and two-cut enzymes reject. Lookup constructs the full catalog. */
struct CatalogEnzyme { name: u8[], recognition: u8[], fst5: i64, fst3: i64, scd5: i64, scd3: i64, support: u8[] }

/* Zero-based boundaries: forward top=start+fst5, bottom=start+recognition length+fst3; reverse
 * top=start-fst3, bottom=start+recognition length-fst5. Linear hits require both cuts strictly
 * inside the molecule. */
struct CatalogCut { start: i64, strand: i64, top: i64, bottom: i64 }
struct CatalogSearch { cuts: CatalogCut[], error: u8[] }
struct CatalogDigest { fragments: u8[][], error: u8[] }

/* Marker start=top-fst5, including reverse hits. It can differ from the physical recognition start.
 * cuts_in and blocked_in contain zero-based row indexes. */
struct CapsMarker { enzyme: u8[], start: i64, cuts_in: i64[], blocked_in: i64[] }
struct CapsResult { markers: CapsMarker[], error: u8[] }
fn catalog_enzyme(name: u8[:]) -> CatalogEnzyme {
    for e in restriction_catalog() { if e.name == name { return copy(e); } }
    return CatalogEnzyme { "", "", 0, 0, 0, 0, "unknown" };
}
fn restriction_dna(text: u8[:]) -> bool {
    if text.len == 0 || text.len > 1048576 { return false; }
    for c in text { if c != 'A' && c != 'C' && c != 'G' && c != 'T' { return false; } }
    return true;
}

/* Circular search visits each recognition start once, including origin crossings; cuts use modulo
 * length. Motifs longer than the molecule have no hits. Limits: 1 MiB molecule, 256 enzymes, 16
 * million estimated scanning operations, and 1 million events. Validation and scan estimates precede
 * scan allocation; errors return empty collections. */
fn catalog_search(text: u8[:], name: u8[:], circular: bool = false) -> CatalogSearch {
    let e = catalog_enzyme(name);
    if e.support != "single" { return CatalogSearch { [], "unknown or unsupported enzyme" }; }
    if !restriction_dna(text) { return CatalogSearch { [], "concrete uppercase DNA required within bounds" }; }
    let m = e.recognition.len; let n = text.len;
    if n*m*2 > 16777216 { return CatalogSearch { [], "estimated work exceeds bound" }; }
    var hits: CatalogCut[>..] = [];
    if m > n { return CatalogSearch { [], "" }; }
    var rc: u8[>..] = [];
    for k in e.recognition.len {
        let c = e.recognition[e.recognition.len-1-k];
        rc.push(match c { 'A' => 'T', 'T' => 'A', 'C' => 'G', 'G' => 'C', 'R' => 'Y', 'Y' => 'R', 'M' => 'K', 'K' => 'M', 'B' => 'V', 'V' => 'B', 'D' => 'H', 'H' => 'D', _ => c });
    }
    for p in (if circular { n } else { n-m+1 }) {
        for side in (if rc == e.recognition { 1 } else { 2 }) {
            var motif: u8[>..] = [];
            if side == 0 { motif.append(e.recognition); } else { motif.append(rc); }
            var hit = true;
            for k in m {
                var found = false;
                let c = text[(p+k)%n];
                let mask = match motif[k] { 'A' => "A", 'C' => "C", 'G' => "G", 'T' => "T", 'R' => "AG", 'Y' => "CT", 'S' => "CG", 'W' => "AT", 'K' => "GT", 'M' => "AC", 'B' => "CGT", 'D' => "AGT", 'H' => "ACT", 'V' => "ACG", _ => "ACGT" };
                for b in mask { if b == c { found = true; } }
                if !found { hit = false; break; }
            }
            if !hit { continue; }
            var top = if side == 0 { p+e.fst5 } else { p-e.fst3 };
            var bottom = if side == 0 { p+m+e.fst3 } else { p+m-e.fst5 };
            if !circular && (top <= 0 || top >= n || bottom <= 0 || bottom >= n) { break; }
            if circular { top = ((top%n)+n)%n; bottom = ((bottom%n)+n)%n; }
            if hits.len >= 1048576 { return CatalogSearch { [], "event bound exceeded" }; }
            hits.push(CatalogCut { p, if side == 0 { 1 } else { -1 }, top, bottom });
            break;
        }
    }
    return CatalogSearch { copy(hits), "" };
}
fn restriction_copy(text: u8[:]) -> u8[] { var out: u8[>..] = []; out.append(text); return copy(out); }

/* Sorts and deduplicates top cuts. Fragments are the last-to-first bridge followed by ascending
 * intervals. Zero cuts return the original sequence; one returns a rotated sequence. Circular modulo
 * cuts give canonical length-preserving fragments even on short molecules. Sorting preflights at
 * most 16 million comparisons before position insertion and uses bounded insertion. */
fn catalog_digest(text: u8[:], name: u8[:], circular: bool = false) -> CatalogDigest {
    let result = catalog_search(text, name, circular);
    if result.error.len > 0 { return CatalogDigest { [], copy(result.error) }; }
    if result.cuts.len*result.cuts.len > 16777216 { return CatalogDigest { [], "estimated sorting work exceeds bound" }; }
    var positions: i64[>..] = [];
    for h in result.cuts {
        var at: i64 = 0;
        while at < positions.len && positions[at] < h.top { at += 1; }
        if at < positions.len && positions[at] == h.top { continue; }
        positions.push(h.top);
        var j = positions.len-1;
        while j > at { positions[j] = positions[j-1]; j -= 1; }
        positions[at] = h.top;
    }
    if positions.len == 0 { return CatalogDigest { [restriction_copy(text)], "" }; }
    var fragments: u8[][>..] = [];
    if circular {
        var bridge: u8[>..] = [];
        bridge.append(text[positions[positions.len-1]..text.len]);
        bridge.append(text[0..positions[0]]); fragments.push(copy(bridge));
    } else { fragments.push(restriction_copy(text[0..positions[0]])); }
    for i in 1..positions.len { fragments.push(restriction_copy(text[positions[i-1]..positions[i]])); }
    if !circular { fragments.push(restriction_copy(text[positions[positions.len-1]..text.len])); }
    return CatalogDigest { copy(fragments), "" };
}

/* Requires equal-length, ungapped, uppercase concrete DNA rows. Limits: 1,024 rows and 16 million
 * cells. Results buffer events and fragments. No methylation, sticky-end assembly, gapped CAPS,
 * ambiguous DNA,. */
fn catalog_caps(rows: u8[][], names: u8[][]) -> CapsResult {
    if rows.len == 0 || rows.len > 1024 || names.len > 256 { return CapsResult { [], "CAPS bounds exceeded" }; }
    var n: i64 = 0; for row in rows { n = row.len; break; }
    if n > 16777216/rows.len { return CapsResult { [], "cell bound exceeded" }; }
    var work: i64 = 0;
    for name in names {
        let e = catalog_enzyme(name);
        if e.support != "single" { return CapsResult { [], "unknown or unsupported enzyme" }; }
        work += n*rows.len*e.recognition.len*2;
        if work > 16777216 { return CapsResult { [], "estimated work exceeds bound" }; }
    }
    for row in rows { if row.len != n || !restriction_dna(row) { return CapsResult { [], "equal ungapped concrete DNA rows required" }; } }
    var markers: CapsMarker[>..] = []; var events: i64 = 0;
    for name in names {
        let e = catalog_enzyme(name);
        var cuts: i64[][>..] = []; var starts: i64[>..] = [];
        var enzyme_events: i64 = 0;
        for row in rows {
            let r = catalog_search(row, name);
            if r.error.len > 0 { return CapsResult { [], copy(r.error) }; }
            enzyme_events += r.cuts.len;
            if enzyme_events*enzyme_events > 16777216 { return CapsResult { [], "estimated sorting work exceeds bound" }; }
            var values: i64[>..] = [];
            for h in r.cuts {
                events += 1;
                if events > 1048576 { return CapsResult { [], "event bound exceeded" }; }
                let s = h.top-e.fst5;
                values.push(s);
                var at: i64 = 0;
                while at < starts.len && starts[at] < s { at += 1; }
                if at == starts.len || starts[at] != s {
                    starts.push(s); var j = starts.len-1;
                    while j > at { starts[j] = starts[j-1]; j -= 1; }
                    starts[at] = s;
                }
            }
            cuts.push(copy(values));
        }
        for s in starts {
            var yes: i64[>..] = []; var no: i64[>..] = [];
            for values, i in cuts {
                var found = false; for v in values { if v == s { found = true; } }
                if found { yes.push(i); } else { no.push(i); }
            }
            if yes.len > 0 && no.len > 0 { markers.push(CapsMarker { copy(name), s, copy(yes), copy(no) }); }
        }
    }
    return CapsResult { copy(markers), "" };
}
