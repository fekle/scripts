#!/usr/bin/env bash
set -euf -o pipefail

if [[ -z ${1:-} ]] || [[ -z ${2:-} ]]; then
  echo "usage: s ${#} grepsed <find> <replace>"
  exit 1
fi

echo "replacing '${1}' with '${2}' recursively..."

files=$(grep -rl '${1}')
echo "matching files:"
echo "${files}"
printf "type YES to continue: "
read input
if [[ ${input} != "YES" ]]; then
  echo "abort"
  exit 1
fi

grep -rl "${1}" | xargs sed -i "s&${1}&${2}&g"
