#/bin/bash

# Encoding SVG file
cat Makefile 
make deploy ARGS="--network sepolia"
base64 --help

# Making encoded hash
base64 -i img/example-1.svg

# Decoding SVG file
# data:image/svg+xml;base64,<ENCODED_HASH>