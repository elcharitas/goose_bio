#include "goose.h"
#include <sqlite3.h>
#include <CommonCrypto/CommonDigest.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#define CAP (64*1024*1024)
typedef struct { const unsigned char *data; int64_t len; } Slice;
typedef struct H { int64_t id; sqlite3 *db; FILE *f; char *path; char digest[65]; struct stat st; struct H *next; } H;
static H *handles;
static int64_t serial;
static char *string(Slice s) {
    if(s.len<=0 || s.len>PATH_MAX || memchr(s.data,0,s.len)) return NULL;
    char *p=malloc(s.len+1); if(p){memcpy(p,s.data,s.len);p[s.len]=0;} return p;
}
static int fingerprint(FILE *f, struct stat *st, char out[65]) {
    struct stat end; unsigned char b[65536], digest[32]; size_t n;
    if(fstat(fileno(f),st) || !S_ISREG(st->st_mode) || fseeko(f,0,SEEK_SET)) return 0;
    CC_SHA256_CTX ctx; CC_SHA256_Init(&ctx);
    while((n=fread(b,1,sizeof b,f))) CC_SHA256_Update(&ctx,b,(CC_LONG)n);
    if(ferror(f) || fstat(fileno(f),&end) || st->st_size!=end.st_size ||
       st->st_mtimespec.tv_sec!=end.st_mtimespec.tv_sec || st->st_mtimespec.tv_nsec!=end.st_mtimespec.tv_nsec) return 0;
    CC_SHA256_Final(digest,&ctx);
    for(int i=0;i<32;i++) sprintf(out+2*i,"%02x",digest[i]);
    return fseeko(f,0,SEEK_SET)==0;
}
static ssize_t bounded_line(FILE *f,char **line,size_t *cap) {
    size_t n=0;int c;
    while((c=fgetc(f))!=EOF){
        if(n==CAP)return -2;
        if(n+1>=*cap){size_t next=*cap?*cap*2:4096;if(next>CAP+1)next=CAP+1;char *p=realloc(*line,next);if(!p)return -2;*line=p;*cap=next;}
        (*line)[n++]=(char)c;if(c=='\n')break;
    }
    if(!n)return ferror(f)?-2:-1;
    return (ssize_t)n;
}
static int same(struct stat *a, struct stat *b) {return a->st_dev==b->st_dev && a->st_ino==b->st_ino;}
static H *get(int64_t id) {for(H *h=handles;h;h=h->next)if(h->id==id)return h;return NULL;}
static int fresh(H *h) {
    struct stat now,path; char digest[65];
    return !stat(h->path,&path) && same(&path,&h->st) && fingerprint(h->f,&now,digest) &&
      now.st_size==h->st.st_size && now.st_mtimespec.tv_sec==h->st.st_mtimespec.tv_sec &&
      now.st_mtimespec.tv_nsec==h->st.st_mtimespec.tv_nsec && !strcmp(digest,h->digest);
}
static int exec(sqlite3 *d,const char *s){return sqlite3_exec(d,s,NULL,NULL,NULL)==SQLITE_OK;}
static int insert(sqlite3 *d, char *key, int64_t start,int64_t end) {
    sqlite3_stmt *s=NULL; int ok=0;
    if(end-start>CAP) return 0;
    if(sqlite3_prepare_v2(d,"INSERT INTO records VALUES(?,?,?)",-1,&s,NULL)==SQLITE_OK){
      sqlite3_bind_text(s,1,key,-1,SQLITE_TRANSIENT);sqlite3_bind_int64(s,2,start);sqlite3_bind_int64(s,3,end-start);ok=sqlite3_step(s)==SQLITE_DONE;
    } sqlite3_finalize(s);return ok;
}
int32_t bio_index_build(Slice source,Slice target) {
    char *sp=string(source),*tp=string(target),*path=NULL,*tmp=NULL,*line=NULL,*key=NULL;
    FILE *f=NULL;sqlite3 *d=NULL;size_t cap=0;struct stat st,other,after;char hash[65],hash2[65];int ok=0,fd=-1;
    if(!sp||!tp || !(path=realpath(sp,NULL)) || !(f=fopen(path,"rb")) || !fingerprint(f,&st,hash))goto done;
    if(!stat(tp,&other) && same(&st,&other))goto done;
    tmp=malloc(strlen(tp)+16);if(!tmp)goto done;sprintf(tmp,"%s.tmp.XXXXXX",tp);
    fd=mkstemp(tmp);if(fd<0)goto done;close(fd);fd=-1;
    if(sqlite3_open(tmp,&d)!=SQLITE_OK || !exec(d,"BEGIN; CREATE TABLE records(key TEXT PRIMARY KEY, start INTEGER NOT NULL, length INTEGER NOT NULL); CREATE TABLE meta(version INTEGER,path TEXT,size INTEGER,mtime INTEGER,nsec INTEGER,hash TEXT);"))goto done;
    int64_t start=0;ssize_t n;int64_t pos=0;
    while((n=bounded_line(f,&line,&cap))>=0){
      if(n>CAP || memchr(line,0,n))goto done;
      size_t len=n;if(len&&line[len-1]=='\n')len--;if(len&&line[len-1]=='\r'){if(!n||line[n-1]!='\n')goto done;len--;}
      if(len && line[0]=='>'){
        if(key && !insert(d,key,start,pos))goto done;
        free(key);key=NULL;start=pos;size_t end=1;
        while(end<len && line[end]!=' '&&line[end]!='\t')end++;
        if(end==1 || end-1>PATH_MAX)goto done;
        for(size_t i=1;i<len;i++)if(((unsigned char)line[i]<32 && line[i]!='\t') || (unsigned char)line[i]>126)goto done;
        key=strndup(line+1,end-1);if(!key)goto done;
      }else{
        if(!key)goto done;
        for(size_t i=0;i<len;i++)if(!((line[i]>='A'&&line[i]<='Z')||(line[i]>='a'&&line[i]<='z')||strchr("*-?.",line[i])))goto done;
      }
      pos=ftello(f);if(pos<0 || (key && pos-start>CAP))goto done;
    }
    if(n==-2 || ferror(f) || (key&&!insert(d,key,start,pos)) || !fingerprint(f,&after,hash2) || strcmp(hash,hash2))goto done;
    sqlite3_stmt *m=NULL;
    if(sqlite3_prepare_v2(d,"INSERT INTO meta VALUES(1,?,?,?,?,?)",-1,&m,NULL)!=SQLITE_OK)goto done;
    sqlite3_bind_text(m,1,path,-1,SQLITE_STATIC);sqlite3_bind_int64(m,2,st.st_size);sqlite3_bind_int64(m,3,st.st_mtimespec.tv_sec);sqlite3_bind_int64(m,4,st.st_mtimespec.tv_nsec);sqlite3_bind_text(m,5,hash,-1,SQLITE_STATIC);
    ok=sqlite3_step(m)==SQLITE_DONE;sqlite3_finalize(m);if(!ok)goto done;ok=0;
    if(!exec(d,"COMMIT"))goto done;
    sqlite3_close(d);d=NULL;
    if(!stat(tp,&other)&&same(&st,&other))goto done;
    ok=rename(tmp,tp)==0;
 done:
    if(d)sqlite3_close(d);if(f)fclose(f);if(tmp){if(!ok)unlink(tmp);free(tmp);}free(sp);free(tp);free(path);free(line);free(key);return ok?0:-1;
}
int64_t bio_index_open(Slice target) {
    char *tp=string(target);H *h=calloc(1,sizeof *h);sqlite3_stmt *s=NULL;int ok=0;
    if(!tp||!h||serial==INT64_MAX)goto done;
    if(sqlite3_open_v2(tp,&h->db,SQLITE_OPEN_READONLY,NULL)!=SQLITE_OK)goto done;
    if(sqlite3_prepare_v2(h->db,"SELECT version,path,size,mtime,nsec,hash FROM meta",-1,&s,NULL)!=SQLITE_OK || sqlite3_step(s)!=SQLITE_ROW || sqlite3_column_int(s,0)!=1)goto done;
    const char *p=(const char*)sqlite3_column_text(s,1),*hash=(const char*)sqlite3_column_text(s,5);
    if(!p||p[0]!='/'||!hash||strlen(hash)!=64)goto done;
    h->path=strdup(p);if(!h->path || !(h->f=fopen(p,"rb")) || fstat(fileno(h->f),&h->st))goto done;
    if(h->st.st_size!=sqlite3_column_int64(s,2)||h->st.st_mtimespec.tv_sec!=sqlite3_column_int64(s,3)||h->st.st_mtimespec.tv_nsec!=sqlite3_column_int64(s,4))goto done;
    strcpy(h->digest,hash);if(sqlite3_step(s)!=SQLITE_DONE || !fresh(h))goto done;
    sqlite3_finalize(s);s=NULL;
    if(sqlite3_prepare_v2(h->db,"SELECT key,start,length FROM records LIMIT 0",-1,&s,NULL)!=SQLITE_OK)goto done;
    sqlite3_finalize(s);s=NULL;h->id=++serial;h->next=handles;handles=h;ok=1;
 done:
    sqlite3_finalize(s);free(tp);if(ok)return h->id;
    if(h){if(h->db)sqlite3_close(h->db);if(h->f)fclose(h->f);free(h->path);free(h);}return 0;
}
int32_t bio_index_close(int64_t id){H **p=&handles;while(*p&&(*p)->id!=id)p=&(*p)->next;if(!*p)return -1;H *h=*p;*p=h->next;sqlite3_close(h->db);fclose(h->f);free(h->path);free(h);return 0;}
int64_t bio_index_count(int64_t id){H *h=get(id);sqlite3_stmt *s=NULL;int64_t n=-1;if(!h||!fresh(h))return -1;if(sqlite3_prepare_v2(h->db,"SELECT count(*) FROM records",-1,&s,NULL)==SQLITE_OK&&sqlite3_step(s)==SQLITE_ROW)n=sqlite3_column_int64(s,0);sqlite3_finalize(s);return n;}
int32_t bio_index_copy(int64_t id,Slice key,int64_t ordinal,int32_t mode,gs_rref out){
 H *h=get(id);sqlite3_stmt *s=NULL;char *k=NULL;unsigned char *b=NULL;int result=-1;
 if(!h||!fresh(h))return -1;
 const char *sql=mode==1?"SELECT key FROM records ORDER BY start LIMIT 1 OFFSET ?":"SELECT start,length FROM records WHERE key=?";
 if(sqlite3_prepare_v2(h->db,sql,-1,&s,NULL)!=SQLITE_OK)goto done;
 if(mode==1){if(ordinal<0)goto done;sqlite3_bind_int64(s,1,ordinal);}else{ k=string(key);if(!k)goto done;sqlite3_bind_text(s,1,k,-1,SQLITE_STATIC);}
 if(sqlite3_step(s)!=SQLITE_ROW)goto done;
 if(mode==1){const void *v=sqlite3_column_blob(s,0);int n=sqlite3_column_bytes(s,0);for(int i=0;i<n;i++){uint8_t c=((uint8_t*)v)[i];gs_bld_append(out,&c,1);}result=0;}
 else{int64_t start=sqlite3_column_int64(s,0),n=sqlite3_column_int64(s,1);if(start<0||n<0||n>CAP||start>h->st.st_size-n)goto done;b=malloc(n?n:1);if(!b||fseeko(h->f,start,SEEK_SET)||fread(b,1,n,h->f)!=(size_t)n||!fresh(h))goto done;size_t kl=strlen(k);if(n<(int64_t)kl+1||b[0]!='>'||memcmp(b+1,k,kl)||(n>(int64_t)kl+1 && !(b[kl+1]==' '||b[kl+1]=='\t'||b[kl+1]=='\r'||b[kl+1]=='\n')))goto done;
 for(int64_t i=0;i<n;i++)gs_bld_append(out,b+i,1);result=0;}
 done:sqlite3_finalize(s);free(k);free(b);return result;
}
