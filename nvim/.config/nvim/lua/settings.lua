local opt = require('utils').opt

local cmd = vim.cmd

cmd[[syntax on]]
opt('o', 'conceallevel', 0)

-- Automaticall re-read file if a change was detected outside of vim
cmd[[set autoread]]

-- Search is case-insensitive unless uppercase is present
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)

-- Enable mouse scroll
opt('o', 'mouse', 'a')

-- Allow opening of multiple buffers
opt('o', 'hidden', true)

-- Sane splits
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)

-- Faster macros
opt('o', 'lazyredraw', true)

-- Line numbers
opt('w', 'number', true)
opt('w', 'relativenumber', true)

-- Sign column popping up is quite jarring
opt('w', 'signcolumn', 'yes')
opt('o', 'updatetime', 250)

-- Tab settings
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', 2)
opt('b', 'tabstop', 2)
opt('b', 'softtabstop', 2)
opt('b', 'autoindent', true)
opt('b', 'smartindent', true)

-- Matching braces/tags
opt('o', 'showmatch', true)

-- Line wrapping
opt('b', 'textwidth', 80)
opt('w', 'wrap', false)

-- Scrolling offsets
opt('w', 'scrolloff', 3)
opt('w', 'sidescrolloff', 5)

-- Font
opt('o', 'guifont', 'FiraCode Nerd Font Mono')

-- Terminal colors
opt('o', 'termguicolors', true)
opt('o', 't_Co', '256')

-- Kommentary
vim.g.kommentary_create_default_mappings = false
