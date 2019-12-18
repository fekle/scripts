#!/usr/bin/env bash
set -euf -o pipefail

export S_PATH="$(dirname $(realpath ${0}))"

if [[ ${1:-} == "direct" ]]; then
  # direct execution, use with caution !
  exec "${S_PATH}/${2}.sh" "${@:3}"
fi

export s_child=true

function list() {
  programs=$(find "${S_PATH}" -maxdepth 1 -type f -name '*.sh' -not -wholename "*/.git/*" -printf '%f\n' | sed 's/\.sh//g' | sort -d)

  if [ -z "${programs}" ]; then
    echo "No scripts found - use 's edit {NAME}' to create your first"
    exit
  fi

  echo "${programs}" | sort -d
}

# source libs
if [[ -d "${S_PATH}/lib" ]]; then
  while read -r dep; do
    source "${dep}"
  done <<<"$(find "${S_PATH}/lib" -type f -name "*.sh")"
fi

if [[ "$(basename "${0}")" == "_s" ]]; then
  exec "${S_PATH}/s_internal.sh" "${@}"
fi

if [ $# -eq 0 ]; then
  scripts=$(list)
  scriptcount=$(wc -l <<<"${scripts}")
  column <<<"${scripts}"
  printf "\n%s scripts installed\n" "${scriptcount}"
elif [[ ${1:-} == "lib" ]]; then
  . "${S_PATH}/${2}.sh" "${@:3}"
else
  # set command
  export S_COMMAND="${1}"

  app="${S_PATH}/${1}.sh"
  arguments="${*:2}"

  if [[ ${1} == "help" ]]; then
    if [[ -z ${2:-} ]]; then
      echo "no script specified"
      exit 1
    fi

    export S_COMMAND="${2}"
    app="${S_PATH}/${2}.sh"
    arguments="${*:3}"
  fi

  if [ ! -f "${app}" ]; then
    echo "script does not exist -- run 's edit ${S_COMMAND}' to create"

    if hash agrep >/dev/null 2>&1; then
      # find similar app
      data=$(list "quiet" | sort -d) || true
      data=$(agrep -i -D 1 -I 1 -S 1 -E 2 "${1}" <<<"${data}" | head -n 1)

      if [ ! -z "${data}" ]; then
        args=" ${*:2}"
        echo "did you mean 's ${data}${args} or _s ${*}' ?"
      fi
    else
      echo "did you meean '_s ${*}' ?"
    fi
  else
    exec "${app}" ${arguments}
  fi
fi
