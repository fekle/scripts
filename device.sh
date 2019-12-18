#!/usr/bin/env bash
set -euf -o pipefail

device=${DEVICE:-$(hostname)}

# pc zuhause
if [[ ${device} == "pc" && ${1:-} == "pc" ]]; then exit 0; fi

# felix xps
if [[ ${device} == "felix-xps" && ${1:-} == "felix-xps" ]]; then exit 0; fi

exit 1
