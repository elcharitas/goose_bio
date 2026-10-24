#include "goose.h"
#include <zlib.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#define FX_LIMIT ((size_t)64 * 1024 * 1024)
typedef struct { const unsigned char *data; int64_t len; } FxSlice;
typedef struct { char *s; size_t len, cap; } FxText;
typedef struct FxHandle {
    int64_t id;
    gzFile file;
    FxText fields[4], line;
    int valid, failed, format, pending;
    struct FxHandle *next;
} FxHandle;
static FxHandle *fx_handles;
static int64_t fx_serial;
static int fx_append(FxText *s, const char *data, size_t n) {
    if (n > FX_LIMIT - s->len) return 0;
    size_t need=s->len+n;
    if (need > s->cap) {
        size_t cap=s->cap ? s->cap : 256;
        while (cap<need) cap=cap>FX_LIMIT/2 ? FX_LIMIT : cap*2;
        char *p=realloc(s->s,cap);
        if (!p) return 0;
        s->s=p; s->cap=cap;
    }
    if (n) memcpy(s->s+s->len,data,n);
    s->len=need; return 1;
}
/* Accept LF/CRLF and a final unterminated line; reject bare CR. Blank lines fail in the parser. */
static int fx_line(FxHandle *h) {
    h->line.len=0;
    int c;
    while ((c=gzgetc(h->file))!=-1) {
        if (c=='\n') break;
        char byte=(char)c;
        if (!fx_append(&h->line,&byte,1)) return -1;
    }
    int error=Z_OK;
    gzerror(h->file,&error);
    if (error!=Z_OK && error!=Z_STREAM_END) return -1;
    if (c==-1 && !h->line.len) return 0;
    if (h->line.len && h->line.s[h->line.len-1]=='\r') {
        if (c!='\n') return -1;
        h->line.len--;
    }
    return 1;
}
/* Headers start in column one. Names are printable, nonempty tokens; separator spaces/tabs are
 * skipped, while comment content and trailing whitespace are preserved. */
static int fx_header(FxHandle *h) {
    FxText *l=&h->line;
    if (l->len<2 || l->s[0]!=h->format) return 0;
    size_t end=1;
    while (end<l->len && l->s[end]!=' ' && l->s[end]!='\t') end++;
    if (end==1) return 0;
    for (size_t i=1;i<l->len;i++) {
        unsigned char c=(unsigned char)l->s[i];
        if ((c<33 || c>126) && c!=' ' && c!='\t') return 0;
    }
    size_t comment=end;
    while (comment<l->len && (l->s[comment]==' ' || l->s[comment]=='\t')) comment++;
    return fx_append(&h->fields[0],l->s+1,end-1) &&
        fx_append(&h->fields[1],l->s+comment,l->len-comment);
}
/* Sequence lines contain only ASCII letters or *-.?, retaining case. No empty lines or whitespace. */
static int fx_sequence(FxHandle *h) {
    if (!h->line.len) return 0;
    for (size_t i=0;i<h->line.len;i++) {
        unsigned char c=(unsigned char)h->line.s[i];
        if (!((c>='A' && c<='Z') || (c>='a' && c<='z') ||
              c=='*' || c=='-' || c=='.' || c=='?')) return 0;
    }
    return fx_append(&h->fields[2],h->line.s,h->line.len);
}
static FxHandle *fx_get(int64_t id) {
    for (FxHandle *h=fx_handles; h; h=h->next) if (h->id==id) return h;
    return NULL;
}
/* zlib accepts plain files and concatenated gzip members; trailing non-gzip bytes can go undetected. */
int64_t bio_fastx_open(FxSlice path) {
    if (path.len<=0 || (uint64_t)path.len>SIZE_MAX-1 ||
        memchr(path.data,0,(size_t)path.len) || fx_serial==INT64_MAX) return 0;
    char *p=malloc((size_t)path.len+1);
    if (!p) return 0;
    memcpy(p,path.data,(size_t)path.len); p[path.len]=0;
    FxHandle *h=calloc(1,sizeof(*h));
    if (!h) { free(p); return 0; }
    h->file=gzopen(p,"rb"); free(p);
    if (!h->file) { free(h); return 0; }
    h->id=++fx_serial; h->next=fx_handles; fx_handles=h;
    return h->id;
}
/* The first header fixes the format; empty files reach EOF. Mixed formats and preambles fail. */
int32_t bio_fastx_next(int64_t id) {
    FxHandle *h=fx_get(id);
    if (!h || h->failed) return -1;
    h->valid=0;
    for (int i=0;i<4;i++) h->fields[i].len=0;
    int result=1;
    if (!h->pending) result=fx_line(h);
    h->pending=0;
    if (result==0) return 0;
    if (result<0) goto fail;
    if (!h->format) {
        if (!h->line.len || (h->line.s[0]!='>' && h->line.s[0]!='@')) goto fail;
        h->format=h->line.s[0];
    }
    if (!fx_header(h)) goto fail;
    while ((result=fx_line(h))==1) {
        if (h->line.len && h->line.s[0]=='>') {
            if (h->format!='>') goto fail;
            h->pending=1; break;
        }
        if (h->line.len && h->line.s[0]=='+') {
            if (h->format!='@') goto fail;
            break;
        }
        if (!fx_sequence(h)) goto fail;
    }
    if (result<0 || !h->fields[2].len) goto fail;
    if (h->format=='@') {
        if (result!=1 || !h->line.len || h->line.s[0]!='+') goto fail;
        /* A nonempty + header must repeat the name; its optional comment may differ. */
        if (h->line.len>1) {
            size_t end=1;
            while (end<h->line.len && h->line.s[end]!=' ' && h->line.s[end]!='\t') end++;
            if (end-1!=h->fields[0].len ||
                memcmp(h->line.s+1,h->fields[0].s,end-1)) goto fail;
            for (size_t i=end;i<h->line.len;i++) {
                unsigned char c=(unsigned char)h->line.s[i];
                if ((c<32 || c>126) && c!='\t') goto fail;
            }
        }
        /* Quality bytes are ASCII 33..126 and must total exactly the sequence length. */
        while (h->fields[3].len<h->fields[2].len) {
            if (fx_line(h)!=1 || !h->line.len ||
                h->line.len>h->fields[2].len-h->fields[3].len) goto fail;
            for (size_t i=0;i<h->line.len;i++) {
                unsigned char c=(unsigned char)h->line.s[i];
                if (c<33 || c>126) goto fail;
            }
            if (!fx_append(&h->fields[3],h->line.s,h->line.len)) goto fail;
        }
    }
    h->valid=1; return 1;
fail:
    h->failed=1; return -1;
}
int32_t bio_fastx_field(int64_t id, int32_t field, gs_rref out) {
    FxHandle *h=fx_get(id);
    if (!h || !h->valid || field<0 || field>3) return -1;
    FxText *value=&h->fields[field];
    if (value->len) gs_bld_append(out,value->s,value->len);
    return 0;
}
/* Close releases buffers even after parse failure; report zlib close status independently. */
int32_t bio_fastx_close(int64_t id) {
    FxHandle **p=&fx_handles;
    while (*p && (*p)->id!=id) p=&(*p)->next;
    if (!*p) return -1;
    FxHandle *h=*p; *p=h->next;
    for (int i=0;i<4;i++) free(h->fields[i].s);
    free(h->line.s);
    int result=gzclose(h->file); free(h);
    return result==Z_OK ? 0 : -1;
}
