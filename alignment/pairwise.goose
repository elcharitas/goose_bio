namespace bio;

fn hamming_distance(a: const u8[:], b: const u8[:]) -> i64 {
    assert(a.len == b.len);
    var d: i64 = 0;
    for i in a.len { if a[i] != b[i] { d += 1; } }
    return d;
}

fn edit_distance(a: const u8[:], b: const u8[:]) -> i64 {
    var row: i64[>..] = [];
    for j in b.len + 1 { row.push(j); }
    for i in a.len {
        var diagonal = row[0];
        row[0] = i + 1;
        for j in b.len {
            let above = row[j + 1];
            var value = diagonal + (if a[i] == b[j] { 0 } else { 1 });
            if above + 1 < value { value = above + 1; }
            if row[j] + 1 < value { value = row[j] + 1; }
            row[j + 1] = value;
            diagonal = above;
        }
    }
    return row[b.len];
}

struct Alignment {
    score:     i64, a_start: i64, a_end: i64, b_start: i64, b_end: i64,
    a_aligned: u8[], b_aligned: u8[],
}

// A gap of length k costs open + (k - 1) * extend.
// Full score and traceback storage use O(a.len * b.len) space.
fn affine_alignment(a: const u8[:], b: const u8[:], match_score: i64 = 2,
    mismatch_score: i64 = -1, gap_open: i64 = 3,
    gap_extend: i64 = 1, local: bool = false) -> Alignment {
    assert(gap_open >= 0 && gap_extend >= 0);
    let score_bound: i64 = 288230376151711744 / (a.len + b.len + 1);
    assert(match_score >= -score_bound && match_score <= score_bound);
    assert(mismatch_score >= -score_bound && mismatch_score <= score_bound);
    assert(gap_open <= score_bound && gap_extend <= score_bound);
    let w = b.len + 1;
    let size = (a.len + 1) * w;
    let neg: i64 = -1152921504606846976;
    var scores: i64[>..] = [];
    var trace:  i64[>..] = [];
    for k in size * 3 { scores.push(neg); trace.push(-1); }
    scores[0] = 0;
    for i in 1..a.len + 1 {
        scores[(i * w) * 3 + 1] = if local { 0 } else { -gap_open - (i - 1) * gap_extend };
        trace[(i * w) * 3 + 1] = if i == 1 { 0 } else { 1 };
        if local { scores[(i * w) * 3] = 0; }
    }
    for j in 1..w {
        scores[j * 3 + 2] = if local { 0 } else { -gap_open - (j - 1) * gap_extend };
        trace[j * 3 + 2] = if j == 1 { 0 } else { 2 };
        if local { scores[j * 3] = 0; }
    }
    var best: i64 = 0;
    var bi:   i64 = 0; var bj: i64 = 0; var bs: i64 = 0;
    for i in 1..a.len + 1 {
        for j in 1..w {
            let cell = (i * w + j) * 3;
            for state in 3 {
                let previous = if state == 0 { ((i - 1) * w + j - 1) * 3 }
                    else if state == 1 { ((i - 1) * w + j) * 3 }
                    else { (i * w + j - 1) * 3 };
                var value = neg; var from: i64 = -1;
                for s in 3 {
                    let delta = if state == 0 { if a[i - 1] == b[j - 1] { match_score } else { mismatch_score } }
                        else { -(if s == state { gap_extend } else { gap_open }) };
                    if scores[previous + s] == neg { continue; }
                    let candidate = scores[previous + s] + delta;
                    if candidate > value { value = candidate; from = s; }
                }
                if local && value <= 0 { value = 0; from = -1; }
                scores[cell + state] = value; trace[cell + state] = from;
                if local && value > best { best = value; bi = i; bj = j; bs = state; }
            }
        }
    }
    if !local {
        bi = a.len; bj = b.len; best = neg;
        for s in 3 { if scores[(bi * w + bj) * 3 + s] > best {
            best = scores[(bi * w + bj) * 3 + s]; bs = s;
        } }
    }
    let ae = bi; let be = bj;
    var ar: u8[>..] = []; var br: u8[>..] = [];
    while bi > 0 || bj > 0 {
        let cell = (bi * w + bj) * 3 + bs;
        if local && scores[cell] <= 0 { break; }
        let from = trace[cell];
        if bs == 0 { ar.push(a[bi - 1]); br.push(b[bj - 1]); bi -= 1; bj -= 1; }
        else if bs == 1 { ar.push(a[bi - 1]); br.push('-'); bi -= 1; }
        else { ar.push('-'); br.push(b[bj - 1]); bj -= 1; }
        bs = from;
    }
    var aa: u8[>..] = []; var bb: u8[>..] = [];
    for k in ar.len { aa.push(ar[ar.len - 1 - k]); bb.push(br[br.len - 1 - k]); }
    return Alignment { best, bi, ae, bj, be, copy(aa), copy(bb) };
}
