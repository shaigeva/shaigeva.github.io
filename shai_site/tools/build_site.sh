#!/usr/bin/env zsh
set -x

hugo  && (rm -rf ../docs || 1) && cp -r public ../docs && cp ../CNAME ../docs/
