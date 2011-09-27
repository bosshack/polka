#!/bin/bash

# Get the current directory
DIR="$( cd "$(dirname "$0" )" && pwd )"

# Link executable dot files to $HOME
for dotfile in $(find $DIR -type f -maxdepth 1 -name ".*"); do
    [ -x $dotfile ] || continue
    ln -fs $dotfile "${HOME}/$(basename $dotfile)"
done

# Create ~/.bashrc.d if it does not exist
[ -d "${HOME}/.bashrc.d" ] || mkdir "${HOME}/.bashrc.d"

# Link rc files in .bashrc.d
for dotfile in $DIR/.bashrc.d/*; do
    ln -fs $dotfile "${HOME}/.bashrc.d/$(basename $dotfile)"
done
