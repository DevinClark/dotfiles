#!/usr/bin/env bash

set -euxo pipefail

function add_ppa() {
  for i in "$@"; do
    if [ grep -h "^deb.*$i" /etc/apt/sources.list.d/* -ne 0 ]
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
      pushd "$DIR"
      git pull
      popd
  fi
}

function install_tmux_from_source() {
  VERSION="${1:-3.2}"
  sudo apt -y install libevent-dev libncurses-dev
  wget "https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz"
  tar xf "tmux-${VERSION}.tar.gz"
  rm -f "tmux-${VERSION}.tar.gz"

  pushd "tmux-${VERSION}"
  ./configure
  sudo make install
  popd

  sudo rm -rf /usr/local/src/tmux-*
  sudo mv "tmux-${VERSION}" /usr/local/src
}

function install_fzf() {
  clone_or_pull "https://github.com/junegunn/fzf.git" "$HOME/.fzf"

  pushd ~/.fzf
  ./install --key-bindings --completion --no-update-rc
  popd
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
  if [ ! -f ~/.npmrc ]; then touch ~/.npmrc; fi

  npm config set prefix ~/npm
  npm config set save-exact true
}

function install_go() {
  rm -rf "~/.go"

  local tmpdir=$(mktemp -d)
  local installer="$tmpdir/installer_linux"

  curl -L https://storage.googleapis.com/golang/getgo/installer_linux -o "$installer"

  chmod +x "$installer"
  eval "$installer"

  rm -rf "$tmpdir"
  unset tmpdir
}

function install_rust() {
  # -s -- allows me to pass args to the piped script.
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

}

function install_ruby() {
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles

  source ~/.rvm/scripts/rvm

  rvm reload

  rvm install "$1"
  rvm --default use "$1"

  sudo apt install -y ruby-dev
}

function install_postgres() {
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

  sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main"
  sudo apt install -y postgresql postgresql-contrib libpq-dev postgresql-13 postgresql-client-13

  sudo systemctl start postgresql@12-main
  pg_ctlcluster 12 main start

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
  local tmpdir=$(mktemp -d)

  curl -L https://zoom.us/client/latest/zoom_amd64.deb -o "$tmpdir/zoom_amd64.deb"

  sudo dpkg -i "$tmpdir/zoom_amd64.deb"

  sudo apt --fix-broken install

  rm -rf "$tmpdir"
  unset tmpdir
}
