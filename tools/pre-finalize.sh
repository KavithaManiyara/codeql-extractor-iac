#!/bin/bash

set -eu

"$CODEQL_DIST/codeql" database index-files \
    "--include=**.yml" \
    "--include=**.yaml" \
    --size-limit=5m \
    --language yaml \
    -- \
    "$CODEQL_EXTRACTOR_IAC_WIP_DATABASE"