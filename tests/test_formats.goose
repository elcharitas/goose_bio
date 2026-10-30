import bio from "..";
import bio.io.formats;
fn main() {
    let fasta = bio::parse_fasta(">id description\r\nACG\r\nTN\r\n>two\nGG\n");
    assert(fasta.error.len == 0 && fasta.records.len == 2);
    let written = bio::write_fasta(fasta.records, 2);
    assert(written.text == ">id description\nAC\nGT\nN\n>two\nGG\n");
    assert(bio::parse_fasta("ACG").error.len > 0);
    assert(bio::parse_fasta(">id\n").error.len > 0);
    assert(bio::write_fasta(fasta.records, 0).error.len > 0);
    let fastq = bio::parse_fastq("@id\r\nAC\r\nGT\r\n+id\r\n!@\r\n+#\r\n");
    assert(fastq.error.len == 0 && fastq.records.len == 1);
    assert(bio::write_fastq(fastq.records).text == "@id\nACGT\n+\n!@+#\n");
    assert(bio::parse_fastq("@id\nAC\n+\n!\n").error.len > 0);
    assert(bio::parse_fastq("@id\nAC\n+bad\n!!\n").error.len > 0);
    assert(bio::parse_fastq("@id\nAC\n+\n!!!\n").error.len > 0);
    assert(bio::parse_bed("chr1\t0\t10\tname\n").rows.len == 1);
    assert(bio::parse_bed("chr1\t10\t9").error.len > 0);
    assert(bio::parse_gff("chr1\tsrc\tgene\t1\t5\t.\t+\t.\tID=x\n##FASTA\n>chr1\nA").rows.len == 1);
    assert(bio::parse_gff("chr1\tsrc\tgene\t0\t5\t.\t+\t.\tID=x").error.len > 0);
    assert(bio::parse_vcf("##fileformat=VCFv4.2\nchr1\t1\t.\tA\tG\t.\tPASS\t.").rows.len == 1);
    assert(bio::parse_vcf("chr1\tx\t.\tA\tG\t.\tPASS\t.").error.len > 0);
    assert(bio::parse_sam("@HD\tVN:1.6\nr\t0\tchr1\t1\t60\t2M\t*\t0\t0\tAC\t!!").rows.len == 1);
    assert(bio::parse_sam("r\t0\tchr1\t1\t256\t2M\t*\t0\t0\tAC\t!!").error.len > 0);
    assert(bio::parse_fasta(">id\nAC>G\n").error.len > 0);
    assert(bio::parse_fastq("@id\nAC+G\n+\n!!!!\n").error.len > 0);
    print("format assertions passed");
}
