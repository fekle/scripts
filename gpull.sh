#!/usr/bin/env bash
set -euf -o pipefail

find ${1:-.} -type d -name ".git" -print0 | sed 's/.git//g' | while IFS= read -r -d $'\0' line; do
  echo "updating ${line} ..."
  pushd "${line}" >/dev/null
  git pull --recurse-submodules=yes --all || echo "failed to pull ${line}"
  popd >/dev/null
done

wait
