#!/bin/bash
echo "Get The Basics"

mkdir ~/Development

sudo apt-get -y install software-properties-common python-software-properties

# Load apt-fast
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo add-apt-repository ppa:system76/pop
#sudo add-apt-repository -y ppa:ys/emojione-picker
#sudo add-apt-repository -y ppa:stebbins/handbrake-releases

#sudo apt-get update
#sudo apt-get install -y apt-fast

echo "Updating Repos"

sudo apt-get update

echo "Installing Packages"

sudo apt-get install -y preload ubuntu-tweak gdebi tree htop openssh-server git curl

#sudo apt-get install -y vlc bleachbit

sudo apt-get install -y chromium-browser

#sudo apt-get install -y emojione-picker

## Firewall
#sudo apt-get install gufw

echo "Dev Stuff"

#sudo apt-fast install -y sublime-text-installer
sudo apt-get install -y nginx
sudo apt-get install sublime-text

# codecs
#sudo apt-get install -y handbrake handbrake-cli
sudo apt-get install -y libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras

echo "Language Time!"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo apt-get install -y golang-go ubuntu-sdk

echo "Tweaks"

# Normal scrolling
#sudo gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo "GNOME"
sudo apt install gnome-shell gnome-tweak-tool
sudo apt install pop-theme

gsettings set org.gnome.desktop.interface clock-format 12h

#sudo apt-get remove -y unity-lens-shopping
#sudo apt-get autoremove unity-lens-shopping
#sudo apt-get autoremove unity-lens-music
#sudo apt-get autoremove unity-lens-photos
#sudo apt-get autoremove unity-lens-gwibber
#sudo apt-get autoremove unity-lens-video

echo "Make Sure MySql is Toast"
sudo update-rc.d mysql remove
sudo update-rc.d apache2 remove

echo "Clean Up"
sudo apt-get autoremove && sudo apt-get -y autoclean && sudo apt-get -y clean

echo "Done!"
exit 0
