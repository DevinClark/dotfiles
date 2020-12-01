#!/usr/bin/env bash

set -euxo pipefail

echo "Get The Basics"

if [ ! -d ~/AppImage ]; then mkdir ~/AppImage; fi
touch ~/.local_bashrc

sudo apt -y install software-properties-common wget tar

function add_ppa() {
  for i in "$@"; do
    grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
      echo "Adding ppa:$i"
      sudo add-apt-repository -y ppa:$i
    else
      echo "ppa:$i already exists"
    fi
  done
}

function clone_or_pull() {
  REPO=$1
  DIR=$2

  if [ ! -d "$DIR" ]; then
    git clone --depth 1 "$REPO" "$DIR"
  else
    (
      cd "$DIR" && git pull
    )
  fi
}

function install_tmux_from_source() {
  VERSION=$1
  sudo apt -y install libevent-dev libncurses-dev
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

function install_fzf() {
  clone_or_pull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

  (
    cd ~/.fzf/ && ./install --key-bindings --completion --no-update-rc
  )
}

function install_ripgrep() {
  VERSION=$1
  wget "https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep_${VERSION}_amd64.deb"
  sudo dpkg -i "ripgrep_${VERSION}_amd64.deb"
  rm "ripgrep_${VERSION}_amd64.deb"
}

function install_nodejs() {
  VERSION="${1:-14}"
  curl -sL "https://deb.nodesource.com/setup_${VERSION}.x" | sudo -E bash -
  sudo apt install -y nodejs
  
  if [ ! -d ~/npm ]; then mkdir ~/npm; fi

  npm config set -g prefix ~/npm
  npm config set -g save-exact true
}

function install_go() {
  sudo apt install -y golang-go
}

function install_rust() {
  # -s -- allows me to pass args to the piped script.
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
}

function install_ruby() {
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles

  sudo usermod -a -G rvm "$USER"

  source ~/.rvm/scripts/rvm

  rvm install "$1"
  rvm --default use "$1"
}

function install_postgres() {
  sudo update-rc.d mysql remove
  sudo update-rc.d apache2 remove
  sudo apt install postgresql postgresql-contrib libpq-dev

  sudo systemctl start postgresql@13-main
  pg_ctlcluster 13 main start
}

function install_sublime_text() {
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

  sudo apt install -y sublime-text sublime-merge

  # Make sublime text the default editor
  # https://askubuntu.com/a/227567
  sudo sed -i 's/gedit/sublime_text/g' /etc/gnome/defaults.list
}

function install_zoom() {
  # download deb into tmpdir
  # install deb
}

# PPAs
add_ppa system76/pop stebbins/handbrake-releases ubuntu-desktop/ubuntu-make
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
add_ppa "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo "Updating Repos"

sudo apt update

echo "Installing Packages"

# make exfat usb drives work
sudo apt install -y exfat-fuse exfat-utils

sudo apt install -y tree htop git curl tig shellcheck xclip urlview entr fd-find

#sudo apt install -y vlc bleachbit

#sudo apt install -y chromium-browser

## Firewall
sudo apt install -y gufw

echo "Dev Stuff"

install_sublime_text
sudo apt install -y nginx vagrant neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

install_tmux_from_source "3.0a"
install_fzf
install_ripgrep "11.0.2"

clone_or_pull https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

function install_codecs() {
  #sudo apt install -y handbrake handbrake-cli
  sudo apt install -y faac faad ffmpeg2theora flac gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly icedax id3v2 lame libdvd-pkg libdvdnav4 libjpeg-progs libmad0 mencoder mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 sox ubuntu-restricted-extras uudeview vorbis-tools
  sudo dpkg-reconfigure libdvd-pkg
}

# install_codecs

echo "Language Time!"
install_nodejs
install_go
install_rust
install_ruby "2.7.1"

sudo gem install tmuxinator

install_postgres

echo "Tweaks"

sudo sysctl -w fs.file-max=100000

npm install -g typescript-language-server bash-language-server vscode-css-languageserver-bin dockerfile-language-server-nodejs nodemon serve

echo "GNOME"
sudo apt install -y gnome-shell gnome-tweak-tool pop-gnome-shell-theme
sudo apt install -y pop-theme pop-icon-theme
sudo apt install fonts-powerline

gsettings set org.gnome.desktop.interface clock-format 12h

./gnome-terminal-dark-install.sh Default

snap remove gnome-calculator
sudo apt install gnome-calculator

install_zoom

echo "Clean Up"
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt -y autoclean
sudo apt -y clean

echo "Done!"
exit 0
