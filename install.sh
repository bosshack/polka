#!/bin/bash

# Get the current directory
DIR="$( cd "$(dirname "$0" )" && pwd )"

# Link executable dot files to $HOME
for dotfile in $(find $DIR -type f -maxdepth 1 -name ".*"); do
    [ -x $dotfile ] || continue
    ln -fs $dotfile "${HOME}/$(basename $dotfile)"
done

# Link rc files in .bashrc.d
[ -d "${HOME}/.bashrc.d" ] || mkdir "${HOME}/.bashrc.d"
for dotfile in $DIR/.bashrc.d/*; do
    ln -fs $dotfile "${HOME}/.bashrc.d/$(basename $dotfile)"
done

# Link programs files in bin
[ -d "${HOME}/bin" ] || mkdir "${HOME}/bin"
for program in $DIR/bin/*; do
    [ -x $program ] || continue
    ln -fs $program "${HOME}/bin/$(basename $program)"
done
