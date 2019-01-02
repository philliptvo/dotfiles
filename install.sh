#!/usr/bin/env bash

set -e

DOTFILES_DIR=$(dirname $(readlink -f $0))

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

main() {
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

main
