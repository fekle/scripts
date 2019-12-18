#!/usr/bin/env bash
set -euf -o pipefail

exec sudo nettop -d 0.5 -p
