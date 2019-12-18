#!/usr/bin/env bash
set -euf -o pipefail

echo ">>> getting sitemap urls from ${1}" || {
  echo 'error'
  exit 1
}
smap=$(s sitemapsearch "${1:-}")

echo "echo curling urls for ${2:-1} times"

i=0
while ((i < ${2:-1})); do
  xargs curl -Ls <<<"${smap}" | cat | pv >/dev/null
  i=$((i + 1))
done
