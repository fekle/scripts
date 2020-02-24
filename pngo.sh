#!/bin/bash
set -euf -o pipefail

find "${1:-.}" -type f -iname '*.png' -print0 |
  parallel -0 "s pngo-single '{}'"
