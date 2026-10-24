/* Copyright Jonathan Irhodia. */
#include <assert.h>
#include "hts_adapter.c"

static const char *src="@HD\tVN:1.6\tSO:unsorted\n@SQ\tSN:a\tLN:100\tM5:abc\n@SQ\tSN:b\tLN:200\n@RG\tID:r\tSM:sample\tPG:p\n@PG\tID:p\tPP:q\n@PG\tID:q\tPN:tool\n";
static const char *dst="@HD\tVN:1.6\tSO:unsorted\n@SQ\tSN:b\tLN:200\n@SQ\tSN:a\tLN:100\tM5:abc\n@RG\tID:r\tSM:sample\tPG:p\n@PG\tID:p\tPP:q\n@PG\tID:q\tPN:tool\n";
static Slice slice(const char *s) { return (Slice){(const unsigned char *)s,strlen(s)}; }
static void trial(const char *header, const char *line, int expected,
                  int tid, int mtid, const char *mode) {
    static int number;
    char path[128]; snprintf(path,sizeof(path),".tools/alignment-oracle-%d.%s",number++,mode[1]=='b' ? "bam" : "sam");
    Handle source={0}; source.id=INT64_MAX; source.sam=sam_hdr_parse(strlen(src),src);
    source.bam=bam_init1(); source.valid=1; source.next=handles; handles=&source;
    kstring_t text={0,0,NULL}; kputs(line,&text);
    assert(sam_parse1(&text,source.sam,source.bam)>=0); free(text.s);
    source.bam->id=123456;
    bam1_t *before=bam_dup1(source.bam);
    int64_t out=bio_hts_open(slice(path),slice(mode),0,slice(header),slice(""));
    assert(out>0);
    assert(bio_hts_copy_alignment_mapped(out,out)==-1);
    assert(bio_hts_copy_alignment_mapped(source.id,source.id)==-1);
    source.valid=0;
    assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
    source.valid=1;
    uint8_t *array=bam_aux_get(source.bam,"ZZ");
    if (array && *array=='B') {
        uint8_t counts[4]; memcpy(counts,array+2,4);
        memset(array+2,255,4);
        assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
        assert(!memcmp(array+2,"\xff\xff\xff\xff",4));
        memcpy(array+2,counts,4);
    }
    int saved=source.bam->core.tid;
    source.bam->core.tid=-2;
    assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
    source.bam->core.tid=9999;
    assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
    source.bam->core.tid=saved;
    saved=source.bam->core.mtid; source.bam->core.mtid=-2;
    assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
    source.bam->core.mtid=saved;
    source.variants=1;
    assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
    source.variants=0;
    assert(bio_hts_copy_alignment_mapped(source.id,out)==expected);
    assert(!memcmp(&before->core,&source.bam->core,sizeof(before->core)));
    assert(before->id==source.bam->id && before->l_data==source.bam->l_data);
    assert(!memcmp(before->data,source.bam->data,before->l_data));
    assert(bio_hts_close(out)==0);
    assert(bio_hts_copy_alignment_mapped(source.id,out)==-1);
    samFile *f=sam_open(path,"r"); assert(f);
    sam_hdr_t *h=sam_hdr_read(f); bam1_t *read=bam_init1();
    if (expected==0) {
        assert(sam_read1(f,h,read)>=0);
        assert(read->core.tid==tid && read->core.mtid==mtid);
        read->core.tid=before->core.tid; read->core.mtid=before->core.mtid;
        assert(!memcmp(&read->core,&before->core,sizeof(read->core)));
        assert(read->l_data==before->l_data);
        assert(!memcmp(read->data,before->data,read->l_data));
    }
    assert(sam_read1(f,h,read)==-1);
    sam_close(f); sam_hdr_destroy(h); bam_destroy1(read); bam_destroy1(before);
    handles=source.next; sam_hdr_destroy(source.sam); bam_destroy1(source.bam);
}
int main(void) {
    const char *record="x\t1\ta\t5\t23\t1H1S1M1I1D1N1P1=1X1S1H\tb\t8\t-9\tACGTAC\t*\tRG:Z:r\tPG:Z:p\tZZ:B:i,-1,0,123\tZF:B:f,1.5,-2.25\tZS:Z:hello\tZH:H:abcd\tSA:Z:a,1,+,1M,2,0;\tXA:Z:b,+1,1M,0;\tOA:Z:a,1,+,1M,2,0;";
    for (int i=0;i<2;i++) {
        const char *mode=i ? "wb" : "w";
        trial(dst,record,0,1,0,mode);
        trial(dst,"q\t1\tb\t1\t0\t2M\ta\t2\t0\tAC\t!I\tZF:f:1.25",0,0,1,mode);
        char conflict[1024]; strcpy(conflict,dst);
        char *sm=strstr(conflict,"SM:sample"); sm[3]='X';
        trial(conflict,record,-1,0,0,mode);
        strcpy(conflict,dst); char *pp=strstr(conflict,"PP:q"); pp[3]='p';
        trial(conflict,record,-1,0,0,mode);
        strcpy(conflict,dst); char *ln=strstr(conflict,"LN:200"); ln[3]='3';
        trial(conflict,record,-1,0,0,mode);
        trial("@SQ\tSN:a\tLN:100\tM5:abc\n",record,-1,0,0,mode);
        trial(dst,"u\t4\ta\t1\t0\t*\tb\t2\t0\t*\t*",0,1,0,mode);
        trial(dst,"u\t4\t*\t0\t0\t*\t*\t0\t0\t*\t*",0,-1,-1,mode);
        trial("@HD\tSO:coordinate\n@SQ\tSN:b\tLN:200\n@SQ\tSN:a\tLN:100\tM5:abc\n",record,-1,0,0,mode);
        trial("@SQ\tSN:a\tLN:100\n@SQ\tSN:b\tLN:200\n",record,-1,0,0,mode);
        trial("@SQ\tSN:z\tAN:a\tLN:100\tM5:abc\n@SQ\tSN:b\tLN:200\n",record,-1,0,0,mode);
        trial(dst,"u\t4\t*\t0\t0\t*\t*\t0\t0\t*\t*\tRG:i:1",-1,0,0,mode);
        trial(dst,"u\t4\t*\t0\t0\t*\t*\t0\t0\t*\t*\tPG:Z:unknown",-1,0,0,mode);
    }
    assert(bio_hts_copy_alignment_mapped(-1,-1)==-1);
    puts("native alignment golden and semantic reopen passed");
}
