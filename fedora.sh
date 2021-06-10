#!/bin/bash
# 0 - Configure DNF for faster download:
#     Add the lines:
sudo sh -c  'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
sudo sh -c  'echo "fastestmirror=1" >> /etc/dnf/dnf.conf'

echo "1 - Update your system:"
sudo dnf autoremove

sudo dnf clean all

sudo dnf check-update

sudo dnf upgrade -y

echo "2 - Add the repositories RPM Fusion in Fedora 34:"
sudo dnf install fedora-workstation-repositories 
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Optional:
# 2.1 - Install nvidia driver:
# Source: https://docs.fedoraproject.org/en-US/quick-docs/how-to-set-nvidia-as-primary-gpu-on-optimus-based-laptops/
sudo dnf update --refresh
sudo dnf install -y gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686 nvidia-driver

# sudo akmods --force
# sudo dracut --force

# sudo reboot

# sudo cp -p /usr/share/X11/xorg.conf.d/nvidia.conf /etc/X11/xorg.conf.d/nvidia.conf
# sudo nano /etc/X11/xorg.conf.d/nvidia.conf
# add the line: 'Option "PrimaryGPU" "yes"' below the line 'Option "BaseMosaic" "on"'
sudo sed '11 i "       Option "PrimaryGPU" "yes""' /etc/X11/xorg.conf.d/nvidia.conf

# sudo reboot

echo "3 - Install additional softwares:" 
# teamviewer
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm

# vmware
wget https://download3.vmware.com/software/player/file/VMware-Player-16.1.2-17966106.x86_64.bundle

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# microsoft-edge-beta
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-beta.repo

sudo dnf check-update

sudo dnf install -y vlc steam qbittorrent audacity piper steam.i686 uget aria2 git neofetch sysfsutils samba gparted code gnome-extensions-app gnome-tweaks microsoft-edge-beta file-roller bleachbit cpu-x google-roboto-fonts google-roboto-mono-fonts

sudo dnf in -y teamviewer.x86_64.rpm

sudo chmod +x VMware-Player-16.1.2-17966106.x86_64.bundle
sudo ./VMware-Player-16.1.2-17966106.x86_64.bundle

echo "4 - Remove useless softwares:"
sudo dnf rm -y gnome-photos gnome-boxes totem gnome-maps gnome-contacts cheese simple-scan rhythmbox gedit libreoffice*

echo "5 - Install customization (icon, cursor and material design themes)"
git clone https://github.com/vinceliuice/vimix-icon-theme.git
cd Vimix-icon-theme
./install.sh -a
cd ..

git clone https://github.com/vinceliuice/Vimix-cursors.git
cd Vimix-cursors
./install.sh
cd ..

git clone https://github.com/vinceliuice/vimix-gtk-themes.git
cd vimix-gtk-themes
./install.sh -a
cd ..

sudo rm -r teamviewer* vimix* Vimix* VMware*

sudo reboot

sudo dnf autoremove

sudo dnf clean all

sudo dnf check-update 

sudo dnf update --refresh

echo "Finish. Now you have to change the system settings and install the manual software installation"

# 6 - Change the system settings:
# 6.1 - NOTEBOOK - Enable tap to click in 'Mouse and Touchpad' settings
# 6.2 - Gnome Tweaks settings:
# 6.2.0 - Add the extesion in "https://extensions.gnome.org/" User Themes by fmuellner
# 6.2.1 - Disable suspend when laptop lid is closed in "General"
# 6.2.2 - Set the themes to Vimix-dark-beryl in "Appearance"
# 6.2.3 - Change the fonts to Roboto Regular (11) and Roboto Mono Regular (11) in "Fonts"
# 6.2.4 - Disable the Acceleration Profile in "Keyboard & Mouse" 
# 6.2.5 - Enable minize, maximize buttons in "Window Titlebars"
# 6.2.6 - Enable Center New Windows in "Windows"

# manual installation softwares: obs-studio, discord
