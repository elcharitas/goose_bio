import hts from "..";
import bio from "..";
import os;

fn main() {
    let arguments = args();
    if arguments.len != 2 {
        write_stderr("usage: stream_fastx <local FASTA/FASTQ path>\n");
        exit(2);
    }
    let handle = bio::fastx_open(arguments[1]);
    if handle == 0 { write_stderr("cannot open sequence input\n"); exit(1); }
    var records: i64 = 0;
    var bases:   i64 = 0;
    var status:  i32 = 1;
    while status == 1 {
        status = bio::fastx_next(handle);
        if status == 1 {
            var sequence: u8[>..] = [];
            if bio::fastx_field(handle, 2, sequence) != 0 {
                status = -1;
            } else { records++; bases += sequence.len; }
        }
    }
    let closed = bio::fastx_close(handle);
    if status < 0 || closed != 0 {
        write_stderr("invalid record or input read failure\n"); exit(1);
    }
    print("records=", records, " bases=", bases);
}
