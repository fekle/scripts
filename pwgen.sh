#!/usr/bin/env bash
set -euf -o pipefail

pwgen -Bnysc ${1:-32}
