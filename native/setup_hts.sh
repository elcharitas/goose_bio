#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
mkdir -p .tools
archive=.tools/htslib-1.21.tar.bz2
if [ ! -f "$archive" ]; then
    curl -L --fail https://github.com/samtools/htslib/releases/download/1.21/htslib-1.21.tar.bz2 -o "$archive"
fi
printf '%s  %s\n' 84b510e735f4963641f26fd88c8abdee81ff4cb62168310ae716636aac0f1823 "$archive" | shasum -a 256 -c -
if [ ! -d .tools/htslib-1.21 ]; then tar -xjf "$archive" -C .tools; fi
(
    cd .tools/htslib-1.21
    ./configure --disable-libcurl --disable-s3 --disable-gcs \
        --disable-plugins --disable-lzma --disable-bz2 --without-libdeflate
    make -j4 libhts.a
)
