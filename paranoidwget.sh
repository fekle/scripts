#!/usr/bin/env bash
set -euf -o pipefail

torsocks -i wget --no-dns-cache --no-cache --no-cookies "${@}"
