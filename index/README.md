# Persistent FASTA index

Store local FASTA record offsets in SQLite. Requires macOS SQLite3 and CommonCrypto.

```goose
import bio_index from "path/to/index";
```

- `build(source, target)` creates an index atomically; 0 means success.
- `open(target)` returns a positive handle, or 0 on failure.
- `get_raw` returns exact bytes; `get_record` returns the ID, full header,
  and sequence. Check each result's `error` field.
- `count`, `keys`, and `key_at` expose source-order entries.
- `close(handle)` releases resources. Handles are main-thread-only.

The parser accepts only plain FASTA. Duplicate IDs and malformed records fail;
empty files and records are valid. Records and lines have a 64 MiB limit.

Keep the source unchanged while using its index. Each query hashes the entire
source, so lookup costs grow with file size. Treat index databases as trusted local
files. The index does not guard against concurrent writes or hostile file replacement.

See [API definitions](bio_index.goose) for result types and status values.
