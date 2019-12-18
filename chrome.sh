#!/usr/bin/env bash
set -euf -o pipefail

exec google-chrome-stable "${*}"
