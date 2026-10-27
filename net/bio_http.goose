namespace bio_http;
import .responses;
import .workflow;

extern "bio_http_start" fn native_start(method: const u8[:], url: const u8[:], payload: const u8[:], timeout: i64, cap: i64, header_cap: i64) -> i64;
extern "bio_http_number" fn native_number(handle: i64, field: i32) -> i64;
extern "bio_http_copy" fn native_copy(handle: i64, field: i32, out: u8[>..]&) -> i32;
extern "bio_http_close" fn native_close(handle: i64) -> i32;

struct GooseHttpResult {
    status: i64, body: u8[], headers: u8[], error: u8[], code: i64
}

fn request(method: u8[:], url: u8[:], payload: u8[:] = "", timeout_ms: i64 = 10000, body_cap: i64 = 8388608, header_cap: i64 = 65536) -> GooseHttpResult {
    let h = native_start(method, url, payload, timeout_ms, body_cap, header_cap);
    if h == 0 { return GooseHttpResult { 0, "", "", "allocation failure", -1 }; }
    var body: u8[>..] = [];
    var headers: u8[>..] = [];
    var error: u8[>..] = [];
    let status = native_number(h, 0);
    let code = native_number(h, 1);
    native_copy(h, 0, body);
    native_copy(h, 1, headers);
    native_copy(h, 2, error);
    native_close(h);
    return GooseHttpResult { status, copy(body), copy(headers), copy(error), code };
}

fn encode(value: u8[:]) -> u8[] {
    let hex = "0123456789ABCDEF";
    var out: u8[>..] = [];
    for c in value {
        if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-' || c == '_' || c == '.' || c == '~' { out.push(c); }
        else { out.push('%'); out.push(hex[c / 16]); out.push(hex[c % 16]); }
    }
    return copy(out);
}

fn entrez_search(db: u8[:], term: u8[:], base: u8[:] = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils") -> u8[] {
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/esearch.fcgi?db=" { out.push(c); }
    for c in encode(db) { out.push(c); }
    for c in "&term=" { out.push(c); }
    for c in encode(term) { out.push(c); }
    for c in "&usehistory=y&retmode=json" { out.push(c); }
    return copy(out);
}
fn entrez_fetch(db: u8[:], ids: u8[:], rettype: u8[:], retmode: u8[:], base: u8[:] = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils") -> u8[] {
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/efetch.fcgi?db=" { out.push(c); }
    for c in encode(db) { out.push(c); }
    for c in "&id=" { out.push(c); }
    for c in encode(ids) { out.push(c); }
    for c in "&rettype=" { out.push(c); }
    for c in encode(rettype) { out.push(c); }
    for c in "&retmode=" { out.push(c); }
    for c in encode(retmode) { out.push(c); }
    return copy(out);
}
fn entrez_history(db: u8[:], webenv: u8[:], query_key: u8[:], start: u8[:], count: u8[:], base: u8[:] = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils") -> u8[] {
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/efetch.fcgi?db=" { out.push(c); }
    for c in encode(db) { out.push(c); }
    for c in "&WebEnv=" { out.push(c); }
    for c in encode(webenv) { out.push(c); }
    for c in "&query_key=" { out.push(c); }
    for c in encode(query_key) { out.push(c); }
    for c in "&retstart=" { out.push(c); }
    for c in encode(start) { out.push(c); }
    for c in "&retmax=" { out.push(c); }
    for c in encode(count) { out.push(c); }
    return copy(out);
}
fn uniprot_search(query: u8[:], base: u8[:] = "https://rest.uniprot.org") -> u8[] {
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/uniprotkb/search?query=" { out.push(c); }
    for c in encode(query) { out.push(c); }
    for c in "&format=json" { out.push(c); }
    return copy(out);
}
// Dot-only composed path segments return an empty URL.
fn uniprot_fetch(accession: u8[:], format: u8[:] = "fasta", base: u8[:] = "https://rest.uniprot.org") -> u8[] {
    if (accession == "" && (format == "" || format == ".")) || (accession == "." && format == "") { return ""; }
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/uniprotkb/" { out.push(c); }
    for c in encode(accession) { out.push(c); }
    for c in "." { out.push(c); }
    for c in encode(format) { out.push(c); }
    return copy(out);
}
// Dot-only standalone path parts return an empty URL.
fn kegg(operation: u8[:], argument: u8[:], base: u8[:] = "https://rest.kegg.jp") -> u8[] {
    if operation == "." || operation == ".." || argument == "." || argument == ".." { return ""; }
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/" { out.push(c); }
    for c in encode(operation) { out.push(c); }
    for c in "/" { out.push(c); }
    for c in encode(argument) { out.push(c); }
    return copy(out);
}
// An empty URL reports invalid input through request.code.
fn togows(database: u8[:], id: u8[:], format: u8[:] = "fasta", base: u8[:] = "https://togows.org") -> u8[] {
    if database == "." || database == ".." { return ""; }
    if (id == "" && (format == "" || format == ".")) || (id == "." && format == "") { return ""; }
    var out: u8[>..] = [];
    for c in base { out.push(c); }
    for c in "/entry/" { out.push(c); }
    for c in encode(database) { out.push(c); }
    for c in "/" { out.push(c); }
    for c in encode(id) { out.push(c); }
    for c in "." { out.push(c); }
    for c in encode(format) { out.push(c); }
    return copy(out);
}
fn expasy(accession: u8[:], base: u8[:] = "https://rest.uniprot.org") -> u8[] {
    return uniprot_fetch(accession, "txt", base);
}

fn ascii_equal(a: u8[:], b: u8[:]) -> bool {
    if a.len != b.len { return false; }
    for c, i in a {
        var lower = c;
        if c >= 'A' && c <= 'Z' { lower += 32; }
        if lower != b[i] { return false; }
    }
    return true;
}
fn space(c: u8) -> bool { return c == ' ' || c == '\t'; }
fn next_relation(value: u8[:]) -> bool {
    var i = 0;
    while i < value.len {
        while i < value.len && space(value[i]) { i += 1; }
        let start = i;
        while i < value.len && !space(value[i]) { i += 1; }
        if ascii_equal(value[start..i], "next") { return true; }
    }
    return false;
}

// Malformed or unsupported Link syntax returns an empty target.
fn link_value(value: u8[:]) -> u8[] {
    var i = 0;
    while i < value.len {
        while i < value.len && space(value[i]) { i += 1; }
        if i == value.len || value[i] != '<' { return ""; }
        i += 1;
        let target = i;
        while i < value.len && value[i] != '>' { i += 1; }
        if i == value.len { return ""; }
        let end = i;
        i += 1;
        var next = false;
        var seen_rel = false;
        while i < value.len {
            while i < value.len && space(value[i]) { i += 1; }
            if i == value.len || value[i] == ',' { break; }
            if value[i] != ';' { return ""; }
            i += 1;
            while i < value.len && space(value[i]) { i += 1; }
            let name = i;
            while i < value.len && !space(value[i]) && value[i] != '=' && value[i] != ';' && value[i] != ',' { i += 1; }
            let name_end = i;
            if name == name_end { return ""; }
            while i < value.len && space(value[i]) { i += 1; }
            if i == value.len || value[i] != '=' { return ""; }
            i += 1;
            while i < value.len && space(value[i]) { i += 1; }
            if i == value.len { return ""; }
            var quoted = false;
            if value[i] == '"' { quoted = true; i += 1; }
            let start = i;
            if quoted {
                while i < value.len && value[i] != '"' {
                    // Quoted pairs are deliberately unsupported.
                    if value[i] == '\\' { return ""; }
                    i += 1;
                }
                if i == value.len { return ""; }
            } else {
                while i < value.len && !space(value[i]) && value[i] != ';' && value[i] != ',' { i += 1; }
            }
            if ascii_equal(value[name..name_end], "rel") {
                if seen_rel { return ""; }
                seen_rel = true;
                next = next_relation(value[start..i]);
            }
            if quoted { i += 1; }
        }
        if next {
            var out: u8[>..] = [];
            for c in value[target..end] { out.push(c); }
            return copy(out);
        }
        if i < value.len { i += 1; }
    }
    return "";
}

// A new status line discards interim or earlier response headers.
fn next_link(headers: u8[:]) -> u8[] {
    var response_start = 0;
    var i = 0;
    while i < headers.len {
        let start = i;
        while i < headers.len && headers[i] != '\r' && headers[i] != '\n' { i += 1; }
        let line = headers[start..i];
        if line.len >= 5 && line[0..5] == "HTTP/" { response_start = start; }
        while i < headers.len && (headers[i] == '\r' || headers[i] == '\n') { i += 1; }
    }
    i = response_start;
    while i < headers.len {
        let start = i;
        while i < headers.len && headers[i] != '\r' && headers[i] != '\n' { i += 1; }
        let line = headers[start..i];
        if line.len >= 5 && ascii_equal(line[0..5], "link:") {
            let target = link_value(line[5..]);
            if target.len > 0 { return copy(target); }
        }
        while i < headers.len && (headers[i] == '\r' || headers[i] == '\n') { i += 1; }
    }
    return "";
}

// Only GET retries; the caller chooses at most two additional attempts.
fn get_retry(url: u8[:], retries: i32 = 0, timeout_ms: i64 = 10000) -> GooseHttpResult {
    if retries < 0 || retries > 2 { return GooseHttpResult { 0, "", "", "retries must be 0..2", -1 }; }
    for attempt in 0 .. retries + 1 {
        let result = request("GET", url, "", timeout_ms);
        if attempt == retries || (result.code == 0 && result.status != 429 && result.status < 500) { return copy(result); }
    }
    return GooseHttpResult { 0, "", "", "invalid retry state", -1 };
}
fn join(a: u8[:], b: u8[:]) -> u8[] {
    var out: u8[>..] = [];
    for c in a { out.push(c); }
    for c in b { out.push(c); }
    return copy(out);
}

fn entrez_search_response(response: GooseHttpResult) -> EntrezSearchResult {
    if response.code != 0 || response.error.len > 0 {
        return entrez_failure(response.body, "transport error; see HTTP result");
    }
    if response.status != 200 {
        return entrez_failure(response.body, "HTTP status is not 200; see HTTP result");
    }
    return parse_entrez_search(response.body);
}
fn uniprot_response(response: GooseHttpResult, search: bool = true) -> UniProtResult {
    if response.code != 0 || response.error.len > 0 {
        return UniProtResult { [], copy(response.body), "transport error; see HTTP result" };
    }
    if response.status != 200 {
        return UniProtResult { [], copy(response.body), "HTTP status is not 200; see HTTP result" };
    }
    return parse_uniprot(response.body, search);
}
