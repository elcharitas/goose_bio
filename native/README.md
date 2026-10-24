# HTS files

Read, write, and query SAM/BAM/CRAM and VCF/BCF files through `HTSlib` 1.21.
The pure `bio` library does not require this adapter.

From the repository root:

```sh
native/setup_hts.sh
export LIBRARY_PATH="$PWD/.tools/htslib-1.21"
```

Setup needs a C toolchain, make, curl, tar, `shasum`, and `zlib`.

```goose
import bio from "..";
import bio.hts;
import hts from "..";
```

Use `bio::hts_open`, `hts_next`, and `hts_close` to process records.
A zero handle means open failed; `hts_next` returns 1 for a record,
0 for EOF, and -1 for an error. Close every handle explicitly.

Calls are synchronous and main-thread-only. Files must be local; CRAM needs
an explicit reference FASTA. Failed writes can leave partial output.

Use `hts_copy_variant_alleles` for allele selection and genotype remapping.
Use `fastx_open`, `fastx_next`, and `fastx_close` for plain or gzip FASTA/FASTQ.

See [API comments](../hts.goose) and [dependency notices](../docs/DEPENDENCIES.md).
