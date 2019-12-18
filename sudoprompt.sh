#!/usr/bin/env bash
set -euf -o pipefail

# check for active sudo session
{ sudo -vn 2>/dev/null &&
  exit 0; } || true

printf "[sudo] getting root permissions \n"

if [[ -n ${*:-} ]]; then
  printf "[sudo] reason: %s\n" "${*}"
fi

{
  sudo -v && printf "[sudo] success \n" &&
    exit 0
} || {
  printf "[sudo] permission denied \n"
  exit 1
}
