#!/usr/bin/env bash
set -euf -o pipefail

. s lib loadenv

docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest ctop -s ${1:-mem} -a
