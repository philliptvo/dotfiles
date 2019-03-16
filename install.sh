#!/usr/bin/env bash

set -e

if [ $(dirname "$0") != "." ]; then
  echo "$(basename "$0"): Script not called from dotfile directory." 1>&2
  exit 1
fi

OS=$(uname)
export DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

# sym link config files in subdirectories
symlink() {
  for config in "${1}"*; do
    if [ -f "${config}" ]; then
      targetfile="${HOME}"/.$(basename "${config}")
      # clean up existing links
      [ -L "${targetfile}" ] && rm "${targetfile}"
      [ -f "${targetfile}" ] && mv "${targetfile}" "${targetfile}".old
      ln -s "${config}" "${targetfile}"
    fi

    echo "Symlinked ${config}."
  done
}

setup() {
  for file in */;  do
    # copy to home directory if force token exists
    if [ ! -f "${file}.ignore" ]; then
      # clean up directory if it already exists
      targetpath="${HOME}/.${file}"
      [ -d "${targetpath}" ] && rm -rf "${targetpath}"
      cp -r "${file}" "${targetpath}"
      echo "Copied ${file} to home directory."
    fi

  symlink "${DOTFILES_DIR}/${file}"
  done
}

cp_configs() {
  for config in ".config/"*; do
    targetfile=$(basename "${config}")
    cp -r "${config}" "${HOME}/.config/"
    echo "Copied config files for ${targetfile}"
  done
}

##########################
### SCRIPT STARTS HERE ###
##########################

# update vim spell directory if necessary
if [ "$(diff ~/.vim/spell/en.utf-8.add vim/spell/en.utf-8.add)" != "" ]; then
  cp ~/.vim/spell/en.utf-8.add* vim/spell/
fi

read -p "Install config files in home directory? (y/n) " update_config

if [ "${update_config}" = "y" ]; then
  setup
  cp_configs
  vim +PlugInstall +qall
fi

# Setup for MacOS
if [ "${OS}" = "Darwin" ]; then
  #[ -f ${HOME}/.bash_profile -o -L ${HOME}/.bash_profile ] && rm ${HOME}/.bash_profile
  mv ${HOME}/.bashrc ${HOME}/.bash_profile

  read -p "Install from brewfile (y/n)? " update_brewfile
fi

if [ "${update_brewfile}" = "y" ]; then
  brew tap Homebrew/bundle
  brew bundle
fi
