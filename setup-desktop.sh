#!/usr/bin/env bash

#probably gona rip it in modules but lets keep it this way for now

#-----TO-DO-----#
#pull my dotfiiles
#- moove and make sym links to .dotfiles directory !!done
#including nvim con figs !!done
#install softwares trough rpm !!done
#install softwares trough flatpak/flathub !!done
#install copr repos !!done
#setup fish TODO
#add gconf comands for gnome TODO
#- removing hibernation - search it up TODO
#- adding vim motions to notes TODO
#source config files at the end !!done
#add Dependencies !!done
# install docker - maybe make in another file !!done
#Update packages !!done

# maybe separate the scripts for modularity

# Defining color codes 
RED='\033[0;31m'
NC='\033[0m' 


rpm_array=(
    "neovim" "git" "fzf" 
    "cosmic-store" "gparted" "btop" 
    "gnome-tweaks" "corectrl" "zoxide"
    "btrfs-assistant" "corectrl" "pavucontrol"
    "ripgrep" "papirus-icon-theme-dark.noarch"
    "eza"
)
flatpak_array=(
    "com.brave.Browser"
    "com.rtosta.zapzap" 
    "org.telegram.desktop"
    "org.torproject.torbrowser-launcher"
    "com.obsproject.Studio" 
    "org.videolan.VLC" 
    "org.qbittorrent.qBittorrent"
    "io.github.equicord.equibop"
    "io.github.thetumultuousunicornofdarkness.cpu-x"
    "io.github.giantpinkrobots.flatsweep"
    "com.github.tchx84.Flatseal"
    "com.mattjakeman.ExtensionManager"
    "com.tonikelope.MegaBasterd" 
    "io.github.alainm23.planify"
    "org.virt_manager.virt-manager/x86_64/stable" 
    "it.mijorus.gearlever"
    "com.github.johnfactotum.pantheon-files"
    "com.stremio.Stremio" 
    "io.github.jonmagon.kdiskmark" 
    "io.missioncenter.MissionCenter"
    "org.gnome.Papers "
    "app.zen_browser.zen"
    "net.codelogistics.webapps"
)

dotfiles_array(
    ".aliasrc" ".bashrc" ".zshrc"
    "config" "alacritty.toml" "kitty.conf"
)

sudo dnf update -y 
sudo dnf upgrade

# Functions

sourcing(){
    for file in dotfiles_array; do
        if [ -f $HOME/.dotfiles/$file ]; then
            source $file
        fi
    done
}

install-copr() { #maybe optimise making a map
    sudo dnf copr enable varlad/yazi -y && sudo dnf install yazi -y
    sudo dnf copr enable pgdev/ghostty -y && sudo dnf install ghostty -y
    sudo dnf copr enable foopsss/shell-color-scripts -y && sudo dnf install shell-color-scripts -y
}


function error_message {
    echo -e "${RED}$1${NC}"
}

function is-installed(){
    if [ -z "$1" ]; then
        error_message "Error: Package name is required."
        return 1
    fi

    PACKAGE=$1
    if dnf list --installed $PACKAGE &> /dev/null; then
        echo "$PACKAGE is installed"
    else
        echo "$PACKAGE is not installed"
        echo "installing package"
        installit "$PACKAGE"
    fi
}

install-rpm() {
    for package in rpm_array; do
        sudo dnf install package -y
    done
}

install-flatpak () {
    for package in flatpak_array; do
        sudo flatpak install --user flathub package
    done
}

function installit(){
    PACKAGE_TOINSTALL=$1
    sudo dnf install -y $PACKAGE_TOINSTALL 
}

#installing the packages
install-copr
install-rpm
install-flatpak
flatpak install --user https://sober.vinegarhq.org/sober.flatpakref #installing sober


if [ -f $PWD/setup-docker.sh ]; then
    . $PWD/setup-docker.sh
fi

#Creating directories
[ -d "$HOME/git" ] && echo "Directory exists, proceeding" || { echo "making git directory"; mkdir -p "$HOME/git" }

[ -d "$HOME/.dotfiles" ] && echo "Directory exists, proceeding" ||{ echo "making dotfiles cdirectory"; mkdir -p "$HOME/.dotfiles" } 

[ -d "$HOME/.config/nvim" ] && echo "Directory exists, proceeding" || { echo "making nvim directory"; mkdir -p "$HOME/.config/nvim" }

#Setting Up github dotfiles
#is-installed "git" && ( 
#    cd $HOME/git 
#    git clone https://github.com/JGdotexe/dotfiles.git $HOME/.dotfiles && git clone https://github.com/JGdotexe/nvim-config.git $HOME/.config/nvim
#)

git clone https://github.com/JGdotexe/dotfiles.git "$HOME/.dotfiles" && git clone https://github.com/JGdotexe/nvim-config.git "$HOME/.config/nvim" 

ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/.aliasrc" "$HOME/.aliasrc"
[ ! -d "$HOME/.config/ghostty" ] && mkdir -p "$HOME/.config/ghostty" && ln -s "$HOME/.dotfiles/config" "$HOME/.config/ghostty"


#for last 
sudo dnf update -y && sudo dnf upgrade -y

flatpak update -y

sourcing
