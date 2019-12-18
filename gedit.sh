#!/usr/bin/env bash
set -euf -o pipefail

# open either cli or gui editor, with cli as default
case $(basename -s .sh ${0}) in
edit)
  exec nano ${@}
  ;;
gedit)
  exec code ${@}
  ;;
*)
  echo "usage: s editor [cli|gui]"
  ;;
esac
