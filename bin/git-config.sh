#!/bin/bash
#
# This will setup a gitconfig file if one does not exist

set -e

if [[ -s "${HOME}/.gitconfig" ]]; then
  read -n1 -p "${HOME}/.gitconfig already exists would you like to overwrite it? " answer
  echo
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Skipping git-config.sh"
    exit 0
  fi
  rm -f "${HOME}/.gitconfig"
fi

global_config() {
  git config --global "$1" "$2"
}

read -p "Full name: " name
read -p "Email address: " email

global_config "user.name" "$name"
global_config "user.email" "$email"

global_config "color.ui" "true"

global_config "core.excludesfile" "${HOME}/.cvsignore"

exit 0
