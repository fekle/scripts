#!/usr/bin/env bash
set -euf -o pipefail

cmd="node"

if [[ "$(basename ${0})" == npm.sh ]]; then
  cmd="npm"
fi

set +u

export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

if nvm use 2>/dev/null >/dev/null; then
  echo "use nvm specified version"
  nvm exec ${cmd} ${@}
elif nvm install 2>/dev/null >/dev/null; then
  echo "use nvm specified version"
  nvm exec ${cmd} ${@}
else
  echo "use default version"
  ${cmd} ${@}
fi
