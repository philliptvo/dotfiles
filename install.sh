#!/usr/bin/env bash

set -e

if [ "$(dirname $0)" != "." ]; then
  echo "$(basename "$0"): Script not called from dotfile directory." 1>&2
  exit 1
fi

OS=$(uname)
DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

# sym link config files in subdirectories
symlink() {
  for config in ${1}*; do
    if [ -f ${config} ]; then
      targetfile="${HOME}/.$(basename ${config})"
      # clean up existing links
      [ -L ${targetfile} ] && rm ${targetfile}
      [ -f ${targetfile} ] && mv ${targetfile} ${targetfile}.old
      ln -s ${config} ${targetfile}
    fi
  done
}

setup_configs() {
  for file in */;  do
    # copy to home directory if force token exists
    if [ ! -f ${file}.ignore ]; then
      # clean up directory if it already exists
      targetpath="${HOME}/.${file}"
      [ -d ${targetpath} ] && rm -rf ${targetpath}
      cp -r ${file} ${targetpath}
    fi

  symlink ${DOTFILES_DIR}/${file}
  done
}

setup_configs

# Setup for MacOS
if [ "${OS}" = "Darwin" ]; then
  [ -f ${HOME}/.bash_profile -o -L ${HOME}/.bash_profile ] && rm ${HOME}/.bash_profile
  mv ${HOME}/.bashrc ${HOME}/.bash_profile

  brew tap Homebrew/bundle
  brew bundle
fi
