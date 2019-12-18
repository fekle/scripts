#!/usr/bin/env bash
set -euf -o pipefail

python3 -m http.server ${@}
