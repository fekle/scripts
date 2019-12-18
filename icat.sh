#!/usr/bin/env bash
set -euf -o pipefail

res=""

if [ $# -eq 2 ]; then
  res="${2}"
fi

if [ -z "${res}" ]; then
  res="64x"
fi

convert "${1}" -colorspace LAB -background transparent -filter Lanczos -distort resize "${res}" -colorspace sRGB /tmp/icat.png
icat -k -m both /tmp/icat.png
#rm /tmp/icat.png
