#!/bin/env/bash

install-copr() { #maybe optimise making a map
    sudo dnf copr enable varlad/yazi -y && sudo dnf install yazi -y
    sudo dnf copr enable pgdev/ghostty -y && sudo dnf install ghostty -y
    sudo dnf copr enable foopsss/shell-color-scripts -y && sudo dnf install shell-color-scripts -y
    sudo dnf copr enable atim/starship -y && sudo dnf install starship -y
    sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit
}

rpm_array=(
    "zsh" "neovim" "git" "fzf"
    "bat" "gparted" "btop" 
    "eza" "fastfetch" "wl-clipboard"
    "gnome-tweaks" "corectrl" "zoxide"
    "btrfs-assistant" "corectrl" "pavucontrol"
    "ripgrep" "papirus-icon-theme-dark.noarch"
)

flatpak_array=(
    "app.zen_browser.zen"
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
    "org.gnome.Papers"
    "net.codelogistics.webapps"
    "org.jdownloader.JDownloader"
    "org.vinegarhq.Sober"
)

install-rpm() {
    for package in "$@"; do
        sudo dnf install "$package" -y
    done
}

install-flatpak() {
    for package in "$@"; do
        flatpak install -y flathub "$package"
    done
}

install-rpm "${rpm_array[@]}"
install-flatpak "${flatpak_array[@]}"
install-copr

#installing lazydocker 
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
