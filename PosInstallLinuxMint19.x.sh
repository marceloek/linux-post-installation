#!/usr/bin/env bash
# ----------------------------- VARIAVEIS ----------------------------- #
PPA_LIBRATBAG="ppa:libratbag-piper/piper-libratbag-git"
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_PYTHON="ppa:deadsnakes/ppa"
PPA_AUDACITY="ppa:ubuntuhandbook1/audacity"
PPA_OBS="ppa:obsproject/obs-studio"
PPA_GRUB_CUSTOMIZER="ppa:danielrichter2007/grub-customizer"
PPA_INKSCAPE="ppa:inkscape.dev/stable"
PPA_PAPER_ICON="ppa:snwh/ppa"
PPA_PAPIRUS_ICON="ppa:papirus/papirus"
PPA_PADOKA_MESA="ppa:paulo-miguel-dias/pkppa"
PPA_APLATTNER="ppa:aplattner/ppa"
PPA_APPS="ppa:linuxuprising/apps"
PPA_JAVA="ppa:linuxuprising/java"
PPA_TLP="ppa:linrunner/tlp"
PPA_UGET="ppa:plushuang-tw/uget-stable"

URL_XAMPP="https://www.apachefriends.org/xampp-files/7.3.12/xampp-linux-x64-7.3.12-0-installer.run"
URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.10.1-1_amd64.deb"
URL_4K_YOUTUBE_MP3="https://dl.4kdownload.com/app/4kyoutubetomp3_3.10.1-1_amd64.deb?source=website"
URL_OPERA="https://download3.operacdn.com/pub/opera/desktop/65.0.3467.62/linux/opera-stable_65.0.3467.62_amd64.deb"
URL_CPU_X="https://github.com/X0rg/CPU-X/releases/download/v3.2.4/CPU-X_v3.2.4_Ubuntu.tar.gz"
URL_DISCORD="https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb"
URL_UGET="https://razaoinfo.dl.sourceforge.net/project/urlget/uget%20%28stable%29/2.2.1/uget_2.2.1-0ubuntu0~bionic_amd64.deb"
URL_OOMOX="https://github.com/themix-project/oomox/releases/download/1.12.5/oomox_1.12.5_17.04+.deb"
URL_VSCODE="https://az764295.vo.msecnd.net/stable/26076a4de974ead31f97692a0d32f90d735645c0/code_1.41.1-1576681836_amd64.deb"
URL_LIBRE_OFFICE="https://download.documentfoundation.org/libreoffice/stable/6.3.4/deb/x86_64/LibreOffice_6.3.4_Linux_x86-64_deb.tar.gz"

DIRETORIO_DOWNLOADS="$HOME/Desktop/programas"
DIRETORIO_DESKTOP="$HOME/Desktop"

PROGRAMAS_PARA_INSTALAR=(
    audacity                    # editor de audio
    snapd                       # snap
    mint-meta-codecs            # codecs e vlc
    winff                       # conversor de video
    flameshot                   # print screen
    postgresql                  # db postgresql
    bleachbit                   # gerencia limpeza de arquivos
    steam-installer             # steam
    steam-devices
    steam:i386
    ratbagd                     # depedencia do piper
    piper                       # gerenciador de mouse
    lutris                      # gerenciador de jogos linux
    libvulkan1                  # demais dependencias 
    libvulkan1:i386
    libgnutls30:i386
    libldap-2.4-2:i386
    libgpg-error0:i386
    libxml2:i386
    libasound2-plugins:i386
    libsdl2-2.0-0:i386
    libfreetype6:i386
    libdbus-1-3:i386
    libsqlite3-0:i386
    software-properties-common 
    apt-transport-https 
    wget                        # idm free-source
    aria2                       
    build-essential 
    git                         # git
    python3                     # linguagem python3
    python3.7                   # linguagem python3 versao 3.7
    python-pip                  # utilitario pip
    gcc                         # todos os gcc's
    g++
    gcc-5
    g++-5
    gcc-6
    g++-6
    gcc-7
    g++-7
    gcc-8
    g++-8
    gcc-9
    g++-9
    chromium-browser            # navegador chromium
    gparted                     # gerenciador de particoes
    obs-studio                  # gravador de video
    grub-customizer             # gerenciador de grub
    inkscape                    # gerenciar de imagens .svg
    papirus-icon-theme          # tema de icones papirus
    paper-icon-theme            # tema de icones paper
    tlp                         # auxiliador duracao da bateria
    qbittorrent                 # gerenciador torrent
    telegram-desktop            # telegram para pc 
    whatsapp-desktop            # whatsapp para pc
    hardinfo                    # visualizador de hardware do sistema 
    samba                       # compartilhador de pastas
    nvidia-settings             # painel nvidia
    screenfetch                 # visualizador de hardware pelo bash
    screen                      # utilitario para instalacao de drivers
    ttf-mscorefonts-installer   # fontes de letras da microsoft
    jstest-gtk                  # verifica o reconhecimento dos botoes do controle do xbox
    xboxdrv                     # service necessario para a coneccao do contole do xbox
    sysfsutils                  # service necessario para edicao do arquivo sysfs/etc/sysfs.conf e incluir ao seu final a linha: /module/bluetooth/parameters/disable_ertm=1
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositorio ##
sudo apt update -y

## Adicionando repositorios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo apt-add-repository "$PPA_LIBRATBAG" -y
sudo apt-add-repository "$PPA_LUTRIS" -y
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
sudo apt-add-repository "$PPA_PYTHON" -y
sudo apt-add-repository "$PPA_AUDACITY" -y
sudo apt-add-repository "$PPA_OBS" -y
sudo apt-add-repository "$PPA_GRUB_CUSTOMIZER" -y
sudo apt-add-repository "$PPA_INKSCAPE" -y
sudo apt-add-repository "$PPA_PAPER_ICON" -y
sudo apt-add-repository "$PPA_PAPIRUS_ICON" -y 
sudo apt-add-repository "$PPA_PADOKA_MESA" -y 
sudo apt-add-repository "$PPA_APLATTNER" -y 
sudo apt-add-repository "$PPA_APPS" -y 
sudo apt-add-repository "$PPA_JAVA" -y 
sudo apt-add-repository "$PPA_TLP" -y 
sudo apt-add-repository "$PPA_UGET" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE bionic main"
# -------------------------------------------------------------------------- #

# -------------------------------- EXECUCAO -------------------------------- #
## Atualizando o repositorio depois da adicao de novos repositorios ##
sudo apt update -y

## -------------- Download e instalacao de programas externos ------------- ##
cd $DIRETORIO_DESKTOP
#wget -c "$URL_OOMOX"
wget -c "$URL_DISCORD"
wget -c "$URL_LIBRE_OFFICE"
wget -c "$URL_XAMPP" -O xampp.run
wget -c "$URL_CPU_X" -O cpu-x.tar.gz
tar -xf cpu-x.tar.gz
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_YOUTUBE_MP3"      -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_OPERA"               -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_UGET"                -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VSCODE"              -P "$DIRETORIO_DOWNLOADS"

## ---------- Instalando pacotes .deb baixados na sessão anterior --------- ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt-get --fix-broken install -y

# ------------------------ Instalar programas no apt ----------------------- #
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  # Somente instala se nao estiver instalado
  if ! dpkg -l | grep -q $nome_do_programa; then          
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Snap ##
#sudo snap install photogimp
# -------------------------------------------------------------------------- #

# ----------------------------- POS-INSTALACAO ----------------------------- #
## ------------------ Finalizacao, atualizacao e limpeza ------------------ ##
sudo apt purge flatpak rhythmbox thunderbird hexchat celluloid xviewer transmission-gtk -y
# sudo ubuntu-drivers autoinstall
sudo mintupdate-cli upgrade -r -k -y
sudo apt update && sudo apt dist-upgrade -y
sudo flatpak remove --all
sudo apt autoclean
sudo apt autoremove -y
# -------------------------------------------------------------------------- #
