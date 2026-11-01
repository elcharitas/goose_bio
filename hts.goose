namespace bio;

/* Returns an owned handle, or 0 on failure; close each successful open once.
 * Alignment modes are w/wb/wc/wz; variants use w/wb/wz. Headers are used as supplied.
 * BAM/BCF/CRAM and BGZF SAM/VCF readers require seekability and a valid EOF marker.
 * Opening a writer emits its header and may truncate the destination. */
extern fn hts_open(path: const u8[:], mode: const u8[:], variants: bool, header: const u8[:], reference: const u8[:]) -> i64 = "bio_hts_open";
extern fn hts_close(handle: i64) -> i32 = "bio_hts_close";
/*
Returns 1 for a record, 0 for EOF, and -1 for failure. Corrupt blocks or missing
required EOF markers fail, even after complete data blocks; older markerless BGZF files
are rejected.
*/
extern fn hts_next(handle: i64) -> i32 = "bio_hts_next";
extern fn hts_write(handle: i64, line: const u8[:]) -> i32 = "bio_hts_write";
extern fn hts_text(handle: i64, out: u8[>..]&) -> i32 = "bio_hts_text";
extern fn hts_header(handle: i64, out: u8[>..]&) -> i32 = "bio_hts_header";
// Position is zero-based; flag/mapq apply only to alignments.
extern fn hts_position(handle: i64) -> i64 = "bio_hts_position";
extern fn hts_flag(handle: i64) -> i32 = "bio_hts_flag";
extern fn hts_mapq(handle: i64) -> i32 = "bio_hts_mapq";
extern fn hts_index(path: const u8[:], variants: bool) -> i32 = "bio_hts_index";
// Region syntax is HTSlib's one-based inclusive chr:start-end.
extern fn hts_query(handle: i64, region: const u8[:]) -> i32 = "bio_hts_query";
// FASTA fetch uses a zero-based half-open interval and builds .fai.
extern fn hts_fasta_fetch(path: const u8[:], name: const u8[:], start: i64, end: i64, out: u8[>..]&) -> i32 = "bio_fasta_fetch";
/* Requires an EOF marker when decompressing local BGZF. Opens the source first and
 * checks file identities before truncating output, rejecting hard-link, symlink, and relative aliases.
 * Missing sources preserve output. Later I/O errors can leave partial files; replacement is not atomic. */
extern fn hts_bgzf_copy(source: const u8[:], destination: const u8[:], compress: bool) -> i32 = "bio_bgzf_copy";
extern fn hts_tabix_index(path: const u8[:]) -> i32 = "bio_tabix_index";
extern fn hts_tabix_query(path: const u8[:], region: const u8[:], out: u8[>..]&) -> i32 = "bio_tabix_query";

/* Streams local plain/gzip FASTA or FASTQ, retaining one current record. Each line/field has a
 * 64 MiB limit. A failed open returns 0; close each successful handle once. */
extern fn fastx_open(path: const u8[:]) -> i64 = "bio_fastx_open";
/* Returns 1/0/-1 for record/EOF/error; failures remain sticky. EOF/error invalidates fields.
 * Reads nonempty sequences and matching FASTQ qualities. Consume through EOF to validate the file. */
extern fn fastx_next(handle: i64) -> i32 = "bio_fastx_next";
// Append the current name (0), comment (1), sequence (2), or quality (3).
extern fn fastx_field(handle: i64, field: i32, out: u8[>..]&) -> i32 = "bio_fastx_field";
/* Returns 0 or -1. Closing releases buffers even after parse failure; closed IDs never become valid
 * again. */
extern fn fastx_close(handle: i64) -> i32 = "bio_fastx_close";

/*
Uses the current valid alignment. Returns the SAM type byte, or -1.
*/
extern fn bam_aux_type(handle: i64, tag: const u8[:]) -> i32 = "bio_bam_aux_type";
/*
Returns array length, 1 for a scalar, or -1 on failure.
*/
extern fn bam_aux_count(handle: i64, tag: const u8[:]) -> i64 = "bio_bam_aux_count";
/*
Reads an integer scalar at index zero or an integer array element. Failure is INT64_MIN,
outside the stored BAM integer range.
*/
extern fn bam_aux_int(handle: i64, tag: const u8[:], index: i64) -> i64 = "bio_bam_aux_int";
/*
Reads a floating scalar/array element. Failure is NaN, indistinguishable from a stored
NaN.
*/
extern fn bam_aux_float(handle: i64, tag: const u8[:], index: i64) -> f64 = "bio_bam_aux_float";
/*
Copies A, Z, or H bytes into the builder.
*/
extern fn bam_aux_string(handle: i64, tag: const u8[:], out: u8[>..]&) -> i32 = "bio_bam_aux_string";
/*
Aux setters add or replace values after validating a two-byte SAM tag. Integer, float,
string, i32-array, and f32-array forms are supported.
*/
extern fn bam_aux_set_int(handle: i64, tag: const u8[:], value: i64) -> i32 = "bio_bam_aux_set_int";
extern fn bam_aux_set_float(handle: i64, tag: const u8[:], value: f64) -> i32 = "bio_bam_aux_set_float";
extern fn bam_aux_set_string(handle: i64, tag: const u8[:], value: const u8[:]) -> i32 = "bio_bam_aux_set_string";
/*
An absent tag is an error.
*/
extern fn bam_aux_delete(handle: i64, tag: const u8[:]) -> i32 = "bio_bam_aux_delete";
/*
Requires the same record family and identical formatted headers, including samples;
numeric dictionaries are not guessed. This restriction belongs to this strict copy only.
Rejection can leave header bytes already emitted by writer open. Close the writer
explicitly.
*/
extern fn hts_copy_record(source: i64, destination: i64) -> i32 = "bio_hts_copy_record";
/*
Copies decoded bases; same-length setters preserve layout and aux fields. Combined
resizing uses bam_edit.
*/
extern fn bam_sequence(handle: i64, out: u8[>..]&) -> i32 = "bio_bam_sequence";
/*
Copies numeric PHRED bytes, including 255 for missing quality.
*/
extern fn bam_quality(handle: i64, out: u8[>..]&) -> i32 = "bio_bam_quality";
/*
Returns packed (length << 4) | opcode, or -1 for an invalid index.
*/
extern fn bam_cigar(handle: i64, index: i64) -> i64 = "bio_bam_cigar";
/*
Integer INFO/FORMAT getters use sample-major FORMAT arrays. INT64_MIN indicates getter
failure; stored i32 missing (-2147483648) and vector end (-2147483647) remain distinct.
*/
extern fn bcf_int_count(handle: i64, tag: const u8[:], format: bool) -> i64 = "bio_bcf_int_count";
/*
GT uses encoded HTSlib integers: zero is missing, (allele + 1) << 1 is unphased, and bit
zero marks phase. Vector ends preserve variable ploidy. Reader-side sample selection is
unavailable; mapped copy can select writer samples.
*/
extern fn bcf_int(handle: i64, tag: const u8[:], format: bool, index: i64) -> i64 = "bio_bcf_int";
/* Requires Integer in the selected INFO/FORMAT namespace; FORMAT GT instead requires String.
 * Unknown IDs, namespaces, or types fail before mutation, including empty-array deletion.
 * Fixed/A/R counts and padded FORMAT widths must match; one missing value is allowed.
 * Data after vector end and Number=G updates fail. GT alleles must fit; phase and ploidy survive. */
extern fn bcf_set_int(handle: i64, tag: const u8[:], format: bool, values: const i32[:]) -> i32 = "bio_bcf_set_int";
/*
Returns an opaque handle or 0; readers require an EOF marker. Independent writers
truncate their path: use distinct input/output paths. hts_bgzf_copy provides the
separate alias-protected copying operation. Calls remain main thread only.
*/
extern fn bgzf_open(path: const u8[:], writing: bool) -> i64 = "bio_bgzf_open";
/*
Flushes writers and invalidates the handle, returning 0 or -1.
*/
extern fn bgzf_close(handle: i64) -> i32 = "bio_bgzf_close";
/*
Returns a virtual offset or -1. Writer offsets can refer to buffered data.
*/
extern fn bgzf_tell(handle: i64) -> i64 = "bio_bgzf_tell";
/*
Accepts reader offsets only. Save an offset and reopen the same file before seeking;
arbitrary offsets may not identify valid blocks.
*/
extern fn bgzf_seek(handle: i64, offset: i64) -> i32 = "bio_bgzf_seek";
/*
Appends up to the requested count, capped at 64 MiB per call. Returns bytes read, 0 at
EOF, or -1.
*/
extern fn bgzf_read(handle: i64, count: i64, out: u8[>..]&) -> i64 = "bio_bgzf_read";
/*
Returns 0 or -1; failures can leave partial output.
*/
extern fn bgzf_write(handle: i64, data: const u8[:]) -> i32 = "bio_bgzf_write";

extern fn bam_aux_set_int_array(handle: i64, tag: const u8[:], values: const i32[:]) -> i32 = "bio_bam_aux_set_int_array";
extern fn bam_aux_set_float_array(handle: i64, tag: const u8[:], values: const f32[:]) -> i32 = "bio_bam_aux_set_float_array";
/*
Consumes the remaining stream; a fresh reader includes the whole file. Returns 1/0/-1
for column/EOF/error. Once started, ordinary reads and queries fail. EOF and failures
invalidate the column; errors, including unsorted input, remain sticky.
*/
/*
Uses 64-bit positions above INT32_MAX. Consume to EOF to detect later errors; earlier
columns do not prove file validity. HTSlib depth/filter defaults apply unless
configured. No BAQ, overlap correction, or base/name export.
*/
extern fn pileup_next(handle: i64) -> i32 = "bio_pileup_next";
/*
Fields 0/1/2 are reference ID, zero-based position, and depth. Indexed fields 3-8 are
query position, signed indel length, deletion, reference skip, head, and tail. Invalid
access returns INT64_MIN.
*/
extern fn pileup_field(handle: i64, index: i64, field: i32) -> i64 = "bio_pileup_field";
/*
Accepts same-length uppercase BAM alphabet symbols and preserves layout/aux fields.
*/
extern fn bam_set_sequence(handle: i64, value: const u8[:]) -> i32 = "bio_bam_set_sequence";
/*
Accepts same-length numeric qualities, either all 0-93 or all 255 missing. Mixed
missing/present values fail before mutation. Empty quality is valid only for an empty
sequence.
*/
extern fn bam_set_quality(handle: i64, value: const u8[:]) -> i32 = "bio_bam_set_quality";

// Float bits preserve missing 0x7f800001 and vector end 0x7f800002.
/*
Float INFO/FORMAT uses binary32 bits and sample-major padded FORMAT widths. Missing
0x7f800001 and vector end 0x7f800002 stay distinct through BCF output/reopen.
*/
extern fn bcf_float_count(handle: i64, tag: const u8[:], format: bool) -> i64 = "bio_bcf_float_count";
/*
Returns a nonnegative binary32 bit pattern, or -1 on failure.
*/
extern fn bcf_float_bits(handle: i64, tag: const u8[:], format: bool, index: i64) -> i64 = "bio_bcf_float_bits";
/*
Takes u32 Float bits; empty arrays remove fields. Applies the numeric
cardinality/vector-end checks of bcf_set_int. Number=G mutation fails; GT uses its
special encoded Integer API.
*/
extern fn bcf_set_float_bits(handle: i64, tag: const u8[:], format: bool, values: const u32[:]) -> i32 = "bio_bcf_set_float_bits";
/*
Returns 0 for absence, 1 for presence, or -1 on failure.
*/
extern fn bcf_flag(handle: i64, tag: const u8[:]) -> i32 = "bio_bcf_flag";
/*
Adds/removes a declared INFO Flag.
*/
extern fn bcf_set_flag(handle: i64, tag: const u8[:], value: bool) -> i32 = "bio_bcf_set_flag";
/*
Appends INFO at sample index zero, or FORMAT at the header sample index. Missing strings
remain literal dots.
*/
extern fn bcf_string(handle: i64, tag: const u8[:], format: bool, sample: i64, out: u8[>..]&) -> i32 = "bio_bcf_string";
// FORMAT input has one tab-separated string per header sample.
/*
Accepts an INFO string or one tab-separated FORMAT string per header sample, with comma-
separated values and header cardinality checks. Empty INFO removes the field; FORMAT
removal is unsupported. GT uses encoded integers.
*/
/*
Whitespace, empty elements, semicolons, colons, equals signs, and Number=G String
mutation fail.
*/
extern fn bcf_set_string(handle: i64, tag: const u8[:], format: bool, value: const u8[:]) -> i32 = "bio_bcf_set_string";
// Concrete alleles only; allele count and index meanings stay fixed.
/*
Duplicates then swaps the record; validation/allocation rejection preserves the
original. Requires a fixed count of concrete A/C/G/T/N (either case) or star alleles.
Case-insensitive REF/ALT or ALT/ALT duplicates, symbolic alleles, and breakends fail.
*/
/*
Indices retain positional meaning; update allele-specific annotations when biological
meaning changes. This edit does not normalize, translate header dictionaries, or remap
samples. Those limits apply to allele editing, not mapped-copy APIs.
*/
extern fn bcf_set_alleles(handle: i64, alleles: const u8[:]) -> i32 = "bio_bcf_set_alleles";
// Replace CIGAR, sequence, and numeric quality together; retain aux/mate.
/*
Replaces packed u32 CIGAR, sequence, and numeric quality together. Checks operation
lengths, terminal clipping, query length, mapped span, alphabet, and quality before
replacement. Only unmapped records may omit CIGAR. Validation/allocation failures
preserve input.
*/
/*
HTSlib 1.21 bam_set1 computes the bin and reserves aux capacity; original aux bytes and
data length are restored. Mate, flags, name, mapq, and ID survive. NM/MD and other
annotations are retained without recomputation; no mate coordination or reference-based
validation.
*/
extern fn bam_edit(handle: i64, cigar: const u32[:], sequence: const u8[:], quality: const u8[:]) -> i32 = "bio_bam_edit";

// Configure before pileup starts; masks exclude reads, mapq is minimum.
/*
Before pileup starts, sets a positive depth cap, excluded BAM flags, and minimum mapq.
Later configuration fails. Filtering consumes skipped reads and retains reader errors;
native workers do not permit concurrent Goose calls.
*/
extern fn pileup_configure(handle: i64, depth: i32, exclude_flags: i32, minimum_mapq: i32) -> i32 = "bio_pileup_configure";

/* Copies a cloned current variant by exact field/contig names into destination sample order.
 * All destination samples must exist; Type/Number must match. No aliases or Number=G translation.
 * Packed values, missing/vector-end sentinels, GT phase and ploidy survive validation.
 * Returns 0 or -1. Validation writes no record; writer opening and failed I/O can leave partial output. */
extern fn hts_copy_variant_mapped(source: i64, destination: i64) -> i32 = "bio_hts_copy_variant_mapped";

// Shared native workers; callers still use the Goose main thread.
/*
Accepts 1-64 native workers; returns an opaque nonzero ID or 0. Pool/sync IDs use a
separate negative space from file/BGZF/FASTX handles. Treat all IDs as opaque and test
opens against zero.
*/
extern fn hts_pool_open(threads: i32) -> i64 = "bio_hts_pool_open";
// Returns -2 while attached resources remain open; -1 for invalid ID.
/*
Returns 0 after destruction, -2 while attachments remain, or -1 for an invalid ID. Busy
close leaves the pool usable.
*/
extern fn hts_pool_close(pool: i64) -> i32 = "bio_hts_pool_close";
/*
Attach once before record operations; open has already processed the header. No
replacement/detach API. Returns 0 or -1. Attachment retains the pool through worker
drain and writer flush, even when file close fails.
*/
/*
Pools support independent readers/writers; uncompressed files may retain unused pools.
Workers use HTSlib storage, never call Goose, and retain no Goose slices/builders. Goose
handle calls remain main-thread only.
*/
extern fn hts_pool_attach(handle: i64, pool: i64) -> i32 = "bio_hts_pool_attach";
/*
Attach once before block operations; returns 0 or -1. Retains the pool until close
completes drain/flush, including failed close. No replacement or detach; the same worker
ownership and main-thread rules apply as for hts_pool_attach.
*/
extern fn bgzf_pool_attach(handle: i64, pool: i64) -> i32 = "bio_bgzf_pool_attach";
// Pairing: 64 exact allele sets, 4 any alleles at a position.
// Regions: inline one-based inclusive list, empty means all indexed sites.
// Overlap: 0 POS, 1 record span, 2 variant span. Pool 0 disables workers.
/*
Returns an opaque nonzero ID or 0. Pairing is 64 for exact allele sets or 4 for any
alleles at a position; duplicate-position order follows HTSlib 1.21. Pairing neither
normalizes nor establishes biological equivalence.
*/
/*
Regions are inline comma-separated one-based inclusive HTSlib regions; empty selects all
indexed sites. Overlap is 0 POS, 1 record span, or 2 variant span. Pool zero disables
workers; otherwise retained until group close, even before readers are added.
*/
/* No seek, reader removal, sample selection, custom pairing masks, region files/changes, remote
 * access, or concurrent Goose calls. */
extern fn hts_sync_open(pairing: i32, regions: const u8[:], overlap: i32, pool: i64) -> i64 = "bio_hts_sync_open";
// Add before next; returns zero-based reader index or -1.
/*
Before next, adds local regular indexed compressed VCF/BCF with complete EOF markers;
returns a zero-based reader index or -1. Group owns files, indexes, iterators, headers,
and buffered records. Each reader keeps its own header/samples; no common dictionary or
sample intersection.
*/
/*
Rejected paths/EOF checks add nothing. Failed native reader addition makes the group
unusable until close; early close destroys the whole group.
*/
extern fn hts_sync_add(handle: i64, path: const u8[:]) -> i32 = "bio_hts_sync_add";
/*
Returns 1 for a synchronized step, 0 at EOF, or -1 on failure. Read errors and record
error flags are sticky and invalidate current access. Consume requested regions to find
later failures; skipped regions are not validated. HTSlib sorts and buffers duplicate
positions internally.
*/
extern fn hts_sync_next(handle: i64) -> i32 = "bio_hts_sync_next";
/*
Returns 1/0 for presence at the current step, or -1 for invalid access.
*/
extern fn hts_sync_has_line(handle: i64, reader: i32) -> i32 = "bio_hts_sync_has_line";
/*
Returns a zero-based i64 position or -1 without a current record. Indexed VCF/CSI
supports positions above INT32_MAX; BCF itself limits coordinate representation.
*/
extern fn hts_sync_position(handle: i64, reader: i32) -> i64 = "bio_hts_sync_position";
// Each reader retains its own dictionary, samples, and genotype text.
/*
Appends copied header text when header is true, otherwise current VCF text; returns 0 or
-1. Reader headers retain GT phase/ploidy, missing values, and sample order. No typed
GT/dictionary-ID API; ordinary file handles own typed mutation and mapped-copy APIs.
*/
extern fn hts_sync_text(handle: i64, reader: i32, header: bool, out: u8[>..]&) -> i32 = "bio_hts_sync_text";
/*
Closes the group and owned readers; returns 0 or -1 for an invalid ID. Stale or
mismatched resource IDs reject.
*/
extern fn hts_sync_close(handle: i64) -> i32 = "bio_hts_sync_close";

/* Writes a private copy; returns 0 or -1. Select unique original indices with REF zero first,
 * keeping 2..128 concrete alleles. Source/destination current records stay unchanged.
 * Removed GT alleles: 0 error, 1 missing, preserving phase. Other annotations: 0 retain, 1 drop,
 * 2 error. Ploidy 0 infers from GT; 1..16 must agree with GT. Number=A/R/G values are selected,
 * not marginalized or renormalized. recompute requires GT and matching AC/AN/AF declarations.
 * Destination samples follow header order. Validation precedes writing; I/O has no rollback. */
extern fn hts_copy_variant_alleles(source: i64, destination: i64, selection: const i32[:], removed: i32, stale: i32, ploidy: i32, recompute: bool) -> i32 = "bio_hts_copy_variant_alleles";

/* Copies a clone with tid/mtid mapped independently by exact primary names; returns 0 or -1.
 * Positive LN, any M5, and referenced RG/PG definitions must match.
 * Limits: 1 MiB for headers/names, 4096 references, 16 MiB records, 128 PG steps.
 * Coordinate-sorted destinations reject dictionary inversions.
 * Opening the writer may truncate output. There is no alias safety or I/O rollback; failed writes may
 * leave partial output. Source records remain unchanged. */
extern fn hts_copy_alignment_mapped(source: i64, destination: i64) -> i32 = "bio_hts_copy_alignment_mapped";
