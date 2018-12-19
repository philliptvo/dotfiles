#!/usr/bin/env bash

set -ex

# sym link config files in subdirectories
symlink() {
  for config in ${1}*; do
    if [ -f $config ]; then
      targetfile="${HOME}/.$(basename ${config})"
      # clean up existing links
      [ -L $targetfile ] && rm $targetfile
      ln -s $config $targetfile
    fi
  done
}

cp_config() {
  for config in ${1}*; do
    if [ -f $config ]; then
      targetfile="${HOME}/.$(basename ${config})"
      # clean up existing links
      [ -f $targetfile ] && rm $targetfile
      cp $config $targetfile
    fi
  done
}

main() {
  for file in */;  do
    # copy to home directory if force token exists
    if [ -f ${file}.force ]; then
      # clean up directory if it already exists
      targetpath="${HOME}/.${file}"
      [ -d $targetpath ] && rm -rf $targetpath
      cp -r $file $targetpath
    fi

    if [ -f ${file}.cp ]; then
      cp_config $file
    else
      symlink $file
    fi
  done
}

main
