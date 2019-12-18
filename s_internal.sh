#!/usr/bin/env bash
set -euf -o pipefail

function s() {
  script-manager exec ${@}
}
export -f s

template='#!/usr/bin/env bash
set -euf -o pipefail
'

linktemplate='#!/usr/bin/env bash
# s alias
exec s <LINK> "${@}"
'

cd "${S_PATH}"

case ${1:-} in
sync)
  case ${2:-} in
  diff)
    git add .
    git diff "origin/$(git symbolic-ref HEAD | rev | cut -d "/" -f 1 | rev)" --histogram
    ;;
  commit)
    git add . -v
    git commit
    ;;
  pull)
    git pull -v
    ;;
  push)
    git add .
    git push -v
    ;;
  history)
    git log .
    ;;
  *)
    echo "usage: _s sync <diff|commit|pull|push|history>"
    ;;
  esac
  ;;
edit | gedit)
  if [ $# -eq 2 ]; then
    app="${S_PATH}/${2}.sh"

    if [ ! -f "${app}" ]; then
      echo "Script ${2} does not exist - creating..."
      echo "${S_TEMPLATE:-${template}}" >"${app}"
      chmod u+x "${app}"
    fi

    if [ "${1}" == "edit" ]; then
      s edit "${app}"
    else
      s gedit "${app}"
    fi
  else
    echo "please specify a script to edit"
    exit 1
  fi
  ;;
ls)
  ls -lha "${S_PATH}"
  ;;
ln | link | alias)
  if [ $# -eq 3 ]; then
    lname="${3:-}"
    ltarget="${2:-}"

    echo "aliasing ${lname} to ${ltarget}"

    if [[ ! -f "${S_PATH}/${ltarget}.sh" ]]; then
      echo "script '${ltarget}' does not exist"
      exit 1
    fi
    if [[ -f "${S_PATH}/${lname}.sh" ]]; then
      echo "script '${lname}' already exists"
      exit 1
    fi

    link="${linktemplate//<LINK>/${ltarget}}"
    echo "${link}" >>"${S_PATH}/${lname}.sh"
    chmod u+x "${S_PATH}/${lname}.sh"
  else
    echo "usage: s alias <existing script> <link name>"
    exit 1
  fi
  ;;
remove | rm)
  if [ $# -eq 2 ]; then
    app="${S_PATH}/${2}.sh"

    if [ -f "${app}" ]; then
      rm -i "${app}"
    else
      echo "script not found"
      exit 1
    fi

  else
    echo "please specify a script to delete"
    exit 1
  fi
  ;;
cat | ncat)
  if [ $# -eq 2 ]; then
    app="${S_PATH}/${2}.sh"

    if [ -f "${app}" ]; then
      if [ "${1}" == "ncat" ]; then
        cat -n "${app}"
      else
        cat "${app}"
      fi
    else
      echo "Script not found"
      exit 1
    fi
  else
    echo "Please specify a script to cat"
    exit 1
  fi
  ;;
* | help)
  echo "s internal tools"
  echo "usage: _s <sync|edit|gedit|ls|ln|remove|rm|cat|ncat|help>"
  ;;
esac
