#!/usr/bin/env bash
set -euf -o pipefail

/opt/mozjpeg/bin/cjpeg -quality 90 -optimize -progressive -outfile "${1}.jpg" "${1}"
