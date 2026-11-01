// Copyright (c) 2026 Jonathan Irhodia. MIT license.
import bio_http from "..";
fn limits() -> bio_http::UniProtLimits { return bio_http::UniProtLimits { 3, 3, 12, 100000, 5000, 10, 2 }; }
fn reply(body: u8[:], headers: u8[:] = "", status: i64 = 200) -> bio_http::GooseHttpResult {
    return bio_http::GooseHttpResult { status, bio_http::json_bytes(body), bio_http::json_bytes(headers), "", 0 };
}
fn send(w: bio_http::UniProtWorkflow&, body: u8[:], headers: u8[:] = "", status: i64 = 200) {
    assert(bio_http::workflow_request(w, w.ready));
    bio_http::workflow_accept(w, reply(body, headers, status), w.ready);
}
fn main() {
    let base = "http://127.0.0.1:18771";
    var w = bio_http::workflow_begin("test", base, limits(), 100);
    assert(!w.done);
    send(w, "{}", "Retry-After: 1\r\n", 429);
    assert(w.ready == 1100);
    assert(!bio_http::workflow_request(w, 1099));
    send(w, "{\"results\":[{\"primaryAccession\":\"A1\"}]}", "Link: <?page=2>; rel=next\r\n");
    assert(w.ready == 1110);
    send(w, "{\"results\":[{\"primaryAccession\":\"A1\"},{\"primaryAccession\":\"B2\"}]}", "Link: <search?page=3>; rel=next\r\n");
    send(w, "{\"results\":[{\"primaryAccession\":\"C3\"}]}");
    for k in 0..3 {
        let id = if k == 0 { "A1" } else { if k == 1 { "B2" } else { "C3" } };
        let body = bio_http::join(bio_http::join("{\"primaryAccession\":\"", id), "\",\"sequence\":{\"value\":\"MPE\",\"length\":3}}");
        send(w, body);
    }
    assert(w.complete && bio_http::workflow_data(w).records.len == 3);
    assert(bio_http::workflow_data(w).attempts.len == 7);
    for a, i in bio_http::workflow_data(w).attempts {
        assert(a.response.code == 0);
        if i == 0 { assert(a.started_ms == 100 && a.response.status == 429 && a.response.body == "{}"); }
        else { assert(a.response.status == 200 && a.response.body.len > 0); }
    }
    for r, i in bio_http::workflow_data(w).records { assert(r.accession.value == (if i == 0 { "A1" } else { if i == 1 { "B2" } else { "C3" } })); }
    var empty = bio_http::workflow_begin("test", base, limits(), 0);
    send(empty, "{\"results\":[]}"); assert(empty.complete);
    for link in ["Link: garbage\r\n", "Link: <?cursor=%ZZ>; rel=next\r\n", "Link: <https://foreign/uniprotkb/search>; rel=next\r\n", "Link: <http://u:p@127.0.0.1:18771/uniprotkb/search>; rel=next\r\n", "Link: </wrong>; rel=next\r\n", "Link: <?query=test&format=json>; rel=next\r\n", "Link: <?p=2>; rel=next, garbage\r\n"] {
        var bad = bio_http::workflow_begin("test", base, limits(), 0);
        send(bad, "{\"results\":[]}", link);
        assert(bad.done && !bad.complete);
    }
    for delay in ["Retry-After: Wed, 01 Jan 2030 00:00:00 GMT\r\n", "Retry-After: 6\r\n"] {
        var bad = bio_http::workflow_begin("test", base, limits(), 0);
        send(bad, "", delay, 429); assert(bad.done && !bad.complete);
    }
    var exhaust = bio_http::workflow_begin("test", base, limits(), 0);
    send(exhaust, "", "", 503); send(exhaust, "", "", 503); send(exhaust, "", "", 503);
    assert(exhaust.done && !exhaust.complete && exhaust.ready == 30);
    for body in ["{\"primaryAccession\":\"B2\",\"sequence\":{\"value\":\"M\",\"length\":1}}", "{\"primaryAccession\":\"A1\",\"sequence\":{\"value\":\"M\",\"length\":2}}", "{\"primaryAccession\":\"A1\"}"] {
        var bad = bio_http::workflow_begin("test", base, limits(), 0);
        send(bad, "{\"results\":[{\"primaryAccession\":\"A1\"}]}"); send(bad, body);
        assert(bad.done && !bad.complete);
    }
    var later = bio_http::workflow_begin("test", base, limits(), 0);
    send(later, "{\"results\":[{\"primaryAccession\":\"A1\"},{\"primaryAccession\":\"B2\"}]}");
    send(later, "{\"primaryAccession\":\"A1\",\"sequence\":{\"value\":\"M\",\"length\":1}}");
    send(later, "failure", "", 404);
    assert(!later.complete && bio_http::workflow_data(later).records.len == 1);
    for field in 0..5 {
        var cap = limits();
        if field == 0 { cap.pages = 1; }
        if field == 1 { cap.entries = 1; }
        if field == 2 { cap.requests = 1; }
        if field == 3 { cap.bytes = 1; }
        if field == 4 { cap.deadline_ms = 10; }
        var bad = bio_http::workflow_begin("test", base, cap, 0);
        send(bad, "{\"results\":[{\"primaryAccession\":\"A1\"},{\"primaryAccession\":\"B2\"}]}", "Link: <?page=2>; rel=next\r\n");
        if !bad.done { bio_http::workflow_request(bad, 10); }
        assert(bad.done && !bad.complete);
    }
    var transport = bio_http::workflow_begin("test", base, limits(), 0);
    assert(bio_http::workflow_request(transport, 0));
    bio_http::workflow_accept(transport, bio_http::GooseHttpResult { 0, "partial", "", "failed", 7 }, 3);
    assert(transport.ready == 10 && !transport.done);
    send(transport, "{\"results\":[]}"); assert(transport.complete);
    var redirect = bio_http::workflow_begin("test", base, limits(), 0);
    send(redirect, "", "Location: /uniprotkb/search\r\n", 302);
    assert(redirect.done && !redirect.complete);
    var exact = limits(); exact.bytes = 14;
    var boundary = bio_http::workflow_begin("test", base, exact, 0);
    send(boundary, "{\"results\":[]}"); assert(boundary.complete && boundary.bytes == 14);
    var stale = bio_http::workflow_begin("test", base, limits(), 100);
    assert(!bio_http::workflow_request(stale, 99) && stale.done);
    var invalid = limits(); invalid.retries = 3;
    var rejected = bio_http::workflow_begin("test", base, invalid, 0);
    assert(rejected.done && !rejected.complete);
    var late = bio_http::workflow_begin("test", base, limits(), 0);
    assert(bio_http::workflow_request(late, 0));
    bio_http::workflow_accept(late, reply("{\"results\":[]}"), 5000);
    assert(late.done && !late.complete && bio_http::workflow_data(late).attempts.len == 1);
    var processed = bio_http::workflow_begin("test", base, limits(), 0);
    assert(bio_http::workflow_request(processed, 0));
    bio_http::workflow_accept(processed, reply("{\"results\":[]}"), 4999);
    assert(processed.complete);
    assert(!bio_http::workflow_check_time(processed, 5000));
    assert(processed.done && !processed.complete && bio_http::workflow_data(processed).reason == "deadline");
    var heavy_limits = limits(); heavy_limits.bytes = 2000000; heavy_limits.deadline_ms = 100;
    var heavy = bio_http::uniprot_workflow("heavy", base, heavy_limits);
    assert(heavy.done && !heavy.complete && bio_http::workflow_data(heavy).reason == "deadline");
    var small = limits(); small.bytes = 180;
    var bounded = bio_http::uniprot_workflow("test", base, small);
    assert(bounded.done && !bounded.complete && bounded.bytes <= 180);
    var short = limits(); short.deadline_ms = 10; short.interval_ms = 0;
    var timed = bio_http::uniprot_workflow("slow", base, short);
    assert(timed.done && !timed.complete);
    var recovered = bio_http::uniprot_workflow("recover", base, limits());
    assert(recovered.complete && bio_http::workflow_data(recovered).attempts.len == 2);
    var failed = bio_http::uniprot_workflow("exhaust", base, limits());
    assert(failed.done && !failed.complete && bio_http::workflow_data(failed).attempts.len == 3);
    var real = bio_http::uniprot_workflow("test", base, limits());
    assert(real.complete && bio_http::workflow_data(real).records.len == 3);
    var previous: i64 = -10;
    for a in bio_http::workflow_data(real).attempts { assert(a.started_ms >= previous + 10); previous = a.started_ms; }
}
