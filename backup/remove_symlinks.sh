#!/bin/bash
# -polka-

# Get the current directory
DIR="$( cd "$(dirname "$0" )" && pwd )"

# Link dot files to $HOME
for dotfile in $(find $DIR -maxdepth 1 -type f -name ".*"); do
  if [[ $(uname) == 'Linux' && "$(basename $dotfile)" == '.tmux.linux.conf' ]]; then
    rm -v "${HOME}/.tmux.conf"
    cp -v $dotfile "${HOME}/.tmux.conf"
  elif [[ $(uname) == 'Darwin' && "$(basename $dotfile)" == '.tmux.osx.conf' ]]; then
    rm -v "${HOME}/.tmux.conf"
    cp -v $dotfile "${HOME}/.tmux.conf"
  elif [[ "$(basename $dotfile)" != ".tmux.osx.conf" && "$(basename $dotfile)" != ".tmux.linux.conf" ]]; then
    rm -v "${HOME}/$(basename $dotfile)"
    cp -v $dotfile "${HOME}/$(basename $dotfile)"
  fi
done

# Link rc files in .bashrc.d
[ -d "${HOME}/.bashrc.d" ] || mkdir "${HOME}/.bashrc.d"
for dotfile in ${DIR}/.bashrc.d/*; do
    rm -v "${HOME}/.bashrc.d/$(basename $dotfile)"
    cp -v $dotfile "${HOME}/.bashrc.d/$(basename $dotfile)"
done

# Link files in bin
[ -d "${HOME}/bin" ] || mkdir "${HOME}/bin"
for file in ${DIR}/bin/*; do
    [ -x $file ] || continue
    [[ $(uname) == 'Linux' && $(basename $file) == 'reattach-to-user-namespace' ]] && continue
    rm -v "${HOME}/bin/$(basename $file)"
    cp -v $file "${HOME}/bin/$(basename $file)"
done

# Link files in lib
[ -d "${HOME}/lib" ] || mkdir "${HOME}/lib"
for file in ${DIR}/lib/*; do
    [ -x $file ] || continue
    rm -v "${HOME}/lib/$(basename $file)"
    cp -v $file "${HOME}/lib/$(basename $file)"
done

# Remove broken symlinks
find -L "${HOME}" "${HOME}/.bashrc.d" "${HOME}/bin" "${HOME}/lib" "${HOME}/.vim/" -maxdepth 1 -type l | xargs rm 2>/dev/null
