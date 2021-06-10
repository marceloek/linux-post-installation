#!/bin/bash
# 0 - Configure DNF for faster download:
# sudo nano /etc/dnf/dnf.
#     Add the lines:
# max_parallel_downloads=10
# fastestmirror=1

# 1 - Update your system:
sudo dnf autoremove

sudo dnf clean all

sudo dnf check-update

sudo dnf upgrade -y

# 2 - Add the repositories RPM Fusion in Fedora 34:
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# 3 - Change the system settings:
# 3.1 - Disable mouse acceleration and enable tap to click in 'Mouse and Touchpad' settings
# 3.2 - Enable minize, maximize buttons in gnome-tweaks

# 4 - Install additional softwares:
# teamviewer
https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm

# vmware
https://download3.vmware.com/software/player/file/VMware-Player-16.1.2-17966106.x86_64.bundle

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# microsoft-edge-beta
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-beta.repo

sudo dnf check-update

sudo dnf install -y vlc steam qbitorrent audacity piper steam.i686 uget aria2 git neofetch sysfsutils samba gparted code gnome-extensions gnome-tweaks microsoft-edge-beta file-roller bleachbit cpu-x

sudo dnf in teamviewer.x86_64.rpm

sudo chmod +x VMware-Player-16.1.2-17966106.x86_64.bundle
sudo ./VMware-Player-16.1.2-17966106.x86_64.bundle

# 5 - Remove useless softwares:
sudo dnf rm gnome-photos gnome-boxes gnome-totem gnome-maps gnome-contacts gnome-cheese simple-scan libreoffice*

# 6 - Install customization (icon, cursor and material design themes)
git clone https://github.com/vinceliuice/vimix-icon-theme.git
cd Vimix-icon-theme
./install.sh

git clone https://github.com/vinceliuice/Vimix-cursors.git
cd Vimix-cursors
./install.sh

git clone https://github.com/vinceliuice/vimix-gtk-themes.git
cd Vimix-gtk-themes
./install.sh

# manual installation softwares: obs-studio, discord
