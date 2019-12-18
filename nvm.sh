#!/usr/bin/env bash

set +uf

source ${HOME}/.nvm/nvm.sh

nvm ${@}

set -uf
