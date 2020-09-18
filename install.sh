#!/bin/sh

echo "+-------------------+"
echo "|Installing Homebrew|"
echo "+-------------------+"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

echo "+--------------------------------+"
echo "|Installing Homebrew dependencies|"
echo "+--------------------------------+"
brew tap homebrew/cask-fonts
brew cask install font-fira-code-nerd-font
brew cask install ubersicht
brew install fish
brew install python
brew install neovim
brew install fzf
brew install jq
brew install htop
brew install gs
brew install neofetch
brew install jesseduffield/lazygit/lazygit
brew install jesseduffield/lazydocker/lazydocker
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
sudo pip3 install pywal
sudo pip3 install pywalfox
brew services start yabai
brew services start skhd
brew update
brew services restart --all

echo "+-------------------+"
echo "|Installing dotfiles|"
echo "+-------------------+"
cp -r -v scripts/. $HOME/scripts
cp -r -v config/. $HOME/.config
cp -v yabairc $HOME/.yabairc
cp -v skhdrc $HOME/.skhdrc
cp -v tmux.conf $HOME/.tmux.conf
cp -v gitconfig $HOME/.gitconfig

echo "+------------------------+"
echo "|Installing Ubersicht Bar|"
echo "+------------------------+"
if [ -d "$HOME/Library/Application Support/Übersicht/widgets/simple-bar" ]; then
  rm -rf "$HOME/Library/Application Support/Übersicht/widgets/simple-bar" 
fi
git clone git@github.com:Jean-Tinland/simple-bar.git "$HOME/Library/Application Support/Übersicht/widgets/simple-bar"

# Use pywal colors for Ubersicht
cat "$HOME/Library/Application Support/Übersicht/widgets/simple-bar/lib/styles/Theme.js" | awk '/^export const Theme/{print "/*"}1;/^}/{print "*/"}' | sed '/^\/\/ export { Theme } /s|^// ||' | tee "$HOME/Library/Application Support/Übersicht/widgets/simple-bar/lib/styles/Theme.js"

echo "+---------------------+"
echo "|Installing oh-my-fish|"
echo "+---------------------+"
if [ ! -d "$HOME/.config/omf" ]; then
  /bin/bash -c "$(curl -L https://get.oh-my.fish | fish)"
else
  echo "Skipping because omf is already installed."
fi

echo "+-------------------+"
echo "|Setting up pywalfox|"
echo "+-------------------+"
sudo pywalfox setup

echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "Next Steps:"
echo "  Open vim and use :PlugInstall to install plugins"
echo "  Set up fish theme ('bobthefish' to use installed font: font-fira-code-nerd-font)"
