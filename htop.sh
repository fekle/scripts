#!/usr/bin/env bash
set -euf -o pipefail

sudo htop -d ${1:-10}
