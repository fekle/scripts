#!/usr/bin/env bash
set -euf -o pipefail

find "${1:-.}" -type f -iregex '.*\.jpe?g' -print0 |
  parallel -0 "echo {} && mv {} {}.bak.jpg && /opt/mozjpeg/bin/jpegtran -optimize -progressive -copy all -outfile {} {}.bak.jpg"
