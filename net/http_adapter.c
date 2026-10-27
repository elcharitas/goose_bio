#include "goose.h"
#include <curl/curl.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct { const unsigned char *data; int64_t len; } Slice;
typedef struct { char *data; size_t len, cap; size_t *remaining; } Buffer;
typedef struct Result {
    int64_t id; long status; int error;
    Buffer body, headers; size_t remaining;
    struct Result *next;
} Result;
static Result *results;
static int64_t serial;
static char *text(Slice s) {
    if (s.len < 0 || s.len > 1048576 ||
        (s.len && memchr(s.data, 0, (size_t)s.len))) return NULL;
    char *p = malloc((size_t)s.len + 1);
    if (p) { memcpy(p, s.data, (size_t)s.len); p[s.len] = 0; }
    return p;
}
static size_t receive(char *p, size_t size, size_t n, void *ctx) {
    Buffer *b = ctx;
    if (size && n > SIZE_MAX / size) return 0;
    size_t bytes = size * n;
    if (bytes > b->cap - b->len ||
        (b->remaining && bytes > *b->remaining)) return 0;
    char *q = realloc(b->data, b->len + bytes + 1);
    if (!q) return 0;
    b->data = q; memcpy(q + b->len, p, bytes);
    if (b->remaining) *b->remaining -= bytes;
    b->len += bytes; q[b->len] = 0; return bytes;
}
static Result *get(int64_t id) {
    for (Result *r = results; r; r = r->next)
        if (r->id == id) return r;
    return NULL;
}
static int64_t http_start(Slice method, Slice url, Slice payload,
                       int64_t timeout, int64_t cap, int64_t header_cap, int aggregate) {
    if (serial == INT64_MAX) return 0;
    Result *r = calloc(1, sizeof(*r));
    if (!r) return 0;
    r->id = ++serial; r->next = results; results = r;
    r->error = CURLE_BAD_FUNCTION_ARGUMENT;
    char *m = text(method), *u = text(url);
    CURL *c = NULL;
    if (!m || !u || payload.len < 0 || payload.len > 16777216 ||
        timeout < 1 || timeout > 300000 || cap < 1 || cap > 67108864 ||
        header_cap < 1 || header_cap > 1048576) goto done;
    if (strcmp(m,"GET") && strcmp(m,"POST") && strcmp(m,"HEAD")) goto done;
    if (strncmp(u,"http://",7) && strncmp(u,"https://",8)) goto done;
    /* Reject URL credentials without consulting environment credentials. */
    CURLU *parsed = curl_url();
    char *user = NULL;
    if (!parsed) goto done;
    CURLUcode ur = curl_url_set(parsed, CURLUPART_URL, u, 0);
    int has_user = curl_url_get(parsed, CURLUPART_USER, &user, 0) == CURLUE_OK;
    curl_free(user); curl_url_cleanup(parsed);
    if (ur != CURLUE_OK || has_user) goto done;
    c = curl_easy_init();
    if (!c) { r->error = CURLE_FAILED_INIT; goto done; }
    if (aggregate) {
        r->remaining = (size_t)cap;
        r->body.remaining = r->headers.remaining = &r->remaining;
    }
    r->body.cap = (size_t)cap; r->headers.cap = (size_t)header_cap;
#define OPT(k,v) do { if (curl_easy_setopt(c,k,v) != CURLE_OK) goto done; } while (0)
    OPT(CURLOPT_URL,u);
    OPT(CURLOPT_PROTOCOLS,(long)(CURLPROTO_HTTP | CURLPROTO_HTTPS));
    OPT(CURLOPT_REDIR_PROTOCOLS,(long)(CURLPROTO_HTTP | CURLPROTO_HTTPS));
    OPT(CURLOPT_FOLLOWLOCATION,0L);
    OPT(CURLOPT_PROXY, "");
    OPT(CURLOPT_NETRC,(long)CURL_NETRC_IGNORED);
    OPT(CURLOPT_SSL_VERIFYPEER,1L); OPT(CURLOPT_SSL_VERIFYHOST,2L);
    OPT(CURLOPT_NOSIGNAL,1L); OPT(CURLOPT_TIMEOUT_MS,(long)timeout);
    OPT(CURLOPT_CONNECTTIMEOUT_MS,(long)timeout);
    OPT(CURLOPT_WRITEFUNCTION,receive); OPT(CURLOPT_WRITEDATA,&r->body);
    OPT(CURLOPT_HEADERFUNCTION,receive); OPT(CURLOPT_HEADERDATA,&r->headers);
    if (!strcmp(m,"HEAD")) { OPT(CURLOPT_NOBODY,1L); }
    if (!strcmp(m,"POST")) {
        OPT(CURLOPT_POST,1L);
        OPT(CURLOPT_POSTFIELDS,payload.len ? (const char *)payload.data : "");
        OPT(CURLOPT_POSTFIELDSIZE_LARGE,(curl_off_t)payload.len);
    }
    r->error = curl_easy_perform(c);
    curl_easy_getinfo(c,CURLINFO_RESPONSE_CODE,&r->status);
done:
    if (c) curl_easy_cleanup(c);
    free(m); free(u); return r->id;
}
int64_t bio_http_number(int64_t id, int32_t field) {
    Result *r=get(id); if (!r) return -1;
    return field == 0 ? r->status : r->error;
}
int32_t bio_http_copy(int64_t id, int32_t field, gs_rref out) {
    Result *r=get(id); if (!r) return -1;
    if (field == 2) {
        const char *s = curl_easy_strerror((CURLcode)r->error);
        if (r->error) gs_bld_append(out,s,strlen(s));
    } else {
        Buffer *b = field == 0 ? &r->body : &r->headers;
        if (b->len) gs_bld_append(out,b->data,b->len);
    }
    return 0;
}
int32_t bio_http_close(int64_t id) {
    Result **p=&results;
    while (*p && (*p)->id != id) p=&(*p)->next;
    if (!*p) return -1;
    Result *r=*p; *p=r->next;
    free(r->body.data); free(r->headers.data); free(r); return 0;
}

#include <time.h>
#include <errno.h>
#include <ctype.h>
int64_t bio_workflow_now(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t)) return -1;
    return (int64_t)t.tv_sec * 1000 + t.tv_nsec / 1000000;
}
void bio_workflow_sleep(int64_t ms) {
    if (ms <= 0 || ms > 300000) return;
    struct timespec t = {ms / 1000, (ms % 1000) * 1000000};
    while (nanosleep(&t, &t) && errno == EINTR) {}
}
int32_t bio_workflow_url(Slice base, Slice current, Slice target,
                         gs_rref out) {
    char *b = text(base), *c = text(current), *t = text(target);
    CURLU *u = curl_url(), *v = curl_url();
    char *bs = NULL, *bh = NULL, *bp = NULL;
    char *s = NULL, *h = NULL, *p = NULL, *path = NULL;
    char *user = NULL, *pass = NULL, *frag = NULL, *url = NULL;
    int ok = 0;
    if (!b || !c || !t || !*t || !u || !v) goto done;
    for (char *x = t; *x; ++x)
        {
            if ((unsigned char)*x <= 32 || (unsigned char)*x >= 127 ||
                *x == '\\' || *x == '#') goto done;
            if (*x == '%' && (!x[1] || !x[2] ||
                !isxdigit((unsigned char)x[1]) ||
                !isxdigit((unsigned char)x[2]))) goto done;
        }
    if (curl_url_set(v, CURLUPART_URL, b, 0) ||
        curl_url_set(u, CURLUPART_URL, c, 0) ||
        curl_url_set(u, CURLUPART_URL, t, 0)) goto done;
    if (curl_url_get(u, CURLUPART_USER, &user, 0) == CURLUE_OK ||
        curl_url_get(u, CURLUPART_PASSWORD, &pass, 0) == CURLUE_OK ||
        curl_url_get(u, CURLUPART_FRAGMENT, &frag, 0) == CURLUE_OK) goto done;
#define PART(obj, part, dest, flags) \
    if (curl_url_get(obj, part, &dest, flags)) goto done
    PART(v, CURLUPART_SCHEME, bs, 0);
    PART(v, CURLUPART_HOST, bh, 0);
    PART(v, CURLUPART_PORT, bp, CURLU_DEFAULT_PORT);
    PART(u, CURLUPART_SCHEME, s, 0);
    PART(u, CURLUPART_HOST, h, 0);
    PART(u, CURLUPART_PORT, p, CURLU_DEFAULT_PORT);
    PART(u, CURLUPART_PATH, path, 0);
    if ((strcmp(s,"http") && strcmp(s,"https")) || strcmp(s,bs) ||
        strcmp(h,bh) || strcmp(p,bp) ||
        strcmp(path,"/uniprotkb/search")) goto done;
    PART(u, CURLUPART_URL, url, 0);
    gs_bld_append(out, url, strlen(url)); ok = 1;
#undef PART
 done:
    curl_free(bs); curl_free(bh); curl_free(bp);
    curl_free(s); curl_free(h); curl_free(p); curl_free(path);
    curl_free(user); curl_free(pass); curl_free(frag); curl_free(url);
    curl_url_cleanup(u); curl_url_cleanup(v);
    free(b); free(c); free(t); return ok;
}

int64_t bio_http_start(Slice method, Slice url, Slice payload,
                       int64_t timeout, int64_t cap, int64_t header_cap) {
    return http_start(method,url,payload,timeout,cap,header_cap,0);
}
int64_t bio_workflow_start(Slice url, int64_t timeout, int64_t cap) {
    Slice method = {(const unsigned char *)"GET",3}, empty = {NULL,0};
    return http_start(method,url,empty,timeout,cap,
                      cap < 1048576 ? cap : 1048576,1);
}
