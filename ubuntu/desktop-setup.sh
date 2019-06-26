#!/bin/bash
echo "Get The Basics"

mkdir ~/Development
mkdir ~/AppImage
touch ~/.local_bashrc

sudo apt -y install software-properties-common

add_ppa() {
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

# PPAs
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
add_ppa system76/pop stebbins/handbrake-releases ubuntu-desktop/ubuntu-make

echo "Updating Repos"

sudo apt update

echo "Installing Packages"

# make exfat usb drives work
sudo apt install -y exfat-fuse exfat-utils

sudo apt install -y tree htop git curl tig shellcheck tmux xclip

#sudo apt install -y vlc bleachbit

sudo apt install -y chromium-browser

## Firewall
sudo apt install -y gufw

echo "Dev Stuff"

sudo apt install -y nginx sublime-text vagrant sublime-merge

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
sudo dpkg -i ripgrep_11.0.1_amd64.deb
rm ripgrep_11.0.1_amd64.deb


# codecs
#sudo apt install -y handbrake handbrake-cli
sudo apt install -y faac faad ffmpeg2theora flac gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly icedax id3v2 lame libdvd-pkg libdvdnav4 libdvdread4 libjpeg-progs libmad0 mencoder mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 sox ubuntu-restricted-extras uudeview vorbis-tools

echo "Language Time!"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt install -y golang-go

curl https://sh.rustup.rs -sSf | sh

gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles

rvm install 2.6.3
rvm --default use 2.6.3

sudo gem install tmuxinator

echo "Tweaks"

# Normal scrolling
# sudo gsettings set com.canonical.desktop.interface scrollbar-mode normal

sudo sysctl -w fs.file-max=100000

# Make sublime text the default editor
# https://askubuntu.com/a/227567
sudo sed -i 's/gedit/sublime_text/g' /etc/gnome/defaults.list

echo "GNOME"
sudo apt install -y gnome-shell gnome-tweak-tool pop-gnome-shell-theme
sudo apt install -y pop-theme pop-icon-theme
sudo apt install fonts-powerline

gsettings set org.gnome.desktop.interface clock-format 12h

./gnome-terminal-dark-install.sh Default

snap remove gnome-calculator
sudo apt install gnome-calculator

echo "Make Sure MySql is Toast"
sudo update-rc.d mysql remove
sudo update-rc.d apache2 remove

echo "Clean Up"
sudo apt upgrade -y
sudo apt autoremove -y && sudo apt -y autoclean && sudo apt -y clean

echo "Done!"
exit 0
