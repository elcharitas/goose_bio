#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
mkdir -p .tools/alignment-oracle-include
cat > .tools/alignment-oracle-include/goose.h <<'HEADER'
#include <stdint.h>
typedef void *gs_rref;
static inline void gs_bld_append(gs_rref a, const void *b, int64_t c) { (void)a; (void)b; (void)c; }
HEADER
cc -std=c11 -D_DARWIN_C_SOURCE -I.tools/alignment-oracle-include -I.tools/htslib-1.21 native/hts_alignment_oracle.c -L.tools/htslib-1.21 -lhts -lz -lpthread -lm -o .tools/alignment-oracle
.tools/alignment-oracle
