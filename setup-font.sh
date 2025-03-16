#Downloading JetBrains Mono Nerd Font
curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
if [ ! -d "$HOME/.fonts" ]; then
    mkdir $HOME/.fonts
fi

mv -i "$PWD/JetBrainsMono.zip" "$HOME/.fonts"
