namespace bio_http;
import std;
import json;

fn json_bytes(s: u8[:]) -> u8[] {
    var out: u8[>..] = [];
    out.append(s);
    return copy(out);
}

// State: 0 missing, 1 null, 2 value, 3 invalid type or range.
struct JsonText { value: u8[], state: i64 }
struct JsonCount { value: i64, state: i64 }
struct EntrezSearchResult {
    count: JsonCount, retmax: JsonCount, retstart: JsonCount,
    ids: u8[][], query_key: JsonCount, webenv: JsonText,
    raw: u8[], error: u8[]
}
struct UniProtEntry {
    accession: JsonText, id: JsonText, entry_type: JsonText,
    sequence: JsonText, length: JsonCount
}
struct UniProtResult { entries: UniProtEntry[], raw: u8[], error: u8[] }

fn json_text(n: json::Node?) -> JsonText {
    guard n else { return JsonText { "", 0 }; }
    match n.val {
        Null => { return JsonText { "", 1 }; },
        Str s => { return JsonText { json_bytes(s.s), 2 }; },
        _ => { return JsonText { "", 3 }; },
    }
}
fn decimal_count(s: u8[:]) -> JsonCount {
    if s.len == 0 { return JsonCount { 0, 3 }; }
    var v: i64 = 0;
    for c in s {
        if c < '0' || c > '9' { return JsonCount { 0, 3 }; }
        let d = (c - '0') as i64;
        if v > (9223372036854775807 - d) / 10 {
            return JsonCount { 0, 3 };
        }
        v = v * 10 + d;
    }
    return JsonCount { v, 2 };
}
fn json_count(n: json::Node?, strings: bool = true) -> JsonCount {
    guard n else { return JsonCount { 0, 0 }; }
    match n.val {
        Null => { return JsonCount { 0, 1 }; },
        Int v => { return JsonCount { v.v, if v.v >= 0 { 2 } else { 3 } }; },
        Str s => { if strings { return decimal_count(s.s); } },
        _ => {},
    }
    return JsonCount { 0, 3 };
}
fn json_object(n: json::Node?) -> bool {
    guard n else { return false; }
    match n.val { Obj => { return true; }, _ => { return false; }, }
}
fn json_array(n: json::Node?) -> bool {
    guard n else { return false; }
    match n.val { Arr => { return true; }, _ => { return false; }, }
}
// Reject ambiguous duplicate members, including unknown extensions.
fn unique_members(nodes: json::Node[:]) -> bool {
    for &n in nodes {
        match n.val {
            Obj => {
                var a = n.first;
                while a {
                    var b = a.next;
                    while b {
                        if a.key == b.key { return false; }
                        b .= b.next;
                    }
                    a .= a.next;
                }
            },
            _ => {},
        }
    }
    return true;
}
fn entrez_failure(raw: u8[:], error: u8[:]) -> EntrezSearchResult {
    return EntrezSearchResult { JsonCount { 0, 0 }, JsonCount { 0, 0 },
        JsonCount { 0, 0 }, [], JsonCount { 0, 0 }, JsonText { "", 0 },
        json_bytes(raw), json_bytes(error) };
}
fn parse_entrez_search(text: u8[:]) -> EntrezSearchResult {
    var nodes: json::Node[>..] = [];
    var decoded: u8[>..] = [];
    let root, err = json::parse(text, nodes, decoded);
    if err.len > 0 { return entrez_failure(text, err); }
    if !json_object(root) || !unique_members(nodes) {
        return entrez_failure(text, "expected unambiguous JSON object");
    }
    let top_error = json::member(root, "error");
    if top_error { return entrez_failure(text, "Entrez service error (see raw)"); }
    let r = json::member(root, "esearchresult");
    if !json_object(r) { return entrez_failure(text, "missing or invalid esearchresult"); }
    let count = json_count(json::member(r, "count"));
    let max = json_count(json::member(r, "retmax"));
    let start = json_count(json::member(r, "retstart"));
    let key = json_count(json::member(r, "querykey"));
    let env = json_text(json::member(r, "webenv"));
    let list = json::member(r, "idlist");
    var ids: u8[][>..] = [];
    var error: const u8[:] = "";
    if count.state != 2 || max.state != 2 || start.state != 2 {
        error = "missing, null, or invalid count/page field";
    }
    if key.state == 1 || key.state == 3 || env.state == 1 || env.state == 3 {
        error = "null or invalid history field";
    }
    if (key.state == 2) != (env.state == 2) || (key.state == 2 && (key.value == 0 || env.value.len == 0)) {
        error = "incomplete history pair";
    }
    if !json_array(list) { error = "missing, null, or invalid idlist"; }
    else if list {
        var c = list.first;
        while c {
            let id = json_text(c);
            if id.state != 2 || decimal_count(id.value).state != 2 {
                error = "invalid Entrez ID (expected decimal string within i64)";
            } else { ids.push(copy(id.value)); }
            c .= c.next;
        }
    }
    if count.state == 2 && max.state == 2 && (ids.len > count.value || ids.len > max.value) {
        error = "ID list exceeds count or retmax";
    }
    if json::member(r, "errorlist") || json::member(r, "ERROR") || json::member(r, "error") {
        error = "Entrez service error (see raw)";
    }
    return EntrezSearchResult { count, max, start, copy(ids), key, env, json_bytes(text), json_bytes(error) };
}
fn uniprot_entry(n: json::Node?) -> UniProtEntry {
    let seq = json::member(n, "sequence");
    return UniProtEntry {
        json_text(json::member(n, "primaryAccession")),
        json_text(json::member(n, "uniProtkbId")),
        json_text(json::member(n, "entryType")),
        json_text(json::member(seq, "value")),
        json_count(json::member(seq, "length"), false)
    };
}
fn uniprot_entry_error(n: json::Node?, e: UniProtEntry&) -> u8[] {
    if !json_object(n) || e.accession.state != 2 || e.accession.value.len == 0 {
        return "missing, null, or invalid primaryAccession";
    }
    if e.id.state == 1 || e.id.state == 3 || e.entry_type.state == 1 || e.entry_type.state == 3 {
        return "null or invalid entry metadata";
    }
    let seq = json::member(n, "sequence");
    if seq {
        if !json_object(seq) || e.sequence.state != 2 || e.length.state != 2 {
            return "sequence requires string value and integer length";
        }
        if e.sequence.value.len != e.length.value { return "sequence length mismatch"; }
    }
    return "";
}
fn parse_uniprot(text: u8[:], search: bool) -> UniProtResult {
    var nodes: json::Node[>..] = [];
    var decoded: u8[>..] = [];
    let root, err = json::parse(text, nodes, decoded);
    if err.len > 0 { return UniProtResult { [], json_bytes(text), copy(err) }; }
    if !json_object(root) || !unique_members(nodes) {
        return UniProtResult { [], json_bytes(text), "expected unambiguous JSON object" };
    }
    if json::member(root, "messages") {
        return UniProtResult { [], json_bytes(text), "UniProt service error (see raw)" };
    }
    var entries: UniProtEntry[>..] = [];
    if search {
        let results = json::member(root, "results");
        if !json_array(results) { return UniProtResult { [], json_bytes(text), "missing, null, or invalid results" }; }
        if results {
            var c = results.first;
            while c {
                let e = uniprot_entry(c);
                let error = uniprot_entry_error(c, e);
                if error.len > 0 { return UniProtResult { [], json_bytes(text), error }; }
                entries.push(copy(e));
                c .= c.next;
            }
        }
    } else {
        let e = uniprot_entry(root);
        let error = uniprot_entry_error(root, e);
        if error.len > 0 { return UniProtResult { [], json_bytes(text), error }; }
        entries.push(copy(e));
    }
    return UniProtResult { copy(entries), json_bytes(text), "" };
}
fn parse_uniprot_search(text: u8[:]) -> UniProtResult { return parse_uniprot(text, true); }
fn parse_uniprot_entry(text: u8[:]) -> UniProtResult { return parse_uniprot(text, false); }
