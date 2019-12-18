#!/usr/bin/env bash
set -euf -o pipefail

if [[ -z ${@:-} ]]; then
  echo " nothing to retry"
  exit 1
fi

i=1

printf "try 0: "
while ! eval '${@}'; do
  printf "try ${i}: "
  i=$((i + 1))
  sleep 1
done
