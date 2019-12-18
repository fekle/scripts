#!/usr/bin/env bash
set -euf -o pipefail

echo "removing line ${1:0} from known_hosts"

sed -e "${1}d" -i ~/.ssh/known_hosts
