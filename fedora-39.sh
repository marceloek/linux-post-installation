#!/bin/bash

REL="$(rpm -E %fedora)"
echo "Hello [$USER], you are running [Fedora $REL]"

update_system() {
    echo -e "\n Updating system: \n"

    sudo dnf -y update --refresh
}

update_firmware() {
    echo -e "\n Updating devices with firmware supported by fwupd: \n"

    sudo fwupdmgr get-devices
    sudo fwupdmgr refresh --force
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
}

update_node() {
    echo -e "\n Updating Node.js LTS and package managers: \n"

    bash -ic "nvm install --lts"
    bash -ic "nvm use --lts"
    npm install -g npm pnpm bun yarn
}

setup_dnf_faster_download() {
    echo -e "\n Configuring DNF for faster downloads: \n"

    sudo sh -c 'echo -e "max_parallel_downloads=10\nfastestmirror=True" >> /etc/dnf/dnf.conf'
    sudo dnf -y check-update --refresh
}

setup_repository() {
    echo -e "\n Installing repositories: \n"

    # RPM Fusion
    sudo dnf -y install \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$REL.noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$REL.noarch.rpm

    # Cisco OpenH264
    sudo dnf config-manager --enable fedora-cisco-openh264

    # AppStream metadata
    sudo dnf -y groupupdate core
}

setup_media_codec() {
    echo -e "\n Installing media codecs: \n"

    # switch to full FFmpeg
    sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing

    # additional codec for GStreamer and sound-and-video
    sudo dnf -y groupupdate multimedia sound-and-video

    # OpenH264 for Firefox
    sudo dnf -y install gstreamer1-plugin-openh264 mozilla-openh264
}

setup_hw_codec() {
    echo -e "\n Installing hardware accelerated codecs: \n"

    # for intel igpu
    sudo dnf -y install intel-media-driver

    # for amd gpu
    sudo dnf -y swap mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf -y swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

    # for amd gpu i686 (Steam)
    sudo dnf -y swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
    sudo dnf -y swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
}

setup_flathub() {
    echo -e "\n  Installing Flathub repository and some apps: \n"

    flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    # Spotify
    flatpak --user -y install flathub com.spotify.Client
}

setup_optional_software() {
    echo -e "\n Installing optionals softwares: \n"

    sudo dnf -y install mpv vlc steam btop qbittorrent aria2 git neofetch samba \
        cpu-x google-roboto-fonts google-roboto-mono-fonts jetbrains-mono-fonts \
        goverlay gamemode fish obs-studio yt-dlp discord lm_sensors thunderbird \
        chromium cabextract lzip p7zip p7zip-plugins unrar alacritty
}

setup_microsoft_fonts() {
    echo -e "\n Installing Microsoft Fonts (Arial, Times New Roman, etc.): \n"

    sudo dnf -y install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
}

setup_nvm() {
    echo -e "\n Installing Node Version Manager (nvm): \n"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

setup_kernel_args() {
    echo -e "\n Removing and re-adding args to default kernel boot entry: \n"

    KERNEL_PATH="$(sudo grubby --default-kernel)"
    KERNEL_ARGS="amdgpu.ppfeaturemask=0xffffffff intel_iommu=on"

    sudo grubby --remove-args "$KERNEL_ARGS" --update-kernel ALL
    sudo grubby --args "$KERNEL_ARGS" --update-kernel "$KERNEL_PATH"
    sudo grubby --info ALL
}

setup_vscode() {
    echo -e "\n Installing Visual Studio Code (VSCode): \n"

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    sudo dnf -y install code
}

setup_docker() {
    echo -e "\n Installing Docker Engine (Docker CE): \n"

    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

setup_docker_start_on_boot() {
    echo -e "\n Configuring Docker service to start on boot with systemd: \n"

    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

setup_docker_nonroot_user() {
    echo -e "\n Adding your user to the docker group: \n"

    sudo usermod -aG docker $USER
}

menu() {
    echo -e "\nSelect what you want to do:"

    echo " [1] Update system;"
    echo " [2] Update fwupd firmwares;"
    echo " [3] Update Node.js and package managers;"

    echo " [4] Setup Node Version Manager installation;"
    echo " [5] Setup kernel arguments;"
    echo " [6] Setup Visual Studio Code installation;"
    echo " [7] Setup Docker installation;"
    echo " [8] Setup Docker startup;"
    echo " [9] Setup Docker as non-root user;"

    echo "[10] Initial setup;"

    echo " [0] Exit menu."

    echo -e -n "\nEnter your menu choice [0-10]: "
}

while :; do
    menu
    read OPTION

    case $OPTION in
    1)
        update_system
        ;;
    2)
        update_firmware
        ;;
    3)
        update_node
        ;;
    4)
        setup_nvm
        ;;
    5)
        setup_kernel_args
        ;;
    6)
        setup_vscode
        ;;
    7)
        setup_docker
        ;;
    8)
        setup_docker_start_on_boot
        ;;
    9)
        setup_docker_nonroot_user
        ;;
    10)
        setup_dnf_faster_download
        setup_repository

        update_system
        update_firmware

        setup_media_codec
        setup_hw_codec
        setup_flathub
        setup_optional_software
        setup_microsoft_fonts
        ;;
    0)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option"
        ;;
    esac
done
