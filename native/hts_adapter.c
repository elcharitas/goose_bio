#include "goose.h"
#include <htslib/sam.h>
#include <htslib/vcf.h>
#include <htslib/faidx.h>
#include <htslib/bgzf.h>
#include <htslib/tbx.h>
#include <htslib/thread_pool.h>
#include <htslib/synced_bcf_reader.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <stdio.h>
#include <limits.h>
#include <math.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

typedef struct { const unsigned char *data; int64_t len; } Slice;
typedef struct Pool {
    int64_t id; hts_tpool *pool; int refs;
    struct Pool *next;
} Pool;
static Pool *pools;

typedef struct Handle {
    int64_t id;
    htsFile *file;
    sam_hdr_t *sam;
    bcf_hdr_t *vcf;
    bam1_t *bam;
    bcf1_t *bcf;
    hts_idx_t *index;
    hts_itr_t *iter;
    int variants, writing, valid, used;
    Pool *pool;
    bam_plp_t pileup; const bam_pileup1_t *column;
    int depth, pile_tid, pile_error;
    int pile_configured, pile_max, pile_flags, pile_mapq;
    hts_pos_t pile_pos;
    struct Handle *next;
} Handle;
static Handle *handles;
static int64_t serial;
static char *copy(Slice s) {
    if (s.len < 0 || (uint64_t)s.len > SIZE_MAX-1 ||
        (s.len && memchr(s.data, 0, (size_t)s.len))) return NULL;
    char *p = malloc((size_t)s.len+1);
    if (p) { memcpy(p,s.data,(size_t)s.len); p[s.len]=0; }
    return p;
}
static Handle *get(int64_t id) {
    for (Handle *h=handles; h; h=h->next) if (h->id==id) return h;
    return NULL;
}
static int destroy(Handle *h) {
    if (h->pileup) bam_plp_destroy(h->pileup);
    hts_itr_destroy(h->iter); hts_idx_destroy(h->index);
    bam_destroy1(h->bam); bcf_destroy(h->bcf);
    sam_hdr_destroy(h->sam); bcf_hdr_destroy(h->vcf);
    int r=h->file ? hts_close(h->file) : 0;
    if (h->pool) h->pool->refs--;
    free(h); return r < 0 ? -1 : 0;
}
int64_t bio_hts_open(Slice path, Slice mode, _Bool variants,
                     Slice header, Slice reference) {
    char *p=copy(path), *m=copy(mode), *t=copy(header), *r=copy(reference);
    Handle *h=calloc(1,sizeof(*h));
    if (!p || !m || !t || !r || !h) goto fail;
    if (strcmp(m,"r") && strcmp(m,"w") && strcmp(m,"wb") &&
        strcmp(m,"wc") && strcmp(m,"wz")) goto fail;
    if (strstr(p,"://") || !strcmp(p,"-")) goto fail;
    if (variants && !strcmp(m,"wc")) goto fail;
    h->variants=variants; h->writing=m[0]=='w';
    h->file=hts_open(p,m);
    if (!h->file) goto fail;
    enum htsExactFormat fmt=hts_get_format(h->file)->format;
    if (!h->writing && (variants ? (fmt!=vcf && fmt!=bcf)
                                      : (fmt!=sam && fmt!=bam && fmt!=cram))) goto fail;
    if (hts_get_format(h->file)->format==cram) {
        if (!*r || strstr(r,"://")) goto fail;
        if (hts_set_fai_filename(h->file,r)<0) goto fail;
    }
    if (!h->writing) {
        int eof=hts_check_EOF(h->file);
        if (eof!=1 && eof!=3) goto fail;
    }
    if (variants) {
        h->bcf=bcf_init();
        h->vcf=h->writing ? bcf_hdr_init("r") : bcf_hdr_read(h->file);
        if (!h->bcf || !h->vcf) goto fail;
        if (h->writing && (bcf_hdr_parse(h->vcf,t)<0 ||
            bcf_hdr_sync(h->vcf)<0 || bcf_hdr_write(h->file,h->vcf)<0)) goto fail;
    } else {
        h->bam=bam_init1();
        h->sam=h->writing ? sam_hdr_parse(strlen(t),t) : sam_hdr_read(h->file);
        if (!h->bam || !h->sam) goto fail;
        if (h->writing && sam_hdr_write(h->file,h->sam)<0) goto fail;
    }
    if (serial==INT64_MAX) goto fail;
    h->id=++serial; h->next=handles; handles=h;
    free(p); free(m); free(t); free(r); return h->id;
fail:
    if (h) destroy(h);
    free(p); free(m); free(t); free(r); return 0;
}
int32_t bio_hts_close(int64_t id) {
    Handle **p=&handles;
    while (*p && (*p)->id!=id) p=&(*p)->next;
    if (!*p) return -1;
    Handle *h=*p; *p=h->next; return destroy(h);
}
int32_t bio_hts_next(int64_t id) {
    Handle *h=get(id); if (!h || h->writing || h->pileup) return -1;
    h->used=1;
    int r;
    if (h->variants) r=h->iter ? bcf_itr_next(h->file,h->iter,h->bcf)
                                             : bcf_read(h->file,h->vcf,h->bcf);
    else r=h->iter ? sam_itr_next(h->file,h->iter,h->bam)
                   : sam_read1(h->file,h->sam,h->bam);
    h->valid=r>=0; return r>=0 ? 1 : r==-1 ? 0 : -1;
}
int32_t bio_hts_write(int64_t id, Slice line) {
    Handle *h=get(id); if (!h || !h->writing) return -1;
    h->used=1;
    char *s=copy(line); if (!s) return -1;
    kstring_t k={strlen(s),strlen(s)+1,s};
    int r=h->variants ? vcf_parse(&k,h->vcf,h->bcf)
                      : sam_parse1(&k,h->sam,h->bam);
    if (r>=0) r=h->variants ? bcf_write(h->file,h->vcf,h->bcf)
                            : sam_write1(h->file,h->sam,h->bam);
    free(k.s); h->valid=r>=0; return r>=0 ? 0 : -1;
}
int32_t bio_hts_text(int64_t id, gs_rref out) {
    Handle *h=get(id); if (!h || !h->valid) return -1;
    kstring_t k={0,0,NULL};
    int r=h->variants ? vcf_format(h->vcf,h->bcf,&k)
                      : sam_format1(h->sam,h->bam,&k);
    if (r>=0) gs_bld_append(out,k.s,k.l);
    free(k.s); return r<0 ? -1 : 0;
}
int32_t bio_hts_header(int64_t id, gs_rref out) {
    Handle *h=get(id); if (!h) return -1;
    if (h->variants) {
        kstring_t k={0,0,NULL}; int r=bcf_hdr_format(h->vcf,0,&k);
        if (r>=0) gs_bld_append(out,k.s,k.l);
        free(k.s); return r<0 ? -1 : 0;
    }
    const char *s=sam_hdr_str(h->sam); if (!s) return -1;
    gs_bld_append(out,s,sam_hdr_length(h->sam)); return 0;
}
int64_t bio_hts_position(int64_t id) {
    Handle *h=get(id); return !h || !h->valid ? -1 :
        h->variants ? h->bcf->pos : h->bam->core.pos;
}
int32_t bio_hts_flag(int64_t id) {
    Handle *h=get(id); return !h || !h->valid || h->variants ? -1 : h->bam->core.flag;
}
int32_t bio_hts_mapq(int64_t id) {
    Handle *h=get(id); return !h || !h->valid || h->variants ? -1 : h->bam->core.qual;
}
int32_t bio_hts_index(Slice path, _Bool variants) {
    char *p=copy(path); if (!p || strstr(p,"://")) { free(p); return -1; }
    int r=variants ? bcf_index_build(p,14) : sam_index_build(p,0);
    free(p); return r<0 ? -1 : 0;
}
int32_t bio_hts_query(int64_t id, Slice region) {
    Handle *h=get(id); if (!h || h->writing || h->pileup) return -1;
    char *s=copy(region); if (!s) return -1;
    hts_itr_destroy(h->iter); h->iter=NULL; h->valid=0;
    if (!h->index) h->index=h->variants ? bcf_index_load(h->file->fn)
                                       : sam_index_load(h->file,h->file->fn);
    if (h->index) h->iter=h->variants ? bcf_itr_querys(h->index,h->vcf,s)
                                      : sam_itr_querys(h->index,h->sam,s);
    free(s); return h->iter ? 0 : -1;
}
int32_t bio_fasta_fetch(Slice path, Slice name, int64_t start,
                         int64_t end, gs_rref out) {
    char *p=copy(path), *n=copy(name); int r=-1;
    if (!p || !n || strstr(p,"://") || start<0 || end<=start) goto done;
    faidx_t *f=fai_load(p); if (!f) goto done;
    hts_pos_t len=0;
    char *s=faidx_fetch_seq64(f,n,start,end-1,&len);
    if (s && len==end-start) { gs_bld_append(out,s,len); r=0; }
    free(s); fai_destroy(f);
done: free(p); free(n); return r;
}
int32_t bio_bgzf_copy(Slice source, Slice dest, _Bool compress) {
    char *s=copy(source), *d=copy(dest); int r=-1;
    if (!s || !d || !strcmp(s,d) || strstr(s,"://") || strstr(d,"://")) goto done;
    int src=open(s,O_RDONLY);
    if (src<0) goto done;
    BGZF *b=NULL; FILE *f=NULL;
    if (!compress) {
        b=bgzf_dopen(src,"r");
        if (!b) { close(src); goto done; }
        if (bgzf_check_EOF(b)!=1) { bgzf_close(b); goto done; }
    }
    int dst=open(d,O_WRONLY|O_CREAT,0666);
    struct stat si, di;
    if (dst<0 || fstat(src,&si)<0 || fstat(dst,&di)<0 ||
        (si.st_dev==di.st_dev && si.st_ino==di.st_ino) ||
        ftruncate(dst,0)<0) {
        if (dst>=0) close(dst);
        if (b) bgzf_close(b); else close(src);
        goto done;
    }
    if (compress) {
        f=fdopen(src,"rb"); b=bgzf_dopen(dst,"w");
        if (!f) close(src);
        if (!b) close(dst);
    } else {
        f=fdopen(dst,"wb");
        if (!f) close(dst);
    }
    if (!f || !b) {
        if (f) fclose(f);
        if (b) bgzf_close(b);
        goto done;
    }
    char buf[65536]; ssize_t n; r=0;
    if (compress) {
        while ((n=fread(buf,1,sizeof(buf),f))>0)
            if (bgzf_write(b,buf,n)!=n) { r=-1; break; }
        if (ferror(f)) r=-1;
    } else {
        while ((n=bgzf_read(b,buf,sizeof(buf)))>0)
            if (fwrite(buf,1,n,f)!=(size_t)n) { r=-1; break; }
        if (n<0) r=-1;
    }
    if (fclose(f)) r=-1;
    if (bgzf_close(b)) r=-1;
done: free(s); free(d); return r;
}
int32_t bio_tabix_index(Slice path) {
    char *p=copy(path); if (!p || strstr(p,"://")) { free(p); return -1; }
    int r=tbx_index_build(p,0,&tbx_conf_vcf); free(p); return r<0 ? -1 : 0;
}
int32_t bio_tabix_query(Slice path, Slice region, gs_rref out) {
    char *p=copy(path), *s=copy(region); int r=-1;
    if (!p || !s || strstr(p,"://")) goto done;
    htsFile *f=hts_open(p,"r"); tbx_t *t=tbx_index_load(p);
    if (!f || !t) { if (f) hts_close(f); if (t) tbx_destroy(t); goto done; }
    hts_itr_t *it=tbx_itr_querys(t,s); kstring_t k={0,0,NULL};
    if (it) {
        int n; r=0;
        while ((n=tbx_itr_next(f,t,it,&k))>=0) {
            gs_bld_append(out,k.s,k.l); gs_bld_append(out,"\n",1);
        }
        if (n < -1) r=-1;
    }
    free(k.s); hts_itr_destroy(it); tbx_destroy(t);
    if (hts_close(f)<0) r=-1;
done: free(p); free(s); return r;
}

static Handle *alignment(int64_t id) {
    Handle *h=get(id); return h && h->valid && !h->variants ? h : NULL;
}
static int valid_tag(Slice tag) {
    return tag.len==2 && ((tag.data[0]>='A' && tag.data[0]<='Z') ||
        (tag.data[0]>='a' && tag.data[0]<='z')) &&
        ((tag.data[1]>='A' && tag.data[1]<='Z') ||
         (tag.data[1]>='a' && tag.data[1]<='z') ||
         (tag.data[1]>='0' && tag.data[1]<='9'));
}
static uint8_t *aux(int64_t id, Slice tag) {
    Handle *h=alignment(id);
    return h && valid_tag(tag) ? bam_aux_get(h->bam,(const char *)tag.data) : NULL;
}
int32_t bio_bam_aux_type(int64_t id, Slice tag) {
    uint8_t *p=aux(id,tag); return p ? *p : -1;
}
int64_t bio_bam_aux_int(int64_t id, Slice tag, int64_t index) {
    uint8_t *p=aux(id,tag);
    if (!p) return INT64_MIN;
    if (*p=='B') return index>=0 && index<bam_auxB_len(p) &&
        strchr("cCsSiI",p[1]) ? bam_auxB2i(p,index) : INT64_MIN;
    return index==0 && strchr("cCsSiI",*p) ? bam_aux2i(p) : INT64_MIN;
}
double bio_bam_aux_float(int64_t id, Slice tag, int64_t index) {
    uint8_t *p=aux(id,tag);
    if (!p) return NAN;
    if (*p=='B') return index>=0 && index<bam_auxB_len(p) &&
        p[1]=='f' ? bam_auxB2f(p,index) : NAN;
    return index==0 && (*p=='f' || *p=='d') ? bam_aux2f(p) : NAN;
}
int64_t bio_bam_aux_count(int64_t id, Slice tag) {
    uint8_t *p=aux(id,tag); return !p ? -1 : *p=='B' ? bam_auxB_len(p) : 1;
}
int32_t bio_bam_aux_string(int64_t id, Slice tag, gs_rref out) {
    uint8_t *p=aux(id,tag);
    if (!p || (*p!='Z' && *p!='H' && *p!='A')) return -1;
    gs_bld_append(out,p+1,*p=='A' ? 1 : strlen((char *)p+1)); return 0;
}
int32_t bio_bam_aux_set_int(int64_t id, Slice tag, int64_t value) {
    Handle *h=alignment(id); if (!h || !valid_tag(tag)) return -1;
    return bam_aux_update_int(h->bam,(const char *)tag.data,value)<0 ? -1 : 0;
}
int32_t bio_bam_aux_set_float(int64_t id, Slice tag, double value) {
    Handle *h=alignment(id); if (!h || !valid_tag(tag)) return -1;
    return bam_aux_update_float(h->bam,(const char *)tag.data,value)<0 ? -1 : 0;
}
int32_t bio_bam_aux_set_string(int64_t id, Slice tag, Slice value) {
    Handle *h=alignment(id); char *v=copy(value); int r=-1;
    if (h && valid_tag(tag) && v && value.len<INT_MAX)
        r=bam_aux_update_str(h->bam,(const char *)tag.data,value.len+1,v);
    free(v); return r<0 ? -1 : 0;
}
int32_t bio_bam_aux_delete(int64_t id, Slice tag) {
    Handle *h=alignment(id); uint8_t *p=aux(id,tag);
    return h && p && bam_aux_del(h->bam,p)==0 ? 0 : -1;
}
int32_t bio_hts_copy_record(int64_t source, int64_t destination) {
    Handle *s=get(source), *d=get(destination);
    if (!s || !d || !s->valid || !d->writing || s->variants!=d->variants) return -1;
    if (s->variants) {
        kstring_t a={0,0,NULL}, b={0,0,NULL};
        int same=bcf_hdr_format(s->vcf,0,&a)>=0 &&
            bcf_hdr_format(d->vcf,0,&b)>=0 && a.l==b.l && !memcmp(a.s,b.s,a.l);
        free(a.s); free(b.s); if (!same) return -1;
    } else if (strcmp(sam_hdr_str(s->sam),sam_hdr_str(d->sam))) return -1;
    int r=s->variants ? bcf_write(d->file,d->vcf,s->bcf)
                      : sam_write1(d->file,d->sam,s->bam);
    return r<0 ? -1 : 0;
}
/* Copyright Jonathan Irhodia. */
#define ALIGN_HEADER_LIMIT (1024 * 1024)
#define ALIGN_RECORD_LIMIT (16 * 1024 * 1024)
#define ALIGN_REF_LIMIT 4096
#define ALIGN_CHAIN_LIMIT 128

/* Limits apply before cloning; header text and dictionary names share the cap.
 * PG predecessor traversal is bounded separately to reject cycles. */
static int alignment_header_bound(sam_hdr_t *h) {
    if (!h || h->n_targets<0 || h->n_targets>ALIGN_REF_LIMIT ||
        h->l_text>ALIGN_HEADER_LIMIT) return -1;
    size_t total=h->l_text;
    for (int i=0; i<h->n_targets; i++) {
        if (!h->target_name || !h->target_name[i]) return -1;
        size_t n=strnlen(h->target_name[i],ALIGN_HEADER_LIMIT+1);
        if (n>ALIGN_HEADER_LIMIT || total>ALIGN_HEADER_LIMIT-n) return -1;
        total+=n;
    }
    return 0;
}
/* Preserve -1, but reject every other invalid ID and destination aliases.
 * Primary names and positive lengths must match; M5 must match on both sides if present. */
static int alignment_map_tid(sam_hdr_t *s, sam_hdr_t *d, int id) {
    if (id==-1) return -1;
    const char *name=sam_hdr_tid2name(s,id);
    if (!name) return -2;
    int tid=sam_hdr_name2tid(d,name);
    const char *primary=sam_hdr_tid2name(d,tid);
    if (!primary || strcmp(primary,name) || sam_hdr_tid2len(s,id)<=0 ||
        sam_hdr_tid2len(s,id)!=sam_hdr_tid2len(d,tid)) return -2;
    kstring_t a={0,0,NULL}, b={0,0,NULL};
    int x=sam_hdr_find_tag_id(s,"SQ","SN",name,"M5",&a);
    int y=sam_hdr_find_tag_id(d,"SQ","SN",name,"M5",&b);
    int ok=(x==-1 && y==-1) || (x==0 && y==0 && a.l==b.l &&
        !memcmp(a.s,b.s,a.l));
    free(a.s); free(b.s); return ok ? tid : -2;
}
/* Referenced RG/PG lines, including sample metadata, match byte for byte.
 * Follow RG PG and PG PP predecessors; reordered equivalent tags may still reject. */
static int alignment_line(sam_hdr_t *s, sam_hdr_t *d,
                           const char *type, const char *id, int depth) {
    if (depth>=ALIGN_CHAIN_LIMIT) return -1;
    kstring_t a={0,0,NULL}, b={0,0,NULL}, next={0,0,NULL};
    int ok=sam_hdr_find_line_id(s,type,"ID",id,&a)==0 &&
        sam_hdr_find_line_id(d,type,"ID",id,&b)==0 &&
        a.l==b.l && !memcmp(a.s,b.s,a.l);
    if (ok) {
        int r=sam_hdr_find_tag_id(s,type,"ID",id,
            !strcmp(type,"RG") ? "PG" : "PP",&next);
        if (r==0) ok=next.l &&
            alignment_line(s,d,"PG",next.s,depth+1)==0;
        else if (r!=-1) ok=0;
    }
    free(a.s); free(b.s); free(next.s); return ok ? 0 : -1;
}
static int alignment_aux(sam_hdr_t *s, sam_hdr_t *d, bam1_t *b) {
    uint64_t offset=(uint64_t)b->core.l_qname+4ULL*b->core.n_cigar+
        ((uint64_t)b->core.l_qseq+1)/2+(uint64_t)b->core.l_qseq;
    if (b->core.l_qseq<0 || offset>(uint64_t)b->l_data ||
        !b->core.l_qname || !b->data ||
        !memchr(b->data,0,b->core.l_qname)) return -1;
    uint8_t *p=b->data+offset, *end=b->data+b->l_data;
    int rg=0, pg=0;
    while (p<end) {
        if (end-p<3) return -1;
        int ref=(p[0]=='R' && p[1]=='G') || (p[0]=='P' && p[1]=='G');
        const char *type=p[0]=='R' ? "RG" : "PG";
        unsigned char t=p[2]; p+=3;
        if (ref && (t!='Z' || (!strcmp(type,"RG") ? rg++ : pg++))) return -1;
        size_t n=0;
        switch(t) {
        case 'A': case 'c': case 'C': n=1; break;
        case 's': case 'S': n=2; break;
        case 'i': case 'I': case 'f': n=4; break;
        case 'd': n=8; break;
        case 'Z': case 'H': {
            uint8_t *z=memchr(p,0,end-p); if (!z) return -1;
            n=z-p+1;
            if (ref && (n==1 || alignment_line(s,d,type,(char *)p,0)<0)) return -1;
            break;
        }
        case 'B': {
            if (end-p<5) return -1;
            size_t width=0;
            switch (*p) {
            case 'c': case 'C': width=1; break;
            case 's': case 'S': width=2; break;
            case 'i': case 'I': case 'f': width=4; break;
            default: return -1;
            }
            uint32_t count=(uint32_t)p[1]|(uint32_t)p[2]<<8|
                (uint32_t)p[3]<<16|(uint32_t)p[4]<<24;
            if (count>(size_t)(end-p-5)/width) return -1;
            n=5+(size_t)count*width; break;
        }
        default: return -1;
        }
        if (n>(size_t)(end-p)) return -1;
        p+=n;
    }
    return 0;
}
/* Change only cloned tid/mtid; positions, flags, qualities, CIGAR, IDs, and aux bytes survive.
 * Embedded reference names in SA/XA/OA are untouched. Coordinate SO rejects dictionary
 * inversions, but does not sort or verify source order. No native pointer escapes. */
int32_t bio_hts_copy_alignment_mapped(int64_t source, int64_t destination) {
    Handle *s=get(source), *d=get(destination);
    if (!s || !d || s->variants || d->variants || s->writing ||
        !d->writing || !s->valid || !s->bam ||
        alignment_header_bound(s->sam)<0 || alignment_header_bound(d->sam)<0 ||
        s->bam->l_data<0 || s->bam->l_data>ALIGN_RECORD_LIMIT ||
        (uint32_t)s->bam->l_data>s->bam->m_data) return -1;
    bam1_t *b=bam_dup1(s->bam);
    sam_hdr_t *sh=sam_hdr_dup(s->sam), *dh=sam_hdr_dup(d->sam);
    int result=-1;
    kstring_t so={0,0,NULL};
    if (!b || !sh || !dh) goto done;
    int tid=alignment_map_tid(sh,dh,b->core.tid);
    int mtid=alignment_map_tid(sh,dh,b->core.mtid);
    if (tid< -1 || mtid< -1 || alignment_aux(sh,dh,b)<0) goto done;
    int r=sam_hdr_find_tag_hd(dh,"SO",&so);
    if (r< -1) goto done;
    if (r==0 && !strcmp(so.s,"coordinate")) {
        int previous=-1;
        for (int i=0; i<sam_hdr_nref(sh); i++) {
            const char *name=sam_hdr_tid2name(sh,i);
            int target=name ? sam_hdr_name2tid(dh,name) : -1;
            const char *primary=sam_hdr_tid2name(dh,target);
            if (primary && !strcmp(primary,name)) {
                if (target<=previous) goto done;
                previous=target;
            }
        }
    }
    b->core.tid=tid; b->core.mtid=mtid;
    result=sam_write1(d->file,dh,b)<0 ? -1 : 0;
done:
    free(so.s); bam_destroy1(b); sam_hdr_destroy(sh); sam_hdr_destroy(dh);
    return result;
}
static int mapped_values(Handle *h, bcf1_t *record);
/* Only referenced declarations must exist; unused source entries may be absent.
 * INFO/FORMAT Type and Number must match. Destination extras are allowed. */
static int mapped_field(const bcf_hdr_t *src, const bcf_hdr_t *dst,
                        int kind, int id) {
    if (id<0 || id>=src->n[BCF_DT_ID] ||
        !bcf_hdr_idinfo_exists(src,kind,id)) return -1;
    const char *name=bcf_hdr_int2id(src,BCF_DT_ID,id);
    int target=bcf_hdr_id2int(dst,BCF_DT_ID,name);
    if (target<0 || !bcf_hdr_idinfo_exists(dst,kind,target)) return -1;
    if (kind!=BCF_HL_FLT &&
        (bcf_hdr_id2type(src,kind,id)!=bcf_hdr_id2type(dst,kind,target) ||
         bcf_hdr_id2length(src,kind,id)!=bcf_hdr_id2length(dst,kind,target) ||
         bcf_hdr_id2number(src,kind,id)!=bcf_hdr_id2number(dst,kind,target)))
        return -1;
    return 0;
}
/* Dictionary identity uses exact names, not contig-length or assembly equivalence.
 * Destination samples select/reorder source samples; FORMAT with no samples rejects.
 * Clone validation precedes writing. File headers and partial I/O cannot be rolled back. */
static int copy_variant_mapped(int64_t source, int64_t destination,
                               bcf1_t *mapped, int recompute) {
    Handle *s=get(source), *d=get(destination);
    if (!s || !d || !s->valid || !s->variants || !d->variants ||
        !d->writing || s->bcf->errcode) return -1;
    int result=-1, ns=bcf_hdr_nsamples(d->vcf);
    int *samples=calloc(ns ? ns : 1,sizeof(*samples));
    bcf1_t *record=bcf_dup(mapped ? mapped : s->bcf);
    bcf_hdr_t *src=bcf_hdr_dup(s->vcf), *dst=bcf_hdr_dup(d->vcf), *selected=NULL;
    if (!samples || !record || !src || !dst) goto done;
    if (bcf_unpack(record,BCF_UN_ALL)<0 || record->errcode ||
        record->rid<0 || record->rid>=src->n[BCF_DT_CTG] ||
        record->n_sample!=bcf_hdr_nsamples(src)) goto done;
    const char *contig=bcf_hdr_id2name(src,record->rid);
    if (!contig || bcf_hdr_name2id(dst,contig)<0) goto done;
    for (int i=0;i<ns;i++) {
        samples[i]=bcf_hdr_id2int(src,BCF_DT_SAMPLE,dst->samples[i]);
        if (samples[i]<0) goto done;
        for (int j=0;j<i;j++) if (samples[i]==samples[j]) goto done;
    }
    if (!ns && record->n_fmt) goto done;
    for (int i=0;i<record->d.n_flt;i++)
        if (mapped_field(src,dst,BCF_HL_FLT,record->d.flt[i])<0) goto done;
    for (int i=0;i<record->n_info;i++)
        if (mapped_field(src,dst,BCF_HL_INFO,record->d.info[i].key)<0) goto done;
    for (int i=0;i<record->n_fmt;i++)
        if (mapped_field(src,dst,BCF_HL_FMT,record->d.fmt[i].id)<0) goto done;
    if (!mapped && !mapped_values(s,record)) goto done;
    if (recompute) {
        selected=bcf_hdr_subset(src,ns,dst->samples,samples);
        if (!selected || bcf_hdr_nsamples(selected)!=ns) goto done;
    }
    if (bcf_subset(src,record,ns,samples)<0) goto done;
    /* Recompute after destination sample selection: GT supplies AC/AN, excluding missing alleles.
     * AF is missing when AN=0. Both headers need Integer AC/AN and Float AF; reject count overflow.
     * These tags bypass stale-annotation policy. */
    if (recompute) {
        int32_t *gt=NULL, capacity=0, an=0;
        int32_t *ac=calloc(record->n_allele,sizeof(*ac));
        float *af=calloc(record->n_allele,sizeof(*af));
        int count=bcf_get_genotypes(selected,record,&gt,&capacity), ok=ac && af && count>0;
        for (int i=0;i<count && ok;i++) {
            if (gt[i]==bcf_int32_vector_end || bcf_gt_is_missing(gt[i])) continue;
            int a=bcf_gt_allele(gt[i]);
            if (a<0 || a>=record->n_allele || an==INT32_MAX) { ok=0; break; }
            ac[a]++; an++;
        }
        for (int i=1;i<record->n_allele && ok;i++) {
            if (an) af[i]=(float)ac[i]/an;
            else bcf_float_set_missing(af[i]);
        }
        const char *tags[]={"AC","AN","AF"};
        for (int i=0;i<3 && ok;i++) {
            int id=bcf_hdr_id2int(src,BCF_DT_ID,tags[i]);
            if (mapped_field(src,dst,BCF_HL_INFO,id)<0 ||
                !bcf_hdr_idinfo_exists(src,BCF_HL_INFO,id) ||
                bcf_hdr_id2type(src,BCF_HL_INFO,id)!=(i==2 ? BCF_HT_REAL : BCF_HT_INT) ||
                bcf_hdr_id2length(src,BCF_HL_INFO,id)!=(i==1 ? BCF_VL_FIXED : BCF_VL_A) ||
                (i==1 && bcf_hdr_id2number(src,BCF_HL_INFO,id)!=1)) ok=0;
        }
        if (ok && (bcf_update_info_int32(src,record,"AC",ac+1,record->n_allele-1)<0 ||
            bcf_update_info_int32(src,record,"AN",&an,1)<0 ||
            bcf_update_info_float(src,record,"AF",af+1,record->n_allele-1)<0)) ok=0;
        free(gt); free(ac); free(af); if (!ok) goto done;
    }
    if (bcf_translate(dst,src,record)<0) goto done;
    result=bcf_write(d->file,d->vcf,record)<0 ? -1 : 0;
done:
    free(samples); bcf_destroy(record);
    bcf_hdr_destroy(src); bcf_hdr_destroy(dst); bcf_hdr_destroy(selected);
    return result;
}
int32_t bio_hts_copy_variant_mapped(int64_t source, int64_t destination) {
    return copy_variant_mapped(source,destination,NULL,0);
}
int32_t bio_bam_sequence(int64_t id, gs_rref out) {
    Handle *h=alignment(id); if (!h) return -1;
    uint8_t *s=bam_get_seq(h->bam);
    for (int i=0;i<h->bam->core.l_qseq;i++) {
        char c=seq_nt16_str[bam_seqi(s,i)]; gs_bld_append(out,&c,1);
    }
    return 0;
}
int32_t bio_bam_quality(int64_t id, gs_rref out) {
    Handle *h=alignment(id); if (!h) return -1;
    gs_bld_append(out,bam_get_qual(h->bam),h->bam->core.l_qseq); return 0;
}
int64_t bio_bam_cigar(int64_t id, int64_t index) {
    Handle *h=alignment(id);
    return !h || index<0 || index>=h->bam->core.n_cigar ? -1 : bam_get_cigar(h->bam)[index];
}
int64_t bio_bcf_int_count(int64_t id, Slice tag, _Bool format) {
    Handle *h=get(id); char *t=copy(tag); int32_t *v=NULL; int n=0, r=-1;
    if (h && h->valid && h->variants && t)
        r=format ? bcf_get_format_int32(h->vcf,h->bcf,t,&v,&n)
                 : bcf_get_info_int32(h->vcf,h->bcf,t,&v,&n);
    free(t); free(v); return r<0 ? -1 : r;
}
int64_t bio_bcf_int(int64_t id, Slice tag, _Bool format, int64_t index) {
    Handle *h=get(id); char *t=copy(tag); int32_t *v=NULL; int n=0, r=-1;
    if (h && h->valid && h->variants && t)
        r=format ? bcf_get_format_int32(h->vcf,h->bcf,t,&v,&n)
                 : bcf_get_info_int32(h->vcf,h->bcf,t,&v,&n);
    int64_t result=index>=0 && index<r ? v[index] : INT64_MIN;
    free(t); free(v); return result;
}
static int field_type(Handle *h, const char *tag, int format, int type) {
    if (!h || !h->valid || !h->variants || !tag) return 0;
    int key=bcf_hdr_id2int(h->vcf,BCF_DT_ID,tag);
    int kind=format ? BCF_HL_FMT : BCF_HL_INFO;
    return bcf_hdr_idinfo_exists(h->vcf,kind,key) &&
           bcf_hdr_id2type(h->vcf,kind,key)==type;
}
static int numeric_count(Handle *h, const char *tag, int format,
                         const int32_t *v, int count, int floating) {
    if (!count) return 1;
    int samples=format ? bcf_hdr_nsamples(h->vcf) : 1;
    if (samples<=0 || count%samples) return 0;
    int width=count/samples, kind=format ? BCF_HL_FMT : BCF_HL_INFO;
    int key=bcf_hdr_id2int(h->vcf,BCF_DT_ID,tag);
    int length=bcf_hdr_id2length(h->vcf,kind,key);
    int expected=length==BCF_VL_FIXED ? bcf_hdr_id2number(h->vcf,kind,key) :
                 length==BCF_VL_A ? h->bcf->n_allele-1 :
                 length==BCF_VL_R ? h->bcf->n_allele : -1;
    int gt=format && !strcmp(tag,"GT");
    if (length==BCF_VL_G && !gt) return 0;
    for (int j=0;j<samples;j++) {
        int n=0, ended=0;
        for (int i=0;i<width;i++) {
            int32_t x=v[j*width+i];
            int end=floating ? (uint32_t)x==bcf_float_vector_end : x==bcf_int32_vector_end;
            if (end) { ended=1; continue; }
            if (ended) return 0;
            if (gt && (x<0 || (x>>1)>h->bcf->n_allele)) return 0;
            n++;
        }
        int missing=width && (floating ? (uint32_t)v[j*width]==bcf_float_missing :
                                         v[j*width]==bcf_int32_missing);
        if (!gt && expected>=0 && n!=expected && !(n==1 && missing)) return 0;
    }
    return 1;
}
/* Validate numeric/string cardinality, missing/vector-end values, and encoded GT bounds.
 * Generic Number=G translation is unsupported here. Allele selection has its own API. */
static int mapped_values(Handle *h, bcf1_t *record) {
    Handle view=*h; view.bcf=record;
    for (int kind=BCF_HL_INFO;kind<=BCF_HL_FMT;kind++) {
        int format=kind==BCF_HL_FMT;
        int fields=format ? record->n_fmt : record->n_info;
        for (int i=0;i<fields;i++) {
            int id=format ? record->d.fmt[i].id : record->d.info[i].key;
            const char *tag=bcf_hdr_int2id(h->vcf,BCF_DT_ID,id);
            int type=bcf_hdr_id2type(h->vcf,kind,id);
            int length=bcf_hdr_id2length(h->vcf,kind,id);
            if (length==BCF_VL_G) return 0;
            if (type==BCF_HT_FLAG) continue;
            int gt=format && !strcmp(tag,"GT");
            if (type==BCF_HT_INT || type==BCF_HT_REAL || gt) {
                void *values=NULL; int capacity=0;
                int count=format ? bcf_get_format_values(h->vcf,record,tag,
                    &values,&capacity,gt ? BCF_HT_INT : type) :
                    bcf_get_info_values(h->vcf,record,tag,&values,&capacity,type);
                int ok=count>0 && numeric_count(&view,tag,format,values,count,
                                               type==BCF_HT_REAL);
                free(values); if (!ok) return 0;
            } else if (type==BCF_HT_STR) {
                char **strings=NULL, *value=NULL; int capacity=0;
                int count=format ? bcf_get_format_string(h->vcf,record,tag,
                    &strings,&capacity) : bcf_get_info_string(h->vcf,record,
                    tag,&value,&capacity);
                int ok=count>=0;
                int expected=length==BCF_VL_FIXED ?
                    bcf_hdr_id2number(h->vcf,kind,id) :
                    length==BCF_VL_A ? record->n_allele-1 :
                    length==BCF_VL_R ? record->n_allele : -1;
                if (ok) for (int j=0;j<(format ? record->n_sample : 1);j++) {
                    const char *v=format ? strings[j] : value;
                    int n=1;
                    for (const char *p=v;*p;p++) if (*p==',') n++;
                    if (expected>=0 && n!=expected && strcmp(v,".")) ok=0;
                }
                if (strings) { free(strings[0]); free(strings); }
                free(value); if (!ok) return 0;
            } else return 0;
        }
    }
    return 1;
}
int32_t bio_bcf_set_int(int64_t id, Slice tag, _Bool format, Slice values) {
    const int32_t *v=(const int32_t *)values.data; int64_t count=values.len;
    Handle *h=get(id); char *t=copy(tag); int r=-1;
    if (h && h->valid && h->variants && t && count>=0 && count<=INT_MAX &&
        (!format || !count || (bcf_hdr_nsamples(h->vcf)>0 &&
         count%bcf_hdr_nsamples(h->vcf)==0))) {
        int key=bcf_hdr_id2int(h->vcf,BCF_DT_ID,t);
        int kind=format ? BCF_HL_FMT : BCF_HL_INFO;
        if (bcf_hdr_idinfo_exists(h->vcf,kind,key)) {
            int type=bcf_hdr_id2type(h->vcf,kind,key);
            if (type==BCF_HT_INT || (format && !strcmp(t,"GT") &&
                                    type==BCF_HT_STR))
                if (numeric_count(h,t,format,v,count,0)) r=format ? bcf_update_format_int32(h->vcf,h->bcf,t,v,count)
                         : bcf_update_info_int32(h->vcf,h->bcf,t,v,count);
        }
    }
    free(t); return r<0 ? -1 : 0;
}
typedef struct BlockHandle {
    int64_t id; BGZF *file; int writing, used; Pool *pool;
    struct BlockHandle *next;
} BlockHandle;
static BlockHandle *blocks;
static BlockHandle *block(int64_t id) {
    for (BlockHandle *b=blocks;b;b=b->next) if (b->id==id) return b;
    return NULL;
}
int64_t bio_bgzf_open(Slice path, _Bool writing) {
    char *p=copy(path);
    if (!p || !*p || !strcmp(p,"-") || strstr(p,"://")) { free(p); return 0; }
    BGZF *f=bgzf_open(p,writing ? "w" : "r"); free(p);
    if (!f) return 0;
    if ((!writing && bgzf_check_EOF(f)!=1) || serial==INT64_MAX) {
        bgzf_close(f); return 0;
    }
    BlockHandle *b=calloc(1,sizeof(*b));
    if (!b) { bgzf_close(f); return 0; }
    b->id=++serial; b->file=f; b->writing=writing;
    b->next=blocks; blocks=b; return b->id;
}
int32_t bio_bgzf_close(int64_t id) {
    BlockHandle **p=&blocks;
    while (*p && (*p)->id!=id) p=&(*p)->next;
    if (!*p) return -1;
    BlockHandle *b=*p; *p=b->next;
    int r=bgzf_close(b->file); if (b->pool) b->pool->refs--; free(b); return r<0 ? -1 : 0;
}
int64_t bio_bgzf_tell(int64_t id) {
    BlockHandle *b=block(id); if (b) b->used=1; return b ? bgzf_tell(b->file) : -1;
}
int32_t bio_bgzf_seek(int64_t id, int64_t offset) {
    BlockHandle *b=block(id); if (b) b->used=1;
    return b && !b->writing && offset>=0 && bgzf_seek(b->file,offset,SEEK_SET)==0 ? 0 : -1;
}
int64_t bio_bgzf_read(int64_t id, int64_t count, gs_rref out) {
    BlockHandle *b=block(id); if (b) b->used=1;
    if (!b || b->writing || count<0 || count>64*1024*1024) return -1;
    char *buf=malloc(count ? count : 1); if (!buf) return -1;
    ssize_t n=bgzf_read(b->file,buf,count);
    if (n>0) gs_bld_append(out,buf,n);
    free(buf); return n;
}
int32_t bio_bgzf_write(int64_t id, Slice data) {
    BlockHandle *b=block(id); if (b) b->used=1;
    return b && b->writing && data.len>=0 &&
        bgzf_write(b->file,data.data,data.len)==data.len ? 0 : -1;
}

static int32_t set_array(int64_t id, Slice tag, Slice values, _Bool floating) {
    Handle *h=alignment(id);
    if (!h || !valid_tag(tag) || values.len<0 || values.len>UINT32_MAX) return -1;
    return bam_aux_update_array(h->bam,(const char *)tag.data,
        floating ? 'f' : 'i',values.len,(void *)values.data)<0 ? -1 : 0;
}
static int pile_read(void *data, bam1_t *b) {
    Handle *h=data;
    int r;
    do {
        r=h->iter ? sam_itr_next(h->file,h->iter,b) : sam_read1(h->file,h->sam,b);
    } while (r>=0 && h->pile_configured &&
             ((b->core.flag & h->pile_flags) || b->core.qual<h->pile_mapq));
    if (r < -1) h->pile_error=1;
    return r;
}
int32_t bio_pileup_next(int64_t id) {
    Handle *h=get(id);
    if (!h || h->writing || h->variants) return -1;
    if (h->pile_error) { h->column=NULL; return -1; }
    if (!h->pileup) {
        h->pileup=bam_plp_init(pile_read,h); h->valid=0;
        if (!h->pileup) return -1;
        if (h->pile_configured) bam_plp_set_maxcnt(h->pileup,h->pile_max);
    }
    h->column=bam_plp64_auto(h->pileup,&h->pile_tid,&h->pile_pos,&h->depth);
    if (h->depth<0) h->pile_error=1;
    if (h->pile_error) h->column=NULL;
    return h->pile_error ? -1 : h->column ? 1 : 0;
}
int64_t bio_pileup_field(int64_t id, int64_t index, int32_t field) {
    Handle *h=get(id); if (!h || !h->column) return INT64_MIN;
    if (field==0) return h->pile_tid;
    if (field==1) return h->pile_pos;
    if (field==2) return h->depth;
    if (index<0 || index>=h->depth) return INT64_MIN;
    const bam_pileup1_t *p=&h->column[index];
    switch (field) {
    case 3: return p->qpos;
    case 4: return p->indel;
    case 5: return p->is_del;
    case 6: return p->is_refskip;
    case 7: return p->is_head;
    case 8: return p->is_tail;
    default: return INT64_MIN;
    }
}

int32_t bio_bam_aux_set_int_array(int64_t id, Slice tag, Slice values) {
    return set_array(id,tag,values,0);
}
int32_t bio_bam_aux_set_float_array(int64_t id, Slice tag, Slice values) {
    return set_array(id,tag,values,1);
}
int32_t bio_bam_set_sequence(int64_t id, Slice value) {
    Handle *h=alignment(id);
    if (!h || value.len!=h->bam->core.l_qseq) return -1;
    for (int64_t i=0;i<value.len;i++)
        if (!strchr("=ACMGRSVTWYHKDBN",value.data[i]) || !value.data[i]) return -1;
    uint8_t *s=bam_get_seq(h->bam);
    for (int64_t i=0;i<value.len;i++) {
        unsigned v=seq_nt16_table[value.data[i]];
        if (i&1) s[i/2]=(s[i/2]&0xf0)|v;
        else s[i/2]=v<<4;
    }
    return 0;
}
static int valid_quality(Slice value) {
    for (int64_t i=0;i<value.len;i++)
        if ((value.data[i]>93 && value.data[i]!=255) ||
            ((value.data[i]==255)!=(value.data[0]==255))) return 0;
    return 1;
}
int32_t bio_bam_set_quality(int64_t id, Slice value) {
    Handle *h=alignment(id);
    if (!h || value.len!=h->bam->core.l_qseq) return -1;
    if (!valid_quality(value)) return -1;
    memcpy(bam_get_qual(h->bam),value.data,value.len); return 0;
}

int64_t bio_bcf_float_count(int64_t id, Slice tag, _Bool format) {
    Handle *h=get(id); char *t=copy(tag); float *v=NULL; int n=0,r=-1;
    if (field_type(h,t,format,BCF_HT_REAL))
        r=format ? bcf_get_format_float(h->vcf,h->bcf,t,&v,&n) :
                   bcf_get_info_float(h->vcf,h->bcf,t,&v,&n);
    free(t); free(v); return r<0 ? -1 : r;
}
int64_t bio_bcf_float_bits(int64_t id, Slice tag, _Bool format, int64_t index) {
    Handle *h=get(id); char *t=copy(tag); float *v=NULL; int n=0,r=-1;
    if (field_type(h,t,format,BCF_HT_REAL))
        r=format ? bcf_get_format_float(h->vcf,h->bcf,t,&v,&n) :
                   bcf_get_info_float(h->vcf,h->bcf,t,&v,&n);
    uint32_t bits=0; if (index>=0 && index<r) memcpy(&bits,v+index,4);
    free(t); free(v); return index>=0 && index<r ? (int64_t)bits : -1;
}
int32_t bio_bcf_set_float_bits(int64_t id, Slice tag, _Bool format, Slice values) {
    Handle *h=get(id); char *t=copy(tag); int r=-1;
    if (values.len>=0 && values.len<=INT_MAX && field_type(h,t,format,BCF_HT_REAL) &&
        numeric_count(h,t,format,(const int32_t *)values.data,values.len,1)) {
        float *v=malloc(values.len*4+1);
        if (v) {
            memcpy(v,values.data,values.len*4);
            r=format ? bcf_update_format_float(h->vcf,h->bcf,t,v,values.len) :
                       bcf_update_info_float(h->vcf,h->bcf,t,v,values.len);
            free(v);
        }
    }
    free(t); return r<0 ? -1 : 0;
}
int32_t bio_bcf_flag(int64_t id, Slice tag) {
    Handle *h=get(id); char *t=copy(tag); int r=-1;
    if (field_type(h,t,0,BCF_HT_FLAG)) {
        bcf_info_t *info=bcf_get_info(h->vcf,h->bcf,t);
        r=info && info->vptr ? 1 : 0;
    }
    free(t); return r;
}
int32_t bio_bcf_set_flag(int64_t id, Slice tag, _Bool value) {
    Handle *h=get(id); char *t=copy(tag); int r=-1;
    if (field_type(h,t,0,BCF_HT_FLAG)) r=bcf_update_info_flag(h->vcf,h->bcf,t,NULL,value);
    free(t); return r<0 ? -1 : 0;
}
int32_t bio_bcf_string(int64_t id, Slice tag, _Bool format, int64_t sample, gs_rref out) {
    Handle *h=get(id); char *t=copy(tag); int r=-1,n=0;
    if (field_type(h,t,format,BCF_HT_STR) && strcmp(t,"GT")) {
        if (format) {
            char **v=NULL;
            if (sample>=0 && sample<bcf_hdr_nsamples(h->vcf) &&
                bcf_get_format_string(h->vcf,h->bcf,t,&v,&n)>0) {
                gs_bld_append(out,v[sample],strlen(v[sample])); r=0;
            }
            if (v) { free(v[0]); free(v); }
        } else {
            char *v=NULL; int count=bcf_get_info_string(h->vcf,h->bcf,t,&v,&n);
            if (sample==0 && count>=0) { gs_bld_append(out,v,count); r=0; }
            free(v);
        }
    }
    free(t); return r;
}
static int string_count(Handle *h, const char *t, int format, const char *v) {
    int key=bcf_hdr_id2int(h->vcf,BCF_DT_ID,t), kind=format ? BCF_HL_FMT : BCF_HL_INFO;
    int length=bcf_hdr_id2length(h->vcf,kind,key), n=1;
    if (!*v) return 0;
    for (const char *p=v;*p;p++) {
        if (*p==',') { if (p==v || !p[1] || p[-1]==',') return 0; n++; }
        else if ((unsigned char)*p<=32 || *p==';' || *p==':' || *p=='=') return 0;
    }
    if (!strcmp(v,".")) return 1;
    int expected=length==BCF_VL_FIXED ? bcf_hdr_id2number(h->vcf,kind,key) :
                 length==BCF_VL_A ? h->bcf->n_allele-1 :
                 length==BCF_VL_R ? h->bcf->n_allele : -1;
    return length!=BCF_VL_G && (expected<0 || expected==n);
}
int32_t bio_bcf_set_string(int64_t id, Slice tag, _Bool format, Slice value) {
    Handle *h=get(id); char *t=copy(tag), *v=copy(value); int r=-1;
    if (v && field_type(h,t,format,BCF_HT_STR) && strcmp(t,"GT")) {
        if (!format && (!*v || string_count(h,t,0,v)))
            r=bcf_update_info_string(h->vcf,h->bcf,t,*v ? v : NULL);
        if (format) {
            int ns=bcf_hdr_nsamples(h->vcf), n=0; char **a=calloc(ns+1,sizeof(*a));
            if (a && ns>0) {
                char *start=v;
                for (char *p=v;;p++) if (*p=='\t' || !*p) {
                    int done=!*p; *p=0;
                    if (n>=ns || !string_count(h,t,1,start)) { n=-1; break; }
                    a[n++]=start; start=p+1; if (done) break;
                }
                if (n==ns) r=bcf_update_format_string(h->vcf,h->bcf,t,(const char **)a,n);
            }
            free(a);
        }
    }
    free(t); free(v); return r<0 ? -1 : 0;
}
int32_t bio_bcf_set_alleles(int64_t id, Slice alleles) {
    Handle *h=get(id); char *v=copy(alleles); int r=-1,n=1;
    if (!h || !h->valid || !h->variants || !v || !*v) goto done;
    for (char *p=v;*p;p++) {
        if (*p==',') { if (p==v || !p[1] || p[-1]==',') goto done; n++; }
        else if (*p=='*') {
            if (n==1 || p==v || p[-1]!=',' || (p[1] && p[1]!=',')) goto done;
        } else if (!strchr("ACGTNacgtn",*p)) goto done;
    }
    if (n!=h->bcf->n_allele) goto done;
    for (char *a=v;*a;) {
        size_t len=strcspn(a,",");
        for (char *b=a+len;*b;) {
            b++;
            size_t other=strcspn(b,",");
            if (len==other && !strncasecmp(a,b,len)) goto done;
            b+=other;
        }
        a+=len; if (*a) a++;
    }
    bcf1_t *b=bcf_dup(h->bcf);
    if (b) {
        r=bcf_update_alleles_str(h->vcf,b,v);
        if (r>=0) { bcf_destroy(h->bcf); h->bcf=b; } else bcf_destroy(b);
    }
done:
    free(v); return r<0 ? -1 : 0;
}
int32_t bio_bam_edit(int64_t id, Slice cigar, Slice seq, Slice qual) {
    Handle *h=alignment(id);
    if (!h || cigar.len<0 || cigar.len>INT_MAX/4 || seq.len<0 ||
        seq.len>INT_MAX || qual.len!=seq.len) return -1;
    const uint32_t *ops=(const uint32_t *)cigar.data;
    int64_t query=0, ref=0;
    for (int64_t i=0;i<cigar.len;i++) {
        unsigned op=ops[i]&15, len=ops[i]>>4;
        if (op>8 || !len) return -1;
        if (op==BAM_CHARD_CLIP && i!=0 && i!=cigar.len-1) return -1;
        if (op==BAM_CSOFT_CLIP && i!=0 && i!=cigar.len-1 &&
            !(i==1 && (ops[0]&15)==BAM_CHARD_CLIP) &&
            !(i==cigar.len-2 && (ops[cigar.len-1]&15)==BAM_CHARD_CLIP)) return -1;
        if (bam_cigar_type(op)&1) query+=len;
        if (bam_cigar_type(op)&2) ref+=len;
    }
    bam1_core_t *c=&h->bam->core;
    if (cigar.len && query!=seq.len) return -1;
    if (!(c->flag&BAM_FUNMAP) && (!cigar.len || !ref || c->tid<0 || c->pos<0 ||
        ref>sam_hdr_tid2len(h->sam,c->tid)-c->pos)) return -1;
    if (!valid_quality(qual)) return -1;
    for (int64_t i=0;i<seq.len;i++)
        if (!strchr("=ACMGRSVTWYHKDBN",seq.data[i]) || !seq.data[i]) return -1;
    bam1_t *b=bam_init1(); if (!b) return -1;
    int aux=bam_get_l_aux(h->bam);
    int r=bam_set1(b,strlen(bam_get_qname(h->bam)),bam_get_qname(h->bam),
        c->flag,c->tid,c->pos,c->qual,cigar.len,ops,c->mtid,c->mpos,c->isize,
        seq.len,(const char *)seq.data,(const char *)qual.data,aux);
    if (r>=0) {
        memcpy(bam_get_aux(b),bam_get_aux(h->bam),aux); b->l_data+=aux;
        b->id=h->bam->id; bam_destroy1(h->bam); h->bam=b;
    } else bam_destroy1(b);
    return r<0 ? -1 : 0;
}

int32_t bio_pileup_configure(int64_t id, int32_t depth, int32_t flags, int32_t mapq) {
    Handle *h=get(id);
    if (!h || h->writing || h->variants || h->pileup || depth<1 ||
        flags<0 || flags>65535 || mapq<0 || mapq>255) return -1;
    h->pile_configured=1; h->pile_max=depth; h->pile_flags=flags; h->pile_mapq=mapq;
    return 0;
}

static Pool *pool_get(int64_t id) {
    for (Pool *p=pools;p;p=p->next) if (p->id==id) return p;
    return NULL;
}
int64_t bio_hts_pool_open(int32_t threads) {
    if (threads<1 || threads>64 || serial==INT64_MAX) return 0;
    Pool *p=calloc(1,sizeof(*p)); if (!p) return 0;
    p->pool=hts_tpool_init(threads);
    if (!p->pool) { free(p); return 0; }
    p->id=-(++serial); p->next=pools; pools=p; return p->id;
}
int32_t bio_hts_pool_close(int64_t id) {
    Pool **p=&pools;
    while (*p && (*p)->id!=id) p=&(*p)->next;
    if (!*p) return -1;
    Pool *x=*p; if (x->refs) return -2;
    *p=x->next; hts_tpool_destroy(x->pool); free(x); return 0;
}
int32_t bio_hts_pool_attach(int64_t id, int64_t pool) {
    Handle *h=get(id); Pool *p=pool_get(pool);
    if (!h || !p || h->pool || h->used || h->valid || h->iter || h->pileup) return -1;
    htsThreadPool tp={p->pool,0};
    if (hts_set_thread_pool(h->file,&tp)<0) return -1;
    h->pool=p; p->refs++; return 0;
}
int32_t bio_bgzf_pool_attach(int64_t id, int64_t pool) {
    BlockHandle *b=block(id); Pool *p=pool_get(pool);
    if (!b || !p || b->pool || b->used) return -1;
    if (bgzf_thread_pool(b->file,p->pool,0)<0) return -1;
    b->pool=p; p->refs++; return 0;
}

typedef struct Sync {
    int64_t id; bcf_srs_t *sr; int started, failed, current;
    Pool *pool; struct Sync *next;
} Sync;
static Sync *syncs;
static Sync *sync_get(int64_t id) {
    for (Sync *s=syncs;s;s=s->next) if (s->id==id) return s;
    return NULL;
}
int64_t bio_hts_sync_open(int32_t pairing, Slice regions,
                         int32_t overlap, int64_t pool) {
    Pool *p=pool ? pool_get(pool) : NULL;
    if ((pool && !p) || (pairing!=64 && pairing!=4) ||
        overlap<0 || overlap>2 || serial==INT64_MAX) return 0;
    char *r=copy(regions); if (!r) return 0;
    Sync *s=calloc(1,sizeof(*s));
    if (!s) { free(r); return 0; }
    s->sr=bcf_sr_init();
    if (!s->sr) goto fail;
    if (bcf_sr_set_opt(s->sr,BCF_SR_REQUIRE_IDX)<0 ||
        bcf_sr_set_opt(s->sr,BCF_SR_PAIR_LOGIC,pairing)<0 ||
        bcf_sr_set_opt(s->sr,BCF_SR_REGIONS_OVERLAP,overlap)<0 ||
        (*r && bcf_sr_set_regions(s->sr,r,0)<0)) goto fail;
    s->pool=p; if (p) p->refs++;
    s->id=-(++serial); s->next=syncs; syncs=s;
    free(r); return s->id;
fail:
    if (s->sr) bcf_sr_destroy(s->sr);
    free(s); free(r); return 0;
}
int32_t bio_hts_sync_add(int64_t id, Slice path) {
    Sync *s=sync_get(id);
    if (!s || s->started || s->failed) return -1;
    char *p=copy(path);
    if (!p || !*p || !strcmp(p,"-") || strstr(p,"://")) {
        free(p); return -1;
    }
    struct stat st;
    if (stat(p,&st)<0 || !S_ISREG(st.st_mode)) { free(p); return -1; }
    htsFile *f=hts_open(p,"r");
    int good=0;
    if (f) {
        enum htsExactFormat fmt=hts_get_format(f)->format;
        good=(fmt==vcf || fmt==bcf) && hts_check_EOF(f)==1;
        if (hts_close(f)<0) good=0;
    }
    if (!good) { free(p); return -1; }
    int ok=bcf_sr_add_reader(s->sr,p); free(p);
    if (!ok) { s->failed=1; return -1; }
    if (s->pool) {
        htsThreadPool tp={s->pool->pool,0};
        if (hts_set_thread_pool(s->sr->readers[s->sr->nreaders-1].file,&tp)<0) {
            s->failed=1; return -1;
        }
    }
    return s->sr->nreaders-1;
}
int32_t bio_hts_sync_next(int64_t id) {
    Sync *s=sync_get(id);
    if (!s || s->failed || !s->sr->nreaders) return -1;
    s->started=1; s->current=0;
    int n=bcf_sr_next_line(s->sr);
    if (s->sr->errnum || n<0) { s->failed=1; return -1; }
    for (int i=0;i<s->sr->nreaders;i++) {
        bcf1_t *b=bcf_sr_get_line(s->sr,i);
        if (b && b->errcode) { s->failed=1; return -1; }
    }
    s->current=n>0; return n>0 ? 1 : 0;
}
static int sync_index(Sync *s, int32_t i) {
    return s && !s->failed && i>=0 && i<s->sr->nreaders;
}
int32_t bio_hts_sync_has_line(int64_t id, int32_t i) {
    Sync *s=sync_get(id); if (!sync_index(s,i)) return -1;
    return s->current && bcf_sr_has_line(s->sr,i) ? 1 : 0;
}
int64_t bio_hts_sync_position(int64_t id, int32_t i) {
    Sync *s=sync_get(id);
    if (!sync_index(s,i) || !s->current) return -1;
    bcf1_t *b=bcf_sr_get_line(s->sr,i); return b ? b->pos : -1;
}
int32_t bio_hts_sync_text(int64_t id, int32_t i, _Bool header, gs_rref out) {
    Sync *s=sync_get(id); if (!sync_index(s,i)) return -1;
    bcf_hdr_t *h=bcf_sr_get_header(s->sr,i);
    kstring_t k={0,0,NULL}; int r=-1;
    if (header) r=bcf_hdr_format(h,0,&k);
    else if (s->current) {
        bcf1_t *b=bcf_sr_get_line(s->sr,i);
        if (b) r=vcf_format(h,b,&k);
    }
    if (r>=0) gs_bld_append(out,k.s,k.l);
    free(k.s); return r<0 ? -1 : 0;
}
int32_t bio_hts_sync_close(int64_t id) {
    Sync **p=&syncs;
    while (*p && (*p)->id!=id) p=&(*p)->next;
    if (!*p) return -1;
    Sync *s=*p; *p=s->next;
    bcf_sr_destroy(s->sr);
    if (s->pool) s->pool->refs--;
    free(s); return 0;
}

/* Bound genotype vectors/ranks to one million entries before allocation. */
static int allele_choose(int n, int k) {
    int64_t v=1;
    if (k>n || k<0) return 0;
    if (k>n-k) k=n-k;
    for (int i=1;i<=k;i++) {
        v=v*(n-k+i)/i;
        if (v>1000000) return -1;
    }
    return (int)v;
}
/* Number=G uses VCF colexicographic unordered genotypes with repetition. Select original entries;
 * do not marginalize likelihoods, renormalize probabilities, or adjust phasing. */
static int allele_order(int n, int p, const int32_t *keep, int *out) {
    int count=allele_choose(n+p-1,p), a[16]={0};
    if (count<1 || p<1 || p>16) return -1;
    for (int i=0;i<count;i++) {
        int rank=0, sorted[16];
        for (int j=0;j<p;j++) sorted[j]=keep[a[j]];
        for (int j=1;j<p;j++) {
            int x=sorted[j], k=j;
            while (k && sorted[k-1]>x) { sorted[k]=sorted[k-1]; k--; }
            sorted[k]=x;
        }
        for (int j=0;j<p;j++) {
            int v=allele_choose(sorted[j]+j,j+1);
            if (v<0 || rank>1000000-v) return -1;
            rank+=v;
        }
        out[i]=rank;
        int j=0;
        while (j<p-1 && a[j]==a[j+1]) j++;
        a[j]++;
        for (int k=0;k<j;k++) a[k]=0;
    }
    return count;
}
/* Whole-field missing stays missing; other comma-separated vectors need exact cardinality and
 * nonempty elements. */
static char *allele_string(const char *s, int expected, int count,
                           const int *indices) {
    if (!strcmp(s,".")) return strdup(s);
    char *tmp=strdup(s), **parts=calloc(expected+1,sizeof(*parts));
    kstring_t out={0,0,NULL}; int n=0;
    if (!tmp || !parts) goto fail;
    parts[n++]=tmp;
    for (char *p=tmp;*p;p++) if (*p==',') {
        *p=0;
        if (n>=expected) goto fail;
        parts[n++]=p+1;
    }
    if (n!=expected) goto fail;
    for (int i=0;i<n;i++) if (!*parts[i]) goto fail;
    for (int i=0;i<count;i++) {
        if (i && kputc(',',&out)<0) goto fail;
        if (kputs(parts[indices[i]],&out)<0) goto fail;
    }
    free(tmp); free(parts); return out.s;
fail:
    free(tmp); free(parts); free(out.s); return NULL;
}
/* REF stays fixed; reject REF-only selection, new alleles, stars, symbolic alleles, and breakends.
 * Only A/C/G/T/N alleles qualify; this operation does not normalize or change coordinates. */
int32_t bio_hts_copy_variant_alleles(int64_t source, int64_t destination,
        Slice selection, int32_t removed, int32_t stale, int32_t ploidy, _Bool recompute) {
    Handle *h=get(source);
    const int32_t *keep=(const int32_t *)selection.data;
    int m=(int)selection.len, result=-1;
    if (!h || !h->variants || !h->valid || h->bcf->errcode ||
        selection.len<2 || selection.len>128 || !keep || keep[0]!=0 ||
        removed<0 || removed>1 || stale<0 || stale>2 ||
        ploidy<0 || ploidy>16) return -1;
    bcf1_t *b=bcf_dup(h->bcf);
    bcf_hdr_t *hdr=h->vcf;
    int32_t *gt=NULL; int ngt=0, cap=0, *inverse=NULL, *ps=NULL;
    if (!b || bcf_unpack(b,BCF_UN_ALL)<0 || b->errcode) goto done;
    int n=b->n_allele, ns=bcf_hdr_nsamples(hdr);
    if (n>128 || b->n_sample!=ns) goto done;
    inverse=malloc(n*sizeof(*inverse)); ps=calloc(ns+1,sizeof(*ps));
    if (!inverse || !ps) goto done;
    for (int i=0;i<n;i++) {
        inverse[i]=-1;
        if (!*b->d.allele[i] || strspn(b->d.allele[i],"ACGTNacgtn")!=strlen(b->d.allele[i])) goto done;
    }
    for (int i=0;i<m;i++) {
        if (keep[i]<0 || keep[i]>=n || inverse[keep[i]]!=-1) goto done;
        inverse[keep[i]]=i;
    }
    /* GT lengths include missing alleles but exclude vector ends. FORMAT samples may differ in
     * ploidy; an explicit value must agree with every available GT. Cardinality never infers ploidy. */
    ngt=bcf_get_genotypes(hdr,b,&gt,&cap);
    if (ngt>0) {
        if (!ns || ngt%ns) goto done;
        int width=ngt/ns;
        for (int s=0;s<ns;s++) {
            int ended=0;
            for (int j=0;j<width;j++) {
                int32_t *v=&gt[s*width+j];
                if (*v==bcf_int32_vector_end) { ended=1; continue; }
                if (ended || *v<0 || ps[s]>=16) goto done;
                ps[s]++;
                if (bcf_gt_is_missing(*v)) continue;
                int old=bcf_gt_allele(*v);
                if (old>=n) goto done;
                if (inverse[old]<0) {
                    if (!removed) goto done;
                    *v=(*v&1);
                } else *v=((inverse[old]+1)<<1)|(*v&1);
            }
            if (!ps[s] || (ploidy && ploidy!=ps[s])) goto done;
        }
        if (bcf_update_genotypes(hdr,b,gt,ngt)<0) goto done;
    } else if (ngt!=-3 && ngt!=-1) goto done;
    /* INFO inference requires uniform source GT lengths; absent or mixed GT needs explicit ploidy. */
    int info_ploidy=ploidy;
    if (!info_ploidy && ns && ps[0]) {
        info_ploidy=ps[0];
        for (int s=1;s<ns;s++) if (ps[s]!=info_ploidy) {
            info_ploidy=0; break;
        }
    }
    /* Stale policy also covers flags and FILTER: dropping clears filters; rejecting allows PASS only.
     * Retaining annotations does not establish their biological validity after selection. */
    for (int i=0;i<b->d.n_flt;i++) {
        const char *filter=bcf_hdr_int2id(hdr,BCF_DT_ID,b->d.flt[i]);
        if (strcmp(filter,"PASS") && stale==2) goto done;
    }
    if (stale==1 && bcf_update_filter(hdr,b,NULL,0)<0) goto done;
    /* Integer/float/string A/R/G fields need exact source cardinality, except whole-field missing.
     * Preserve float bits and missing/vector-end distinctions; FORMAT padding is trailing only.
     * Snapshot descriptors because updates can relocate decoded arrays. */
    for (int kind=BCF_HL_INFO;kind<=BCF_HL_FMT;kind++) {
        int fmt=kind==BCF_HL_FMT, fields=fmt ? b->n_fmt : b->n_info;
        int *ids=malloc((fields+1)*sizeof(*ids));
        if (!ids) goto done;
        for (int i=0;i<fields;i++) ids[i]=fmt ? b->d.fmt[i].id : b->d.info[i].key;
        int ok=1;
        for (int i=0;i<fields && ok;i++) {
            int id=ids[i], len=bcf_hdr_id2length(hdr,kind,id);
            int type=bcf_hdr_id2type(hdr,kind,id);
            const char *tag=bcf_hdr_int2id(hdr,BCF_DT_ID,id);
            if ((fmt && !strcmp(tag,"GT")) ||
                (recompute && !fmt && (!strcmp(tag,"AC") || !strcmp(tag,"AN") || !strcmp(tag,"AF")))) continue;
            if (len!=BCF_VL_A && len!=BCF_VL_R && len!=BCF_VL_G) {
                if (stale==2) { ok=0; break; }
                if (stale==1 && (fmt ? bcf_update_format(hdr,b,tag,NULL,0,type) : bcf_update_info(hdr,b,tag,NULL,0,type))<0) ok=0;
                continue;
            }
            int rows=fmt ? ns : 1, max=0, *sizes=calloc(rows+1,sizeof(int));
            int **maps=calloc(rows+1,sizeof(int *));
            if (!sizes || !maps) { free(sizes); free(maps); ok=0; break; }
            for (int r=0;r<rows && ok;r++) {
                int p=fmt ? (ps[r] ? ps[r] : ploidy) : info_ploidy;
                int old=len==BCF_VL_A ? n-1 : len==BCF_VL_R ? n : p ? allele_choose(n+p-1,p) : -1;
                int num=len==BCF_VL_A ? m-1 : len==BCF_VL_R ? m : p ? allele_choose(m+p-1,p) : -1;
                if (old<1 || num<1) { ok=0; break; }
                sizes[r]=old; if (num>max) max=num;
                maps[r]=malloc((num+1)*sizeof(int));
                if (!maps[r]) { ok=0; break; }
                if (len==BCF_VL_G) { if (allele_order(m,p,keep,maps[r])!=num) ok=0; }
                else for (int j=0;j<num;j++) maps[r][j]=keep[j+(len==BCF_VL_A)]-(len==BCF_VL_A);
            }
            if (ok && (type==BCF_HT_INT || type==BCF_HT_REAL)) {
                void *raw=NULL; int capacity=0;
                int count=fmt ? bcf_get_format_values(hdr,b,tag,&raw,&capacity,type) : bcf_get_info_values(hdr,b,tag,&raw,&capacity,type);
                uint32_t *in=raw, *out=malloc((size_t)(rows+1)*max*4);
                if (count<=0 || !rows || count%rows || !out) ok=0;
                int width=rows ? count/rows : 0;
                uint32_t end=type==BCF_HT_INT ? (uint32_t)bcf_int32_vector_end : bcf_float_vector_end;
                uint32_t missing=type==BCF_HT_INT ? (uint32_t)bcf_int32_missing : bcf_float_missing;
                for (int r=0;r<rows && ok;r++) {
                    int used=0;
                    while (used<width && in[r*width+used]!=end) used++;
                    for (int j=used;j<width;j++) if (in[r*width+j]!=end) ok=0;
                    int whole=used==1 && in[r*width]==missing;
                    if (!whole && used!=sizes[r]) { ok=0; break; }
                    int p=fmt ? (ps[r] ? ps[r] : ploidy) : info_ploidy;
                    int num=len==BCF_VL_A ? m-1 : len==BCF_VL_R ? m : allele_choose(m+p-1,p);
                    for (int j=0;j<max;j++) out[r*max+j]=j>=num || (whole && j) ? end : whole ? missing : in[r*width+maps[r][j]];
                }
                if (ok && (fmt ? bcf_update_format(hdr,b,tag,out,rows*max,type) : bcf_update_info(hdr,b,tag,out,max,type))<0) ok=0;
                free(raw); free(out);
            } else if (ok && type==BCF_HT_STR) {
                char **strings=NULL, *str=NULL; int capacity=0;
                int count=fmt ? bcf_get_format_string(hdr,b,tag,&strings,&capacity) : bcf_get_info_string(hdr,b,tag,&str,&capacity);
                char **out=calloc(rows+1,sizeof(*out));
                if (count<0 || !out) ok=0;
                for (int r=0;r<rows && ok;r++) {
                    int p=fmt ? (ps[r] ? ps[r] : ploidy) : info_ploidy;
                    int num=len==BCF_VL_A ? m-1 : len==BCF_VL_R ? m : allele_choose(m+p-1,p);
                    out[r]=allele_string(fmt ? strings[r] : str,sizes[r],num,maps[r]);
                    if (!out[r]) ok=0;
                }
                if (ok && (fmt ? bcf_update_format_string(hdr,b,tag,(const char **)out,rows) : bcf_update_info_string(hdr,b,tag,out[0]))<0) ok=0;
                if (out) { for (int r=0;r<rows;r++) free(out[r]); free(out); }
                if (strings) { free(strings[0]); free(strings); } free(str);
            } else if (ok) ok=0;
            for (int r=0;r<rows;r++) free(maps[r]);
            free(maps); free(sizes);
        }
        free(ids); if (!ok) goto done;
    }
    const char *alleles[128];
    for (int i=0;i<m;i++) alleles[i]=b->d.allele[keep[i]];
    if (bcf_update_alleles(hdr,b,alleles,m)<0) goto done;
    result=copy_variant_mapped(source,destination,b,recompute);
done:
    free(gt); free(inverse); free(ps); bcf_destroy(b); return result;
}
