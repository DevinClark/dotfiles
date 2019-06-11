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
    elsejk
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

sudo apt install -y nginx sublime-text vagrant

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
sudo dpkg -i ripgrep_11.0.1_amd64.deb
rm ripgrep_11.0.1_amd64.deb


# codecs
#sudo apt install -y handbrake handbrake-cli
sudo apt install -y libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras

echo "Language Time!"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt install -y golang-go ruby-full

curl https://sh.rustup.rs -sSf | sh

sudo gem install tmuxinator

echo "Tweaks"

# Normal scrolling
# sudo gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo "GNOME"
sudo apt install -y gnome-shell gnome-tweak-tool pop-gnome-shell-theme
sudo apt install -y pop-theme pop-icon-theme

gsettings set org.gnome.desktop.interface clock-format 12h

echo "Make Sure MySql is Toast"
sudo update-rc.d mysql remove
sudo update-rc.d apache2 remove

echo "Clean Up"
sudo apt upgrade -y
sudo apt autoremove -y && sudo apt -y autoclean && sudo apt -y clean

echo "Done!"
exit 0
