#!/usr/bin/env bash
set -euf -o pipefail

s chrome --app="${1:-}"
