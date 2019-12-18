#!/usr/bin/env bash
set -euf -o pipefail

if [[ ${#} -eq 0 ]]; then
  less -Sr
else
  less -Sr <<<"${@}"
fi
