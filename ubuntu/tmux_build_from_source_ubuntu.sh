#!/usr/bin/env bash

set -euxo pipefail

# Steps to build and install tmux from source on Ubuntu.
# Based off https://gist.github.com/indrayam/ebf53ba970241694865e1dd2b1313945
function install_tmux() {
  VERSION=$1
  sudo apt -y install wget tar libevent-dev libncurses-dev
  wget "https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz"
  tar xf "tmux-${VERSION}.tar.gz"
  rm -f "tmux-${VERSION}.tar.gz"

  (
    cd "tmux-${VERSION}"
    ./configure
    sudo make install
  )

  sudo rm -rf /usr/local/src/tmux-*
  sudo mv "tmux-${VERSION}" /usr/local/src
}

## Logout and login to the shell again and run.
## tmux -V
