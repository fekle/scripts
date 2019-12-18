#!/usr/bin/env bash
set -euf -o pipefail

curl -Ls "${@:-}/sitemap.xml" | grep -o 'https\?://\([a-Z]\|[0-9]\|\.\|/\|-\|_\)\+' | xargs curl -Ls | grep -o 'https\?://\([a-Z]\|[0-9]\|\.\|/\|-\|_\)\+' | uniq | grep "${@}"
