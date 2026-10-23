// Copyright (c) 2026 Jonathan Irhodia. MIT license.
namespace bio;
import .fmindex;

/* Names are unique, nonempty, at most 1024 bytes, and contain no zero byte. Empty sequences are valid.
 * Only uppercase ACGTN is accepted; N matches literally. No lowercase normalization, other ambiguity
 * symbols, or input separators. */
struct FMDRecord { name: u8[], sequence: u8[] }

/* Stores BWT, full SA, 256 cumulative counts, rank checkpoints, ordered metadata, and serialized
 * ownership. This is buffered indexing, without succinct construction or sampled LF locate across
 * repeated separators. */
struct FMDIndex { fm: FMIndex, names: u8[][], starts: i64[], lengths: i64[], owner: u8[], error: u8[] }

/* Forward and reverse-complement intervals are half-open SA row ranges with a common width and matched
 * length. Each state copies the ownership serialization, which can be costly with many states.
 * Returned states and index fields must remain unmodified; they are not tamper-proof capabilities. */
struct FMDState { forward: i64, reverse: i64, size: i64, matched: i64, owner: u8[], error: u8[] }

/* Coordinates refer to the original record and are half-open. Reverse offset r for a match of length k
 * maps to [L-r-k,L-r). Nonempty hits never contain or cross separators. */
struct FMDHit { record: i64, reverse: bool, start: i64, end: i64 }

/* Hits retain forward-interval SA order. Empty queries have no biological hits; boundaries contains
 * all record boundaries on both strands, including empty records, in record, coordinate, strand order.
 * Separator suffixes are excluded. */
struct FMDLocations { hits: FMDHit[], boundaries: FMDHit[], error: u8[] }
struct FMDSMEM { start: i64, end: i64, state: FMDState }

struct FMDSMEMs { matches: FMDSMEM[], error: u8[] }
fn fmd_base(c: u8) -> bool { return c == 'A' || c == 'C' || c == 'G' || c == 'T' || c == 'N'; }
fn fmd_complement(c: u8) -> u8 {
    if c == 'A' { return 'T'; } if c == 'T' { return 'A'; }
    if c == 'C' { return 'G'; } if c == 'G' { return 'C'; } return c;
}
fn fmd_fail(e: u8[]) -> FMDIndex { return FMDIndex { FMIndex { [],[],[],[],0,0,"invalid collection" },[],[],[],[],copy(e) }; }

/* Builds T1$RC(T1)$T2$RC(T2)$... in record order. Accepts 1..1024 records and at most 1,000,000 input
 * bases. The caller supplies a unique nonempty key of at most 1024 bytes without zero bytes. Ownership
 * compares the key and ordered names and sequences exactly: equal contents and key denote one logical
 * collection even across separate instances. Bounds or alphabet errors return no partial arrays and
 * leave inputs unchanged. */
fn fmd_index(records: const FMDRecord[:], key: const u8[:], stride: i64 = 128) -> FMDIndex {
    if records.len == 0 || records.len > 1024 || key.len == 0 || key.len > 1024 { return fmd_fail("collection bounds"); }
    /* Stride defaults to 128 and must be 1..1,048,576. Construction preflights at most 8,388,608
     * checkpoint i64 values (64 MiB); other arrays need additional memory. Prefix doubling uses O(n
     * log-squared n) time and O(n) workspace, where n is twice the bases plus twice the records. */
    if stride <= 0 || stride > 1048576 { return fmd_fail("stride bounds"); }
    for c in key { if c == 0 { return fmd_fail("invalid collection key"); } }
    var bases: i64 = 0;
    for r,i in records {
        if r.name.len == 0 || r.name.len > 1024 { return fmd_fail("name bounds"); }
        for c in r.name { if c == 0 { return fmd_fail("invalid record name"); } }
        for prev,j in records { if j < i && r.name == prev.name { return fmd_fail("duplicate record name"); } }
        if r.sequence.len > 1000000 - bases { return fmd_fail("base limit"); }
        bases += r.sequence.len;
        for c in r.sequence { if !fmd_base(c) { return fmd_fail("expected uppercase ACGTN"); } }
    }
    let n = 2*bases + 2*records.len;
    if (n/stride+1)*256 > 8388608 { return fmd_fail("checkpoint memory limit"); }
    var text: u8[>..] = []; var names: u8[][>..] = [];
    var starts: i64[>..] = []; var lengths: i64[>..] = [];
    var owner: u8[>..] = []; owner.append(key); owner.push(0);
    for r in records {
        names.push(copy(r.name)); starts.push(text.len); lengths.push(r.sequence.len);
        text.append(r.sequence); text.push('$');
        for j in r.sequence.len { text.push(fmd_complement(r.sequence[r.sequence.len-1-j])); }
        text.push('$'); owner.append(r.name); owner.push(0); owner.append(r.sequence); owner.push(0);
    }
    let sa = fmd_suffix_array(text);
    var bwt: u8[>..] = []; var counts: i64[>..] = []; var less: i64[>..] = []; var cp: i64[>..] = [];
    for i in 256 { counts.push(0); less.push(0); }
    for p in sa { bwt.push(text[if p == 0 { text.len-1 } else { p-1 }]); }
    for i in n+1 {
        if i%stride == 0 { for v in counts { cp.push(v); } }
        if i < n { counts[bwt[i]] += 1; }
    }
    var sum: i64 = 0; for i in 256 { less[i] = sum; sum += counts[i]; }
    return FMDIndex { FMIndex { copy(bwt),sa,copy(less),copy(cp),stride,n,"" },copy(names),copy(starts),copy(lengths),copy(owner),"" };
}
fn fmd_bad(e: u8[]) -> FMDState { return FMDState { 0,0,0,0,[],copy(e) }; }

/* The empty state spans the entire collection SA. Empty intervals remain extendable; extension history
 * determines their insertion points. */
fn fmd_empty(index: const FMDIndex&) -> FMDState {
    if index.error.len > 0 { return fmd_bad(copy(index.error)); }
    return FMDState { 0,0,index.fm.bwt.len,0,copy(index.owner),"" };
}

/* Different ownership keys or serialized contents reject foreign states. Logical collection identity
 * does not provide object-instance identity. */
fn fmd_valid(index: const FMDIndex&, s: const FMDState&) -> bool {
    let n = index.fm.bwt.len;
    if s.matched == 0 && (s.forward != 0 || s.reverse != 0 || s.size != n) { return false; }
    return index.error.len == 0 && s.error.len == 0 && s.owner == index.owner && s.matched >= 0 && s.matched <= 1000000 && s.size >= 0 && s.size <= n && s.forward >= 0 && s.reverse >= 0 && s.forward <= n-s.size && s.reverse <= n-s.size;
}

/* Backward extension is the default. right=true complements, swaps, extends backward, then swaps
 * back. Reverse-complement alphabet order is $TGCNAtgcna. Errors do not mutate the supplied state. */
fn fmd_extend(index: const FMDIndex&, s: const FMDState&, c: u8, right: bool = false) -> FMDState {
    if !fmd_valid(index,s) { return fmd_bad("foreign or invalid state"); }
    if !fmd_base(c) || s.matched == 1000000 { return fmd_bad("alphabet or match length limit"); }
    let a = if right { fmd_complement(c) } else { c };
    let lower = if right { s.reverse } else { s.forward };
    var rev = if right { s.forward } else { s.reverse };
    var width: i64 = 0; var before: i64 = 0;
    for b in "$TGCNAtgcna" {
        before = fm_rank(index.fm,b,lower);
        width = fm_rank(index.fm,b,lower+s.size)-before;
        if b == a { break; } rev += width;
    }
    let fwd = index.fm.cumulative[a]+before;
    return FMDState { if right { rev } else { fwd },if right { fwd } else { rev },width,s.matched+1,copy(index.owner),"" };
}
fn fmd_last(states: const FMDState[:]) -> FMDState {
    for s,i in states { if i == states.len-1 { return copy(s); } } return fmd_bad("empty state container");
}

/* Queries accept at most 1,000,000 bases and query_length * (owner_bytes + 11*stride) <= 32,000,000.
 * This conservative estimate bounds loops and copying, not elapsed time. */
fn fmd_search(index: const FMDIndex&, query: const u8[:]) -> FMDState {
    if query.len > 1000000 || query.len*(index.owner.len+index.fm.stride*11) > 32000000 { return fmd_bad("query length limit"); }
    var states: FMDState[>..] = [fmd_empty(index)];
    for c in query { let prev = fmd_last(states); let next = fmd_extend(index,prev,c,true); states.clear(); states.push(copy(next)); }
    return fmd_last(states);
}

/* Nonempty locate requires width * record_count * 2 <= 32,000,000 before producing hits. Invalid
 * ownership, intervals, or work estimates return empty error results. */
fn fmd_locate(index: const FMDIndex&, s: const FMDState&) -> FMDLocations {
    if !fmd_valid(index,s) { return FMDLocations { [],[],"foreign or invalid state" }; }
    if s.matched > 0 && s.size*index.lengths.len*2 > 32000000 { return FMDLocations { [],[],"locate work limit" }; }
    var hits: FMDHit[>..] = []; var boundaries: FMDHit[>..] = [];
    if s.matched == 0 {
        for len,i in index.lengths { for p in len+1 { boundaries.push(FMDHit { i,false,p,p }); boundaries.push(FMDHit { i,true,p,p }); } }
        return FMDLocations { [],copy(boundaries),"" };
    }
    for row in s.forward..s.forward+s.size {
        let p = index.fm.sa[row];
        for start,i in index.starts {
            let len = index.lengths[i];
            for strand in 2 {
                let offset = p-start-strand*(len+1);
                if offset >= 0 && offset <= len-s.matched {
                    let a = if strand == 0 { offset } else { len-offset-s.matched };
                    hits.push(FMDHit { i,strand == 1,a,a+s.matched });
                }
            }
        }
    }
    return FMDLocations { copy(hits),[],"" };
}
/* Exhaustive substring extension tests both ends for maximality, then removes contained matches.
 * Configured work limits bound this exhaustive SMEM search. */

/* Returns all SMEMs in query-start order. minimum defaults to 1 and is positive and inclusive;
 * anchor=-1 selects all, otherwise it is a zero-based query position. Empty all-SMEM queries return an
 * empty set; an anchor into an empty query is invalid. Query length is at most 128, and
 * 4*query_length^2*(owner_bytes+11*stride) must not exceed 32,000,000. Invalid arguments and work
 * limits return empty results atomically. */
fn fmd_smems(index: const FMDIndex&, query: const u8[:], minimum: i64 = 1, anchor: i64 = -1) -> FMDSMEMs {
    if index.error.len > 0 || minimum < 1 || query.len > 128 || anchor < -1 || anchor >= query.len { return FMDSMEMs { [],"SMEM bounds" }; }
    for c in query { if !fmd_base(c) { return FMDSMEMs { [],"alphabet" }; } }
    if 4*query.len*query.len*(index.owner.len+index.fm.stride*11) > 32000000 { return FMDSMEMs { [],"SMEM work limit" }; }
    var candidates: FMDSMEM[>..] = [];
    for a in query.len {
        var states: FMDState[>..] = [fmd_empty(index)];
        for b in a..query.len {
            let prev = fmd_last(states); let s = fmd_extend(index,prev,query[b],true);
            states.clear(); states.push(copy(s));
            if s.size == 0 { break; }
            if b-a+1 < minimum { continue; }
            let left = if a == 0 { false } else { fmd_extend(index,s,query[a-1]).size > 0 };
            let right = if b+1 == query.len { false } else { fmd_extend(index,s,query[b+1],true).size > 0 };
            if !left && !right { candidates.push(FMDSMEM { a,b+1,copy(s) }); }
        }
    }
    var result: FMDSMEM[>..] = [];
    for m in candidates {
        var contained = false;
        for other in candidates { if other.start <= m.start && other.end >= m.end && other.end-other.start > m.end-m.start { contained = true; } }
        if !contained && (anchor == -1 || (m.start <= anchor && anchor < m.end)) { result.push(copy(m)); }
    }
    return FMDSMEMs { copy(result),"" };
}

/* Successive separators receive distinct descending initial ranks. Prefix doubling reuses the
 * existing comparison and merge-sort method without changing the ordinary suffix-array function.
 * Repeated separators can change order relative to byte suffix sorting, including equal biological
 * suffixes. */
fn fmd_suffix_array(text: const u8[:]) -> i64[] {
    var sa: i64[>..] = []; var ranks: i64[>..] = [];
    var tmp: i64[>..] = []; var next: i64[>..] = [];
    var sentinels: i64 = 0; for c in text { if c == '$' { sentinels += 1; } }
    var remaining = sentinels;
    for c,i in text {
        sa.push(i); tmp.push(0); next.push(0);
        if c == '$' { remaining -= 1; ranks.push(remaining); }
        else { ranks.push(sentinels+c); }
    }
    var k: i64 = 1;
    while k < text.len {
        var width: i64 = 1;
        while width < text.len {
            var left: i64 = 0;
            while left < text.len {
                let mid = if left + width < text.len { left + width } else { text.len };
                let end = if mid + width < text.len { mid + width } else { text.len };
                var a = left; var b = mid; var out = left;
                while a < mid || b < end {
                    if b == end || (a < mid && fm_pair_less(sa[a], sa[b], ranks, k)) {
                        tmp[out] = sa[a]; a += 1;
                    } else { tmp[out] = sa[b]; b += 1; }
                    out += 1;
                }
                left = end;
            }
            for i in text.len { sa[i] = tmp[i]; }
            width *= 2;
        }
        var rank: i64 = 0; next[sa[0]] = 0;
        for i in 1..text.len {
            if fm_pair_less(sa[i - 1], sa[i], ranks, k) { rank += 1; }
            next[sa[i]] = rank;
        }
        for i in text.len { ranks[i] = next[i]; }
        if rank == text.len - 1 { break; }
        k *= 2;
    }
    return copy(sa);
}
