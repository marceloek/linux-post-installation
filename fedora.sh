#!/bin/bash
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
sudo dnf install -y fedora-workstation-repositories
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Optional:
echo "2.1 - Install nvidia driver:"
# Source: https://docs.fedoraproject.org/en-US/quick-docs/how-to-set-nvidia-as-primary-gpu-on-optimus-based-laptops/
sudo dnf check-update -y
sudo dnf update --refresh

sudo sh -c 'echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf'

sudo dnf install -y gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686

echo "wait 6 minutes"
sleep 360
sudo akmods --force
sudo dracut --force

echo "Reboot in 10s ..."
sleep 10
sudo reboot

sudo dnf install vdpauinfo libva-vdpau-driver libva-utils
sudo dnf remove xorg-x11-drv-nouveau

sudo cp -p /usr/share/X11/xorg.conf.d/nvidia.conf /etc/X11/xorg.conf.d/nvidia.conf
# add the line: 'Option "PrimaryGPU" "yes"' below the line 'Option "BaseMosaic" "on"'
sudo sed -i '11 i \\tOption "PrimaryGPU" "yes"' /etc/X11/xorg.conf.d/nvidia.conf

echo "3 - Install additional softwares:"
echo "teamviewer"
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm

echo "vmware"
wget https://download3.vmware.com/software/player/file/VMware-Player-16.1.2-17966106.x86_64.bundle

echo "vscode"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

echo "microsoft-edge-beta"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-beta.repo

sudo dnf check-update

sudo dnf install -y libreoffice vlc steam qbittorrent audacity piper steam.i686 uget aria2 git neofetch sysfsutils samba gparted code gnome-extensions-app gnome-tweaks microsoft-edge-beta file-roller bleachbit cpu-x google-roboto-fonts google-roboto-mono-fonts nvidia-driver

sudo dnf in -y teamviewer.x86_64.rpm

sudo chmod +x VMware-Player-16.1.2-17966106.x86_64.bundle
sudo ./VMware-Player-16.1.2-17966106.x86_64.bundle

echo "4 - Remove useless softwares:"
sudo dnf rm -y gnome-photos gnome-boxes totem gnome-maps gnome-contacts cheese simple-scan rhythmbox gedit

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
./install.sh -a
cd ..

bash -c "$(wget -qO- https://git.io/vQgMr)"
# input: 03

sudo rm -r teamviewer* vimix* Vimix* VMware*

echo "Finish. After reboot, you have to change the system settings and install the manual software installation"

echo "Reboot in 10s ..."
sleep 10
sudo reboot

sudo dnf autoremove -y
sudo dnf clean all -y

sudo dnf check-update -y
sudo dnf update -y --refresh

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
