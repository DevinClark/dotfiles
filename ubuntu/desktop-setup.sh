#!/usr/bin/env bash

set -euxo pipefail

echo "Get The Basics"

source ~/Development/dotfiles/ubuntu/install_functions.sh

if [ ! -d ~/AppImage ]; then mkdir ~/AppImage; fi
touch ~/.local_bashrc

sudo apt -y install software-properties-common wget tar

# PPAs
add_ppa system76/pop
add_ppa git-core/ppa
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
add_ppa "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo "Updating Repos"

sudo apt update

echo "Installing Packages"

# make exfat usb drives work
sudo apt install -y exfat-fuse exfat-utils

sudo apt install -y tree htop git curl tig shellcheck xclip urlview entr fd-find

sudo apt install -y chromium-browser

## Firewall
sudo apt install -y gufw

echo "Dev Stuff"

install_sublime_text
sudo apt install -y nginx vagrant neovim

install_tmux_from_source "3.2"
install_fzf
install_ripgrep "11.0.2"

clone_or_pull https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Language Time!"
install_nodejs
install_go
install_rust
install_ruby "3.0.0"

sudo gem install tmuxinator

install_postgres

echo "Tweaks"

sudo sysctl -w fs.file-max=100000

npm install -g typescript-language-server bash-language-server vscode-css-languageserver-bin dockerfile-language-server-nodejs nodemon serve

echo "GNOME"
sudo apt install -y gnome-shell gnome-tweak-tool pop-gnome-shell-theme pop-theme pop-icon-theme fonts-powerline gnome-sushi

gsettings set org.gnome.desktop.interface clock-format 12h

~/Development/dotfiles/ubuntu/gnome-terminal-dark-install.sh Default

install_zoom

echo "Clean Up"
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt -y autoclean
sudo apt -y clean

echo "Done!"
exit 0
