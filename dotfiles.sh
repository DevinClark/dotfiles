#!/usr/bin/env bash

ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
ln -s "$(pwd)/ubuntu/.bash_profile" ~/.bash_profile
ln -s "$(pwd)/ubuntu/.bashrc" ~/.bashrc
ln -s "$(pwd)/.gitconfig" ~/.gitconfig

# Check to make sure directory does not already exist
# before creating a symlink for it. This prevents a
# looping issue with directory symlinks.
if [ ! -d ~/.tmuxinator ]; then ln -s "$(pwd)/.tmuxinator" ~/.tmuxinator; fi

if [ ! -d ~/.config/sublime-text-3/Packages/User ]; then ln -s "$(pwd)/sublime" ~/.config/sublime-text-3/Packages/User; fi
