#!/bin/sh

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

echo "Installing Homebrew dependencies"
brew tap homebrew/cask-fonts
brew cask install font-fira-code-nerd-font
brew cask install ubersicht
brew install fish
brew install python
brew install pip3
brew install neovim
brew install fzf
brew install jq
brew install htop
brew install jesseduffield/lazygit/lazygit
brew install jesseduffield/lazydocker/lazydocker
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
sudo pip3 install pywal
brew services start yabai
brew services start skhd
brew update
brew services restart --all

echo "Installing dotfiles"
cp -r scripts $HOME/scripts
cp -r config $HOME/.config
cp yabairc $HOME/.yabairc
cp skhdrc $HOME/.skhdrc
cp gitconfig $HOME/.gitconfig

git clone git@github.com:Jean-Tinland/simple-bar.git $HOME/Library/Application\ Support/Übersicht/widgets/simple-bar

echo "Installing oh-my-fish"
/bin/bash -c "$(curl -L https://get.oh-my.fish | fish)"

echo "--------------------------------------------------"
echo "Next Steps:"
echo "  Open vim and use :PlugInstall to install plugins"
