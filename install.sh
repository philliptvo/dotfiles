#!/usr/bin/env bash

[[ -L "${HOME}/.vimrc" ]] && rm "${HOME}/.vimrc"
[[ -d "${HOME}/.vim" ]] && rm -rf "${HOME}/.vim"

cp -r vim "${HOME}/.vim"
ln -s "${HOME}/.vimrc/vimrc" "${HOME}/.vimrc"
