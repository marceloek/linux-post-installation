#!/bin/bash
cd ~/Downloads

echo "0 - Configure DNF for faster download:"
#     Add the lines:
sudo sh -c 'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "fastestmirror=1" >> /etc/dnf/dnf.conf'


echo "1 - Update your system:"
sudo dnf autoremove -y
sudo dnf clean all -y

sudo dnf check-update -y
sudo dnf update -y --refresh

sudo dnf upgrade -y


echo "2 - Add the repositories RPM Fusion:"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


echo "3 - Installing plugins for playing movies and music"
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel

sudo dnf install lame\* --exclude=lame-devel

sudo dnf group upgrade --with-optional Multimedia


echo "4 - Install additional softwares:"

sudo dnf install -y libreoffice vlc steam qbittorrent audacity aria2 git neofetch samba gparted code bleachbit cpu-x google-roboto-fonts google-roboto-mono-fonts sassc


echo "5 - Install customization (icon, cursor and material design themes)"
git clone https://github.com/vinceliuice/vimix-icon-theme.git
cd vimix-icon-theme
./install.sh -a
cd ..

git clone https://github.com/vinceliuice/Vimix-cursors.git
cd Vimix-cursors
./install.sh
cd ..

git clone https://github.com/vinceliuice/vimix-gtk-themes.git
cd vimix-gtk-themes
./install.sh -t all -s all
cd ..

bash -c "$(wget -qO- https://git.io/vQgMr)"
# input: 03

rm -r vimix* Vimix*

echo "Finish. After reboot, you have to change the system settings and install the manual software installation"

echo "Reboot in 10s ..."
sleep 10
sudo reboot

# 6 - Change the system settings:
# 6.1 - NOTEBOOK - Enable tap to click in 'Mouse and Touchpad' settings
# 6.2 - Gnome Tweaks settings:
# 6.2.0 - Add the extensions: https://www.debugpoint.com/2021/04/gnome-40-extensions/
# 6.2.1 - Disable "Suspend when laptop lid is closed" in "General"
# 6.2.2 - Set the themes to Vimix-dark-beryl in "Appearance"
# 6.2.3 - Change the fonts to Roboto Regular (11) and Roboto Mono Regular (11) in "Fonts"
# 6.2.4 - Disable the Acceleration Profile changing the settings to "Flat" in "Keyboard & Mouse"
# 6.2.5 - Disable the Acceleration Profile in "Keyboard & Mouse"
# 6.2.6 - Enable minize, maximize buttons in "Window Titlebars"
# 6.2.7 - Enable Center New Windows in "Windows"

# manual installation softwares: obs-studio, discord
