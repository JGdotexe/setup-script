#Creating directories
[ -d "$HOME/git" ] && echo "Directory exists, proceeding" || { echo "making git directory"; mkdir -p "$HOME/git"; }

[ -d "$HOME/.dotfiles" ] && echo "Directory exists, proceeding" ||{ echo "making dotfiles cdirectory"; mkdir -p "$HOME/.dotfiles"; } 

[ -d "$HOME/.config/nvim" ] && echo "Directory exists, proceeding" || { echo "making nvim directory"; mkdir -p "$HOME/.config/nvim"; }

#Setting Up github dotfiles
#is-installed "git" && ( 
#    cd $HOME/git 
#    git clone https://github.com/JGdotexe/dotfiles.git $HOME/.dotfiles && git clone https://github.com/JGdotexe/nvim-config.git $HOME/.config/nvim
#)

git clone https://github.com/JGdotexe/dotfiles.git "$HOME/.dotfiles" && git clone https://github.com/JGdotexe/nvim-config.git "$HOME/.config/nvim" 

mv "$HOME/.bashrc" "$HOME/.bashrc.back "

ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/.aliasrc" "$HOME/.aliasrc"
[ ! -d "$HOME/.config/ghostty" ] && mkdir -p "$HOME/.config/ghostty" && ln -s "$HOME/.dotfiles/config" "$HOME/.config/ghostty"

git clone https://github.com/Aloxaf/fzf-tab "$HOME/git"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/git"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/git"

source "$HOME/.bashrc"
source "$HOME/.zshrc"
