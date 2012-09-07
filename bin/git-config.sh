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
global_config "color.status.added" "green"
global_config "color.status.changed" "yellow"
global_config "color.status.untracked" "red"

global_config "core.excludesfile" "${HOME}/.cvsignore"

global_config "alias.st" "status"
global_config "alias.ci" "commit -v"
global_config "alias.co" "checkout"
global_config "alias.di" "diff"
global_config "alias.dc" "diff --cached"
global_config "alias.aa" "add --all"
global_config "alias.amend" "commit -v --amend"
global_config "alias.ff" "merge --ff-only"
global_config "alias.fa" "fetch --all"
global_config "alias.pom" "push origin master"
global_config "alias.pum" "push upstream master"
global_config "alias.tr" "log --all --oneline --decorate --graph"

exit 0
