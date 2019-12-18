#!/usr/bin/env bash
set -euf -o pipefail

if [[ -z ${@:-} ]]; then
  echo " nothing to retry"
  exit 1
fi

i=0

while true; do
  i=$((i + 1))
  printf "loop ${i}: "
  eval "$*" || true
  sleep 1
done
