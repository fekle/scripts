#!/usr/bin/env bash
set -euf -o pipefail

if ionice nice find sudo wc sortif [[ -n ${@:-} ]]; then
  find . -type f -name "*.${@}" -printf "'%p' " | xargs wc -l | uniq | sort -h
else
  find . -type f -printf "'%p' " | xargs wc -l | uniq | sort -h
fi
