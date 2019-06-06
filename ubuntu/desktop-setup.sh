#!/bin/bash
echo "Get The Basics"

mkdir ~/Development
mkdir ~/AppImage

sudo apt -y install software-properties-common python-software-properties

# PPAs
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo add-apt-repository ppa:system76/pop
sudo add-apt-repository -y ppa:stebbins/handbrake-releases
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
sudo add-apt-repository ppa:system76/pop

echo "Updating Repos"

sudo apt update

echo "Installing Packages"

sudo apt install -y preload ubuntu-tweak gdebi tree htop openssh-server git curl tig shellcheck ripgrep ubuntu-make

#sudo apt install -y vlc bleachbit

sudo apt install -y chromium-browser
sudo umake web firefox-dev

## Firewall
sudo apt install gufw

echo "Dev Stuff"

sudo apt install -y nginx
sudo apt install sublime-text

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# codecs
#sudo apt install -y handbrake handbrake-cli
sudo apt install -y libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras

echo "Language Time!"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt install -y golang-go ubuntu-sdk

curl -sSf https://static.rust-lang.org/rustup.sh | sh

echo "Tweaks"

sudo apt install pop-theme pop-icon-theme

# Normal scrolling
#sudo gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo "GNOME"
sudo apt install gnome-shell gnome-tweak-tool
sudo apt install pop-theme

gsettings set org.gnome.desktop.interface clock-format 12h

echo "Make Sure MySql is Toast"
sudo update-rc.d mysql remove
sudo update-rc.d apache2 remove

echo "Clean Up"
sudo apt autoremove && sudo apt -y autoclean && sudo apt -y clean

echo "Done!"
exit 0
