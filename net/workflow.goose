// Copyright (c) 2026 Jonathan Irhodia. MIT license.
namespace bio_http;
fn workflow_link_value(value: u8[:]) -> u8[], bool {
    var found: u8[>..] = [];
    var i = 0;
    while i < value.len {
        while i < value.len && space(value[i]) { i += 1; }
        if i == value.len || value[i] != '<' { return "", false; }
        i += 1;
        let target = i;
        while i < value.len && value[i] != '>' { i += 1; }
        if i == value.len { return "", false; }
        let end = i;
        if target == end { return "", false; }
        for c in value[target..end] { if c <= 32 || c == '<' || c == '\\' { return "", false; } }
        i += 1;
        var next = false;
        var seen_rel = false;
        while i < value.len {
            while i < value.len && space(value[i]) { i += 1; }
            if i == value.len || value[i] == ',' { break; }
            if value[i] != ';' { return "", false; }
            i += 1;
            while i < value.len && space(value[i]) { i += 1; }
            let name = i;
            while i < value.len && !space(value[i]) && value[i] != '=' && value[i] != ';' && value[i] != ',' { i += 1; }
            let name_end = i;
            if name == name_end { return "", false; }
            for c in value[name..name_end] { if !workflow_token(c) { return "", false; } }
            while i < value.len && space(value[i]) { i += 1; }
            if i == value.len || value[i] != '=' { return "", false; }
            i += 1;
            while i < value.len && space(value[i]) { i += 1; }
            if i == value.len { return "", false; }
            var quoted = false;
            if value[i] == '"' { quoted = true; i += 1; }
            let start = i;
            if quoted {
                while i < value.len && value[i] != '"' {
                    // Quoted pairs are deliberately unsupported.
                    if value[i] == '\\' { return "", false; }
                    i += 1;
                }
                if i == value.len { return "", false; }
            } else {
                while i < value.len && !space(value[i]) && value[i] != ';' && value[i] != ',' { i += 1; }
            }
            if start == i { return "", false; }
            for c in value[start..i] {
                if c < 32 || c == 127 || (!quoted && !workflow_token(c)) { return "", false; }
            }
            if ascii_equal(value[name..name_end], "rel") {
                if seen_rel { return "", false; }
                seen_rel = true;
                next = next_relation(value[start..i]);
            }
            if quoted { i += 1; }
        }
        if next {
            var out: u8[>..] = [];
            for c in value[target..end] { out.push(c); }
            if found.len > 0 || out.len == 0 { return "", false; }
            found.append(out);
        }
        if i < value.len { i += 1; if i == value.len { return "", false; } }
    }
    return json_bytes(found), value.len > 0;
}

extern fn workflow_now() -> i64 = "bio_workflow_now";
extern fn workflow_sleep(ms: i64) = "bio_workflow_sleep";
extern fn workflow_url(base: const u8[:], current: const u8[:], target: const u8[:], out: u8[>..]&) -> i32 = "bio_workflow_url";
struct UniProtLimits {
    pages:       i64, entries: i64, requests: i64, bytes: i64,
    deadline_ms: i64, interval_ms: i64, retries: i64,
}
struct UniProtAttempt { url: u8[], started_ms: i64, response: GooseHttpResult }
struct UniProtWorkflowData {
    records: UniProtEntry[], attempts: UniProtAttempt[], reason: u8[],
    url:     u8[], accessions: u8[][], visited: u8[][],
}
struct UniProtWorkflow {
    complete: bool, done: bool, base: u8[], limits: UniProtLimits,
    deadline: i64, ready: i64, last: i64, pages: i64, bytes: i64,
    retry:    i64, fetch: i64, pending: bool, started: i64,
    data:     UniProtWorkflowData[>..],
}
fn workflow_data(w: UniProtWorkflow&) -> UniProtWorkflowData {
    for d in w.data { return copy(d); }
    return UniProtWorkflowData { [], [], "", "", [], [] };
}
fn workflow_stop(w: UniProtWorkflow&, reason: u8[:]) {
    w.done = true; w.complete = false; w.pending = false; workflow_replace(w, 0, json_bytes(reason), "", [], [], []);
}
fn workflow_check_time(w: UniProtWorkflow&, now: i64) -> bool {
    if now < 0 || now < w.last { workflow_stop(w, "monotonic clock failure"); return false; }
    w.last = now;
    if now >= w.deadline { workflow_stop(w, "deadline"); return false; }
    return true;
}
fn workflow_begin(query: u8[:], base: u8[:], limits: UniProtLimits, now: i64) -> UniProtWorkflow {
    var w = UniProtWorkflow { false, false, json_bytes(base), limits, now, now, now,
        0, 0, 0, -1, false, now, [] };
    w.data.push(UniProtWorkflowData { [], [], "", uniprot_search(query, base), [], [] });
    if now < 0 || now > 9223372036854475807 || query.len == 0 || query.len > 65536 ||
        limits.pages < 1 || limits.pages > 1000 || limits.entries < 1 || limits.entries > 10000 ||
        limits.requests < 1 || limits.requests > 30000 || limits.bytes < 1 || limits.bytes > 67108864 ||
        limits.deadline_ms < 1 || limits.deadline_ms > 300000 ||
        limits.interval_ms < 0 || limits.interval_ms > 300000 || limits.retries < 0 || limits.retries > 2 {
        workflow_stop(w, "invalid configuration"); return w;
    }
    w.deadline = now + limits.deadline_ms;
    var normalized: u8[>..] = [];
    if workflow_url(base, workflow_data(w).url, workflow_data(w).url, normalized) != 1 ||
        !(base.len >= 7) {
        workflow_stop(w, "invalid origin"); return w;
    }
    // Require an origin, without a path, query, or credentials.
    var slashes = 0;
    for c in base {
        if c == '/' { slashes += 1; }
        if c == '@' || c == '?' || c == '#' || c <= 32 { workflow_stop(w, "invalid origin"); }
    }
    if slashes != 2 { workflow_stop(w, "invalid origin"); }
    workflow_replace(w, 1, "", copy(normalized), [], [], []);
    return w;
}
// Returns the final block field; repeated fields are rejected.
fn workflow_header(headers: u8[:], name: u8[:]) -> u8[], bool, bool {
    var value: u8[>..] = [];
    var present = false;
    var valid = true;
    var i = 0;
    while i < headers.len {
        let start = i;
        while i < headers.len && headers[i] != '\r' && headers[i] != '\n' { i += 1; }
        let line = headers[start..i];
        if line.len >= 5 && line[0..5] == "HTTP/" { present = false; valid = true; value.clear(); }
        if line.len > 0 && space(line[0]) { valid = false; }
        if line.len >= name.len + 1 && ascii_equal(line[0..name.len], name) && line[name.len] == ':' {
            if present { valid = false; }
            present = true;
            var a = name.len + 1;
            var b = line.len;
            while a < b && space(line[a]) { a += 1; }
            while b > a && space(line[b - 1]) { b -= 1; }
            value.clear(); value.append(line[a..b]);
        }
        while i < headers.len && (headers[i] == '\r' || headers[i] == '\n') { i += 1; }
    }
    return json_bytes(value), present, valid;
}
fn workflow_accession(s: u8[:]) -> bool {
    if s.len == 0 || s.len > 32 { return false; }
    for c in s { if !((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-') { return false; } }
    return true;
}
// Call at ready or later; true authorizes exactly one bounded GET.
fn workflow_request(w: UniProtWorkflow&, now: i64) -> bool {
    if w.done { return false; }
    if now < w.last || w.pending { workflow_stop(w, "invalid scheduler state"); return false; }
    w.last = now;
    if now >= w.deadline { workflow_stop(w, "deadline"); return false; }
    if workflow_data(w).attempts.len >= w.limits.requests { workflow_stop(w, "request limit"); return false; }
    if w.bytes >= w.limits.bytes { workflow_stop(w, "byte limit"); return false; }
    if now < w.ready { return false; }
    w.pending = true; w.started = now;
    return true;
}
fn workflow_accept(w: UniProtWorkflow&, response: GooseHttpResult, now: i64, clocked: bool = false) {
    if w.done { return; }
    if !w.pending || now < w.last { workflow_stop(w, "invalid scheduler state"); return; }
    w.pending = false; w.last = now;
    var attempts: UniProtAttempt[>..] = [];
    attempts.append(workflow_data(w).attempts);
    attempts.push(UniProtAttempt { copy(workflow_data(w).url), w.started, copy(response) });
    workflow_replace(w, 5, "", "", [], [], copy(attempts));
    let size = response.body.len + response.headers.len;
    w.bytes += size;
    if w.bytes > w.limits.bytes { workflow_stop(w, "byte limit"); return; }
    if now >= w.deadline { workflow_stop(w, "deadline"); return; }
    w.ready = if w.limits.interval_ms >= w.deadline - w.started { w.deadline } else { w.started + w.limits.interval_ms };
    let transient = response.code != 0 || response.error.len > 0 || response.status == 429 ||
        response.status == 500 || response.status == 502 || response.status == 503 || response.status == 504;
    if response.code == 23 { workflow_stop(w, "response byte or header limit"); return; }
    if transient {
        if w.retry >= w.limits.retries { workflow_stop(w, "retry exhaustion"); return; }
        let delay, present, valid = workflow_header(response.headers, "retry-after");
        if !valid { workflow_stop(w, "malformed Retry-After"); return; }
        if present {
            let count = decimal_count(delay);
            if count.state != 2 { workflow_stop(w, "malformed Retry-After"); return; }
            if count.value > (w.deadline - now) / 1000 { workflow_stop(w, "deadline"); return; }
            let retry_at = now + count.value * 1000;
            if retry_at > w.ready { w.ready = retry_at; }
        }
        if w.ready >= w.deadline { workflow_stop(w, "deadline"); return; }
        w.retry += 1; return;
    }
    w.retry = 0;
    let parsed = uniprot_response(copy(response), w.fetch < 0);
    if clocked && !workflow_check_time(w, workflow_now()) { return; }
    if parsed.error.len > 0 { workflow_stop(w, parsed.error); return; }
    if w.fetch >= 0 {
        for e in parsed.entries {
            if clocked && !workflow_check_time(w, workflow_now()) { return; }
            var expected: u8[>..] = [];
            for a, i in workflow_data(w).accessions { if i == w.fetch { expected.append(a); } }
            if e.accession.value != expected || e.sequence.state != 2 || e.length.state != 2 || e.sequence.value.len == 0 {
                workflow_stop(w, "fetched accession or sequence mismatch"); return;
            }
            for c, index in e.sequence.value {
                if clocked && index % 1024 == 0 && !workflow_check_time(w, workflow_now()) { return; }
                if c < 'A' || c > 'Z' { workflow_stop(w, "invalid sequence residue"); return; }
            }
            var records: UniProtEntry[>..] = []; records.append(workflow_data(w).records); records.push(copy(e)); workflow_replace(w, 4, "", "", [], copy(records), []);
        }
        w.fetch += 1;
    } else {
        w.pages += 1;
        var ids: u8[][>..] = []; ids.append(workflow_data(w).accessions);
        for e in parsed.entries {
            if clocked && !workflow_check_time(w, workflow_now()) { return; }
            if !workflow_accession(e.accession.value) { workflow_stop(w, "invalid accession"); return; }
            var seen = false;
            for a in ids { if a == e.accession.value { seen = true; } }
            if !seen {
                if ids.len >= w.limits.entries { workflow_replace(w, 2, "", "", copy(ids), [], []); workflow_stop(w, "entry limit"); return; }
                ids.push(copy(e.accession.value));
            }
        }
        workflow_replace(w, 2, "", "", copy(ids), [], []);
        var visited: u8[][>..] = []; visited.append(workflow_data(w).visited); visited.push(copy(workflow_data(w).url)); workflow_replace(w, 3, "", "", copy(visited), [], []);
        let link, present, valid = workflow_header(response.headers, "link");
        if !valid { workflow_stop(w, "malformed Link"); return; }
        if present {
            let target, good = workflow_link_value(link);
            if !good { workflow_stop(w, "malformed Link"); return; }
            if target.len > 0 {
                var resolved: u8[>..] = [];
                if workflow_url(w.base, workflow_data(w).url, target, resolved) != 1 { workflow_stop(w, "unsafe next link"); return; }
                for v in workflow_data(w).visited { if v == resolved { workflow_stop(w, "pagination cycle"); return; } }
                if w.pages >= w.limits.pages { workflow_stop(w, "page limit"); return; }
                workflow_replace(w, 1, "", copy(resolved), [], [], []); return;
            }
        }
        w.fetch = 0;
    }
    if w.fetch >= workflow_data(w).accessions.len {
        w.done = true; w.complete = true; return;
    }
    var url: u8[>..] = [];
    for a, i in workflow_data(w).accessions { if i == w.fetch { url.append(uniprot_fetch(a, "json", w.base)); } }
    workflow_replace(w, 1, "", url, [], [], []);
}
fn uniprot_workflow(query: u8[:], base: u8[:], limits: UniProtLimits) -> UniProtWorkflow {
    var w = workflow_begin(query, base, limits, workflow_now());
    while !w.done {
        let now = workflow_now();
        if now < 0 { workflow_stop(w, "monotonic clock failure"); break; }
        if now < w.ready && now < w.deadline {
            let until = if w.ready < w.deadline { w.ready } else { w.deadline };
            workflow_sleep(until - now); continue;
        }
        if !workflow_request(w, now) { continue; }
        var timeout = w.deadline - now;
        if timeout > 300000 { timeout = 300000; }
        let remaining = w.limits.bytes - w.bytes;
        let r = workflow_transport(workflow_data(w).url, timeout, remaining);
        workflow_accept(w, copy(r), workflow_now(), true);
        let checked = workflow_check_time(w, workflow_now());
        if !checked { break; }
    }
    return w;
}

extern fn workflow_start(url: const u8[:], timeout: i64, cap: i64) -> i64 = "bio_workflow_start";
fn workflow_transport(url: u8[:], timeout: i64, cap: i64) -> GooseHttpResult {
    let h = workflow_start(url, timeout, cap);
    if h == 0 { return GooseHttpResult { 0, "", "", "allocation failure", -1 }; }
    var b: u8[>..] = []; var headers: u8[>..] = []; var error: u8[>..] = [];
    let status = native_number(h, 0); let code = native_number(h, 1);
    native_copy(h, 0, b); native_copy(h, 1, headers); native_copy(h, 2, error); native_close(h);
    return GooseHttpResult { status, copy(b), copy(headers), copy(error), code };
}

fn workflow_replace(w: UniProtWorkflow&, field: i64, reason: u8[:], url: u8[:], ids: u8[][], records: UniProtEntry[], attempts: UniProtAttempt[]) {
    let old = workflow_data(w);
    let d = UniProtWorkflowData {
        (if field == 4 { copy(records) } else { copy(old.records) }),
        (if field == 5 { copy(attempts) } else { copy(old.attempts) }),
        (if field == 0 { json_bytes(reason) } else { copy(old.reason) }),
        (if field == 1 { json_bytes(url) } else { copy(old.url) }),
        (if field == 2 { copy(ids) } else { copy(old.accessions) }),
        (if field == 3 { copy(ids) } else { copy(old.visited) }) };
    w.data.clear(); w.data.push(copy(d));
}

fn workflow_token(c: u8) -> bool {
    if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') { return true; }
    for t in "!#$%&'*+-.^_`|~" { if c == t { return true; } }
    return false;
}
