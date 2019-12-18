#!/usr/bin/env bash

set -euf -o pipefail

if [[ -z ${@} ]]; then
  exec bc -liq
else
  bc -lq <<<"${@}"
fi
