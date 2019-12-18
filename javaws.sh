#!/usr/bin/env bash
set -euf -o pipefail

/opt/jre1.8.0_211/bin/javaws -Xnosplash -wait ${@}
