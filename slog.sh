#!/usr/bin/env bash
set -euf -o pipefail

cd ${S_PATH}
git log .
