#!/usr/bin/env bash

set -euf -o pipefail

if [[ -z ${@:-} ]]; then
  echo "nothing to floop"
  exit 1
fi

while eval '${@}'; do
  sleep 1
done
