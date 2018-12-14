#!/usr/bin/env bash

[[ -e "${HOME}/.vimrc" ]] && rm "${HOME}/.vimrc"
[[ -e "${HOME}/.vim" ]] && rm "${HOME}/.vim"

cp -r "vim" "${HOME}/.vim"
ln -s "${HOME}/.vimrc/vimrc" "${HOME}/.vimrc"
