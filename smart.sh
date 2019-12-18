#!/usr/bin/env bash
set -euf -o pipefail

sudo smartctl -a /dev/sda | less
