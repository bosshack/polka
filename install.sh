#!/bin/bash

# Get the current directory
DIR="$( cd "$(dirname "$0" )" && pwd )"

# Link dot files to $HOME
for dotfile in $(find $DIR -maxdepth 1 -type f -name ".*"); do
  if [[ $(uname) == 'Linux' && "$(basename $dotfile)" == '.tmux.linux.conf' ]]; then
    ln -fs $dotfile "${HOME}/.tmux.conf"
  elif [[ $(uname) == 'Darwin' && "$(basename $dotfile)" == '.tmux.osx.conf' ]]; then
    ln -fs $dotfile "${HOME}/.tmux.conf"
  elif [[ "$(basename $dotfile)" != ".tmux.osx.conf" && "$(basename $dotfile)" != ".tmux.linux.conf" ]]; then
    ln -fs $dotfile "${HOME}/$(basename $dotfile)"
  fi
done

# Link rc files in .bashrc.d
[ -d "${HOME}/.bashrc.d" ] || mkdir "${HOME}/.bashrc.d"
for dotfile in ${DIR}/.bashrc.d/*; do
    ln -fs $dotfile "${HOME}/.bashrc.d/$(basename $dotfile)"
done

# Link programs files in bin
[ -d "${HOME}/bin" ] || mkdir "${HOME}/bin"
for program in ${DIR}/bin/*; do
    [ -x $program ] || continue
    [[ $(uname) == 'Linux' && $(basename $program) == 'reattach-to-user-namespace' ]] && continue
    ln -fs $program "${HOME}/bin/$(basename $program)"
done

[ -d "${HOME}/.vim/bundles" ] || mkdir -p "${HOME}/.vim/bundles"
[ -d "${HOME}/.vim/backups" ] || mkdir -p "${HOME}/.vim/backups"
[ -d "${HOME}/.vim/swaps" ]   || mkdir -p "${HOME}/.vim/swaps"
[ -d "${HOME}/.vim/undo" ]    || mkdir -p "${HOME}/.vim/undo"

# Link bundles files in .vim
for bundle in ${DIR}/.vim/*.bundle; do
    ln -fs $bundle "${HOME}/.vim/$(basename $bundle)"
done

(exec "${DIR}/bin/git-config.sh")
(exec "${DIR}/bin/vim-bundle")
