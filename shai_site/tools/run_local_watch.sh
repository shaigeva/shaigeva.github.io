#!/usr/bin/env zsh
set -x

# INSTRUCTIONS:
# Run from the shai_site directory.

# NOTE: this hides drafts like the live site, run the command below in order
# to show them.
hugo server --baseURL http://localhost:1313/
# hugo server --buildDrafts --baseURL http://localhost:1313/
