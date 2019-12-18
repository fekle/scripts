#!/usr/bin/env bash
set -euf -o pipefail

exec s retry ssh -C -o ConnectTimeout=1 ${@}
