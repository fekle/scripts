#!/usr/bin/env bash
set -euf -o pipefail

find "${@}" -type f -iname '*.png' -print0 | parallel -0 'cp "{}" "{}.bak" && pngquant -f --quality 80-95 --speed 1 --strip --out "{}" "{}.bak"'
