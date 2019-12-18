#!/usr/bin/env bash
set -euf -o pipefail

gpg --recv-keys "${@}"
