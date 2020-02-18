#!/usr/bin/env bash
set -euf -o pipefail

infile="$(realpath "${1}")"
outfile="$(realpath "${2:-/dev/null}")"
options="${3:-bs=32M oflag=direct status=progress}"

if [[ ! -f ${infile} ]]; then
  echo "${infile} not found"
  exit $()
fi

sudo dd if="${infile}" of="${outfile}" ${options}

echo "force sync ${outfile}"
sync "${outfile}"
