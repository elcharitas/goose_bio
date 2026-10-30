# Dependency notices

Goose Bio source uses the MIT license in the repository root.

The optional native adapter downloads and builds `HTSlib` 1.21.
[HTSLIB_LICENSE.txt](HTSLIB_LICENSE.txt) retains its license text, including
MIT/Expat and modified BSD terms. Retain all codec license notices when
redistributing native binaries. The current setup uses system `zlib` and
platform libraries. Their licenses also apply to redistribution.

The genetic-code data comes from `Bio.Data.CodonTable` in
`Biopython` 1.88. It records NCBI genetic-code assignments. The retained
[BIOPYTHON_LICENSE.rst](BIOPYTHON_LICENSE.rst) contains the license terms.
[NCBI genetic codes](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)
provide the biological source.

The optional `net/` package links system libcurl through the C toolchain.
Its distribution and TLS backend retain their own license terms. The package contains no curl source or TLS library binaries.

The generated restriction catalog derives from `Bio.Restriction` 1.88.
[Catalog provenance](../data/restriction/PROVENANCE.md) records the source and
data notice. Retain its [license](../data/restriction/BIOPYTHON_LICENSE.rst)
with catalog distributions. The runtime embeds the generated catalog.
