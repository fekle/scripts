#!/usr/bin/env bash
set -euf

CLONE_URL="${1:-}"
S_PATH="${HOME}/.s"
S_BIN_PREFIX="/usr/local/bin"
S_BIN="${S_BIN_PREFIX}/s"
S_INTERNAL_BIN="${S_BIN_PREFIX}/_s"

printf '> installing s ...\n'

if [[ -e ${S_PATH} ]] || [[ -L ${S_PATH} ]]; then
  printf '> error: %s already exists.\n' "${S_PATH}"
  exit 1
fi

if [[ -e ${S_BIN} ]] || [[ -L ${S_BIN} ]]; then
  printf '> error: %s already exists.\n' "${S_BIN}"
  exit 1
fi

if [[ -e ${S_INTERNAL_BIN} ]] || [[ -L ${S_INTERNAL_BIN} ]]; then
  printf '> error: %s already exists.\n' "${S_INTERNAL_BIN}"
  exit 1
fi

printf '> cloning s to %s ...\n' "${S_PATH}"
git clone "${CLONE_URL}" "${S_PATH}"
chown -R "${USER}" "${S_PATH}"

printf '> linking %s to %s and %s - this will need rood privileges ...\n' "${S_PATH}" "${S_BIN}" "${S_INTERNAL_BIN}"
sudo -v
sudo ln -vs "${S_PATH}/s.sh" "${S_BIN}"
sudo ln -vs "${S_PATH}/s.sh" "${S_INTERNAL_BIN}"
chmod 0555 "${S_BIN}" "${S_INTERNAL_BIN}"

printf '> installation finished. please make sure that %s is in your $PATH.\n' "${S_BIN_PREFIX}"
