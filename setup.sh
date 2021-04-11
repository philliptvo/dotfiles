#!/bin/sh

base=(
  alacritty
  zsh
  bin
)

user=(
  git
  newsboat
  nvim
  tmux
)

mac=(
  skhd
  spacebar
  yabai
)

linux=(
  
)

stowit() {
  usr=$1
  app=$2
  # -v verbose
  # -R relink
  # -t target
  stow -v -R -t "${usr}" "${app}"
}

installonmac() {
  for app in ${mac[@]}; do
    stowit "${HOME}" "${app}"
  done
}


installonlinux() {
  for app in ${linux[@]}; do
    stowit "${HOME}" "${app}"
  done
}

installextra() {
  [ "$(uname)" == "Darwin" ] && installonmac
  [ -n "$(uname -a | grep Ubuntu)" ] && installonlinux
}

# install apps available to local users and root
for app in ${base[@]}; do
  stowit "${HOME}" "${app}"
done

# install user-only apps
for app in ${user[@]}; do
  stowit "${HOME}" "${app}"
done

# install distro-specific apps
installextra

echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "Next Steps:"
echo "  Open vim and use :PlugInstall to install plugins"
