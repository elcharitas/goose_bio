# Goose Bio

Computational biology and `bioinformatics` for
[Goose](https://aardappel.github.io/goose/), v2026.3.
Goose Bio provides sequence analysis, file parsing, alignment, search, statistics,
structure analysis, and tree operations.
`Biopython`, Rust-Bio, and rust-htslib inspired this work.

## Run an example

```sh
goose run examples/analyze.goose
```

## Use the library

```goose
import bio from "../goose_bio";

fn main() {
    let protein = bio::translate("ATGGCTTAA");
    assert(protein.error.len == 0);
    print(protein.value);

    let alignment = bio::affine_alignment("ACGT", "AGT");
    print(alignment.a_aligned, "\n", alignment.b_aligned);
}
```

The root entry exports the pure APIs in namespace `bio`.
Source declarations document coordinates, defaults, ownership, errors, and bounds.

## Source layout

| Folder | Contents |
| --- | --- |
| [sequence](sequence/) | Sequences, genetic codes, annotations, records, protein and restriction analysis |
| [Formats](io/) | Sequence, alignment, annotation, search, and specialist text formats |
| [alignment](alignment/) | Pairwise, matrix, partial-order, sparse, and `frameshift` alignment |
| [search](search/) | Matching, motifs, suffix arrays, FM/FMD indexes, and exact matches |
| [stats](stats/) | Probability, HMM models, PairHMM models, Bayesian analysis, and clustering |
| [structure](structure/) | PDB/mmCIF, hierarchy, coordinate transforms, and SCOP/RAF |
| [Trees](phylo/) | Tree parsing, reconstruction, tree analysis, and consensus |
| [collections](collections/) | Intervals, trees, rank/select, packed values, and wavelet structures |
| [analysis](analysis/) | Phenotype well operations and SVG genome diagrams |
| [native](native/) | Optional sequencing and variant file adapters |
| [net](net/) | Optional HTTP and biological service clients |
| [index](index/) | Optional persistent FASTA indexing |

Explicit module imports follow the folder layout, for example
`import bio.sequence.records;` or `import bio.stats.hmm_estimation;`.
Runnable programs are in [examples](examples/).

## Optional native packages

HTS needs external `HTSlib` 1.21 headers and libraries:

```sh
native/setup_hts.sh
```

Consumers activate the sidecar explicitly:

```goose
import bio from "../goose_bio";
import hts from "../goose_bio";
import bio.hts;
```

The [HTS API](hts.goose) documents statuses, handles, codecs, and record behavior.
The HTTP package uses system libcurl; the index package uses SQLite and macOS
CommonCrypto. See [net](net/README.md) and [index](index/README.md) for setup.

## License

Original source uses the [MIT license](LICENSE).
`Copyright (c) 2026 Jonathan Irhodia`.
[Dependency notices](docs/DEPENDENCIES.md) retain applicable license terms.
