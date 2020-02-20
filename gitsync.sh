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

function pull() {
  # search for path, including replacing ~ with $HOME
  path=$(realpath "${1//\~/${HOME}}") || exit 1
  echo "=> ${path}" || exit 1
  cd "${path}" || exit 1

  # pull and push
  git pull --rebase || exit 1
  git push
  printf '\n'
}

for repo in "${repos[@]}"; do
  (
    pull "${repo}"
  ) || (
    echo "=> updating ${repo} failed"
    exit 1
  )
done
