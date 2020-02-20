#!/usr/bin/env bash
set -euf
cd "${HOME}"

repos=(
  '~/.config'
  '~/.customZsh'
  '/opt/customZsh'
  '/opt/customZsh-global-config'
  '~/.config/i3-custom'
  '~/.s'
  '~/.devmode'
  '~/.config/alacritty'
  '~/.fonts'
)

function gitsync_pull() {
  set -euf

  # search for path, including replacing ~ with $HOME
  path=$(realpath "${1//\~/${HOME}}")
  printf "=> syncing '%s'\n" "${path}"
  cd "${path}"

  # pull and push
  git add . >/dev/null && git diff-index --quiet HEAD >/dev/null && git pull && git push || { git add . && git commit -v && git pull && git push; }

  printf "=> done syncing '%s'\n\n" "${path}"
}
export -f gitsync_pull

for repo in "${repos[@]}"; do
  gitsync_pull "${repo}"
done
