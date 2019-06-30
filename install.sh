#!/bin/sh

set -e

if [ $(dirname "$0") != "." ]; then
  echo "Script not called from dotfile directory -> $(basename "$0")" 1>&2
  exit 1
fi

export DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

symlink() {
  for conf in $(ls | grep -v -e 'Brewfile' -e 'README' -e 'install'); do
    target="${HOME}/.${conf}"
    if [ ! -L "${target}" ]; then
      echo "Linking ${conf} -> ${target}"
      ln -s "${DOTFILES_DIR}/${conf}" "${target}"
    fi
  done
}

config() {
  mkdir -p "${HOME}/.config"

  for config in ".config/"*; do
    target=$(basename "${config}")
    cp -r "${config}" "${HOME}/.config/"
    echo "Copied config files: ${target}"
  done
}

##########################
### SCRIPT STARTS HERE ###
##########################

# update vim spell directory if necessary
if [ "$(diff ~/.vim/spell/en.utf-8.add vim/spell/en.utf-8.add)" != "" ]; then
  echo "Updating spell file"
  cp ~/.vim/spell/en.utf-8.add* vim/spell/
fi

read -p "Install configurations? (Y/n) " update_config
if [ "$(echo "${update_config}" | awk '{print tolower($0)}')" = "y" ]; then
  symlink
  config
  vim +PlugInstall +qall
fi
