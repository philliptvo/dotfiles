#!/bin/zsh

export EDITOR="nvim"

export XDG_CACHE_HOME="${XDG_CACHE_HOME:=${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME}/.config}"
export ZDOTDIR="${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdum-${HOST/.*/}-${ZSH_VERSION}"

export PYTHONHISTFILE="$XDG_CACHE_HOME/python/.python_history"
export PYENV_ROOT="$HOME/.pyenv"
export PYLINTHOME="$HOME/.config/pylint"

export JENV_ROOT="$HOME/.jenv"

export PATH="/usr/local/texlive/2020/bin/x86_64-darwin:$PYENV_ROOT/bin:$JENV_ROOT/bin:/usr/local/bin:$HOME/bin:$PATH"
