# Biological HTTP clients

HTTP requests, service URL builders, and JSON response readers using system libcurl.

```goose
import bio_http from "path/to/net";
```

- `request(method, url)` supports GET, HEAD, and POST. Its result owns
  `status`, `body`, `headers`, `code`, and `error`.
- URL builders cover `Entrez`, UniProt, KEGG, TogoWS, and ExPASy.
- `entrez_search_response(result)` and `uniprot_response(result)` validate
  HTTP results and parse selected JSON fields, retaining the raw body.
- `uniprot_workflow(query, base, limits)` searches and fetches sequences with
  pagination, pacing, retries, and explicit resource limits.

Check transport `code == 0` and the expected HTTP status before using a body.
Check parser `error` before using typed fields; optional fields distinguish
missing, null, valid, and invalid values. Failed requests can retain partial data.

Requests run synchronously on the main thread. TLS checks remain enabled;
redirects are not followed. These APIs do not support authentication, arbitrary headers, streaming,
or cancellation. Direct requests do not paginate or pace retries.

See [request APIs](bio_http.goose), [JSON readers](responses.goose), and
[search and fetch](WORKFLOW.md) for parameters and limits.
