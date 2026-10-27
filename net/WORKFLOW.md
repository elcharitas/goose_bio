# UniProt search and fetch

Import the optional `bio_http` package from `net`.
`uniprot_workflow(query, base, limits)` searches, collects accessions in first-seen
order, and fetches each unique accession as JSON. A logical fetch can make up to
three attempts. Search finishes before fetch begins. Search entries can omit
sequence fields. Fetch requires the requested primary accession, a nonempty
uppercase ASCII A..Z sequence, and an integer length equal to its byte count.

`UniProtLimits { pages, entries, requests, bytes, deadline_ms, interval_ms,
retries }` has no implicit defaults. Valid inclusive ranges are:

- Pages: 1..1000 successful search pages.
- Entries: 1..10000 unique accessions, with duplicates excluded.
- Requests: 1..30000 total attempts, including retries and fetches.
- Bytes: 1..67108864 aggregate response body and header bytes across attempts.
- Deadline: 1..300000 milliseconds from workflow start.
- Interval: 0..300000 milliseconds between request start times.
- Retries: 0..2 additional attempts per logical request.

Query length is 1..65536 bytes. Accessions contain 1..32 uppercase letters,
digits, or hyphens. The configured base must be an HTTP or HTTPS origin without
a path, trailing slash, credentials, query, or fragment. Search uses the
encoded query builder and fixed `/uniprotkb/search` path. There is no page-size
or field-selection parameter. Response limits still apply to large pages.

The synchronous runner uses CLOCK_MONOTONIC for the deadline and one scheduler
for search, fetch, and retries. Each transfer timeout is the remaining deadline.
The native receiver shares one remaining byte budget between headers and body.
Headers also have a 1 MiB per-attempt cap. Rejected callback chunks are not
retained. Limit failures retain available request records, then stop. Copies,
JSON nodes, and transport buffers require additional memory beyond retained bytes.
This is synchronous main-thread code, without cancellation or streaming.
Clock checks run after JSON parsing and between entry-processing steps.
Parsing cannot stop midway, so execution can exceed the deadline; an expired
workflow returns incomplete instead of reporting successful completion.

Retries cover transport failures, 429, 500, 502, 503, and 504. Byte-cap write
failures stop immediately. `Retry-After` accepts only nonempty decimal seconds
within signed i64. Dates, signs, fractions, overflow, repeated fields, and folded
headers fail. The next start is the later of the interval and retry delay.
A delay reaching or exceeding the deadline stops without another request.
There is no jitter or additional exponential backoff.

Link parsing distinguishes an absent field from malformed syntax. It validates
the entire field, including text after a next target. It supports comma-separated
links, quoted parameter values, and relation lists. Quoted escapes, repeated Link
fields, duplicate relation parameters, multiple next targets, and folded headers
fail. A valid Link with no next relation ends search. Relative targets resolve
against the current URL using libcurl URL helpers. Resolved targets must use the
configured scheme, host, effective port, and exact search path. Credentials,
fragments, non-ASCII targets, malformed percent escapes, foreign origins, wrong
paths, and repeated resolved URLs fail. Cycle identity uses the resolved URL
string; semantically equivalent query encodings still stop at the page limit.
Redirect statuses fail and are never followed. Existing proxy, credential, and
TLS trust settings stay unchanged.

The returned workflow exposes `done`, `complete`, and counters. Call
`workflow_data(workflow)` to obtain owned `records`, `accessions`, `attempts`,
`reason`, `url`, and `visited`. Each attempt retains its URL, monotonic start,
and full `GooseHttpResult`: raw body, raw headers, transport code, error, and
HTTP status. All attempted responses remain available, including failures.
`complete` means search ended and every selected entry passed fetch validation.
Zero hits return complete with empty records. Any limit or later failure returns
incomplete with a nonempty reason and already validated records. A failure during
search returns no fetched records. Callers must check complete before treating
records as an exhaustive result. Snapshot construction and deduplication copy
arrays and can take quadratic time; upper bounds are guards, not performance goals.

For deterministic adapters, `workflow_begin(query, base, limits, now)` creates
state. `workflow_request(state, now)` authorizes one attempt only when ready.
It returns false before ready. Use `workflow_data(state).url` and the remaining
budgets. Pass exactly one response to `workflow_accept(state, response, now)`.
After processing, call `workflow_check_time(state, now)` with the updated clock
before consuming completion. Time must never move backwards. A pending request blocks another authorization.
The supplied response must obey the transport budget; the state machine also
checks aggregate sizes. The state-machine API uses caller-supplied elapsed time.
