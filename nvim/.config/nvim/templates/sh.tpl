#!/bin/sh
## Usage: SCRIPT_NAME [options] [SCRIPT_ARGUMENTS]
##
## SCRIPT_DESCRIPTION
##
## Options
##  -h    Displays usage.
##  -v    Displays this script's version.

set -Eeuo pipefail

__ScriptVersion="0.1"

usage() {
  [ "$*" ] && echo "$0: $*"
  sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0"
} 2>/dev/null
