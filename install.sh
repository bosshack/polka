#!/bin/bash

# Get the current directory
DIR="$( cd "$(dirname "$0" )" && pwd )"

# link dot files to home
for dotfile in $(find $DIR -type f -maxdepth 1 -name ".*"); do
    ln -fs $dotfile "${HOME}/$(basename $dotfile)"
done

# create ~/.bashrc.d if it does not exist
[ -d "${HOME}/.bashrc.d" ] || mkdir "${HOME}/.bashrc.d"
