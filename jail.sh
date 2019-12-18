#!/usr/bin/env bash
set -euf -o pipefail

firejail --noprofile "${@}"
#exec ${@}
