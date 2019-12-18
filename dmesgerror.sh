#!/usr/bin/env bash
set -euf -o pipefail

#dmesg -T | grep -i err | grep -viE '(override|interrupt)'
exec dmesg -T | grep -iP 'err(?!(upt|ide))'
