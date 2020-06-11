#!/bin/bash

for f in ~/CLONES/cassandra-examples/rst-to-asciidoc-tests/RST/OSS_C_RST/*/*.rst
do
    filename=$(basename "$f")
    filename="${filename%.*}"
    echo "Processing $filename"
    pandoc "$f" -f rst -t asciidoc -s -o "$filename.adoc"
done
