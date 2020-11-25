#!/usr/bin/env bash

set -euxo pipefail

shellcheck bin/* ubuntu/{.bash_aliases,.bashrc,desktop-setup.sh} dotfiles.sh
