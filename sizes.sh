#!/usr/bin/env bash
set -euf -o pipefail

sudo du -h -d "${SIZESDEPTH:-1}" "${@:-.}" --exclude={"/run","/sys","/dev","/proc","/mnt","/net","/misc"} | sort -h
