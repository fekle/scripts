#!/bin/bash

set -euf -o pipefail

files=(.env .dockerenv)
pwd="$(realpath "$(pwd)")"

for file in ${files[*]}; do
  if [[ -f ${file} ]]; then
    printf ' => loading env from %s: %s  \n' "${pwd}/${file}" "$(head -n1 "${file}")"
    source ${file} 2>/dev/null
  fi
done
