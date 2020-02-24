#!/bin/bash
set -euf -o pipefail

FILE="${1}"

printf 'optimizing %s (%s)\n' "${FILE}" "$(ls -lah "${FILE}" | awk '{ print $5}')"

optipng -quiet -o3 -clobber -preserve -fix -out "${FILE}" "${FILE}" >/dev/null
zopflipng --lossy_transparent -y "${FILE}" "${FILE}" >/dev/null

printf 'optimized %s (%s)\n' "${FILE}" "$(ls -lah "${FILE}" | awk '{ print $5}')"
