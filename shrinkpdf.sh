#!/usr/bin/env bash
set -euf -o pipefail

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
  -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages \
  -dCompressFonts=true -r${3:-300} -sOutputFile="${2}" "${1}"
