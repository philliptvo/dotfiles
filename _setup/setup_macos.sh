#!/bin/sh

echo "+-------------------+"
echo "|Installing Homebrew|"
echo "+-------------------+"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

echo "+--------------------------------+"
echo "|Installing Homebrew dependencies|"
echo "+--------------------------------+"
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install --cask kitty
brew install fzf
brew install ripgrep
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install pyenv
brew install neovim
brew install jq
brew install gs
brew install jesseduffield/lazygit/lazygit
brew install jesseduffield/lazydocker/lazydocker
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install cmacrae/formulae/spacebar
brew services start yabai
brew services start skhd
brew update
brew services restart --all

# To install useful key bindings and fuzzy completion:
sudo pip3 install pywal
sudo pip3 install pywalfox
$(brew --prefix)/opt/fzf/install

echo "+-------------------+"
echo "|Setting up pywalfox|"
echo "+-------------------+"
sudo pywalfox setup

echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "Next Steps:"
echo "  Open nvim and run :PlugInstall to install plugins"
