#!/usr/bin/env bash

set -euxo pipefail

ln -sf "$(pwd)/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/ubuntu/.bash_profile" ~/.bash_profile
ln -sf "$(pwd)/ubuntu/.bashrc" ~/.bashrc
ln -sf "$(pwd)/.gitconfig" ~/.gitconfig

# Check to make sure directory does not already exist
# before creating a symlink for it. This prevents a
# looping issue with directory symlinks.
if [ ! -d ~/.tmuxinator ]; then ln -sf "$(pwd)/.tmuxinator" ~/.tmuxinator; fi

if [ ! -d ~/.config/sublime-text-3/Packages/User ]; then ln -sf "$(pwd)/sublime" ~/.config/sublime-text-3/Packages/User; fi
