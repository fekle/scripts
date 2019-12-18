#!/usr/bin/env bash
set -euf -o pipefail

if [[ -z ${DISPLAY:-} ]]; then
  exit 1
else
  exit 0
fi
