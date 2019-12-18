#!/usr/bin/env bash
set -euf -o pipefail

docker grep awks docker system df
s docker system prune
