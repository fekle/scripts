#!/usr/bin/env bash

set -euf -o pipefail

exec pygmentize -g -O style=monokai,linenos=1 "${@}"
