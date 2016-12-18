#!/bin/bash
echo "Get The Basics"

mkdir ~/Development

sudo apt-get -y install software-properties-common python-software-properties

# Load apt-fast
sudo add-apt-repository -y ppa:apt-fast/stable
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:ys/emojione-picker
sudo add-apt-repository -y ppa:stebbins/handbrake-releases

sudo apt-get update
sudo apt-get install -y apt-fast

echo "Updating Repos"

sudo apt-get update

echo "Installing Packages"

sudo apt-fast install -y preload ubuntu-tweak gdebi tree htop openssh-server git curl

sudo apt-fast install -y vlc bleachbit

sudo apt-fast install -y chromium-browser

sudo apt-fast install -y emojione-picker

## Firewall
sudo apt-get install gufw

echo "Dev Stuff"

sudo apt-fast install -y sublime-text-installer
sudo apt-fast install -y nginx

# codecs
sudo apt-fast install -y handbrake handbrake-cli
sudo apt-fast install -y libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras

echo "Language Time!"
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-fast install -y nodejs

sudo apt-fast install -y golang-go ubuntu-sdk

echo "Tweaks"

# Normal scrolling
sudo gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo "Cleanup Lens"
sudo apt-get remove -y unity-lens-shopping
sudo apt-get autoremove unity-lens-shopping
sudo apt-get autoremove unity-lens-music
sudo apt-get autoremove unity-lens-photos
sudo apt-get autoremove unity-lens-gwibber
sudo apt-get autoremove unity-lens-video

echo "Make Sure MySql is Toast"
sudo update-rc.d mysql remove
sudo update-rc.d apache2 remove

echo "Clean Up"
sudo apt-get autoremove && sudo apt-get -y autoclean &&sudo apt-get -y clean

echo "Done!"
exit 0
