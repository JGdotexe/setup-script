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

sudo dnf update -y 
sudo dnf upgrade

sourcing(){
    for file in dotfiles_array; do
        if [ -f $HOME/.dotfiles/$file ]; then
            source $file
        fi
    done
}

if [ -f $PWD/installation.sh ]; then
    . $PWD/installation.sh
fi

if [ -f $PWD/setup-docker.sh ]; then
    . $PWD/setup-docker.sh
fi

if [ -f $PWD/setup-dofiles.sh ]; then
    . $PWD/setup-dofiles.sh
fi

if [ -f $PWD/setup-ssh.sh ]; then
    . $PWD/setup-ssh.sh
fi

flatpak update -y

sourcing
