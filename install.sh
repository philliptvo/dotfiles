#!/usr/bin/env bash

set -ex

# Copy config files in subdirectories
cp_configs() {
  for config in ${1}.[^.]*; do
    targetfile="${HOME}/$(basename ${config})"

    # clean up existing links
    [ -f $targetfile ] && rm $targetfile
    cp $config $targetfile
  done
}

set_up() {
  for file in */;  do
    # copy to home directory if force token exists
    if [ -f ${file}force ]; then
    # clean up directory if it already exists
    targetpath="${HOME}/.${file}"
    [ -d $targetpath ] && rm -rf $targetpath

    cp -r $file $targetpath
    fi

    cp_configs $file
  done
}

set_up
