# Description

A compendium of my configuration files for MacOS and Linux.

# Features

+ editor
  + __neovim__
+ window manager(s)
  + __yabai__
  + __skhd__ (hotkeys)
+ shell
  + __zsh__
  + __oh-my-zsh__ (plugin manager)
+ terminal
  + __kitty__
  + __tmux__
+ other
  + __git__
  + newsboat

# To install

```sh
$ git clone git@github.com:philliptvo/dotfiles.git
$ cd dotfiles
$ ./setup.sh
```

# Post Installation

## Install plugins

```vim
:PackerInstall
```

## Setup LSP

### Lua

Instructions to install lua language server
[here](https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone))

### Python

```sh
npm i -g pyright
```
