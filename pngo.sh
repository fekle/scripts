#!/usr/bin/env bash
set -euf -o pipefail

find "${1:-.}" -type f -iname '*.png' -print0 |
  parallel -0 "echo {} && mv {} {}.bak.png && optipng -o3 -preserve -fix -out {} {}.bak.png"
