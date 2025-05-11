#!/usr/bin/env zsh
set -x

# INSTRUCTIONS:
# Run from the shai_site directory.

hugo  && (rm -rf ../docs || 1) && cp -r public ../docs && cp ../CNAME ../docs/
