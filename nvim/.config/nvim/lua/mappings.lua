local utils = require('utils')
local map = utils.map

local wk = require('which-key')

vim.g.mapleader = ' '

map('n', ' ', '<NOP>')

-- Toggle highlighting
map('n', '<leader>th', ':se hlsearch!<CR>', {silent = true})

-- Window stuff
-- Window navigating
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Window resizing
map('n', '<Leader>wr=', ':wincmd =<CR>')
map('n', '<Leader>wr+', ':wincmd +<CR>')
map('n', '<Leader>wr-', ':wincmd -<CR>')
map('n', '<Leader>wr>', ':wincmd ><CR>')
map('n', '<Leader>wr<', ':wincmd <<CR>')

-- Rotate windows
map('n', '<Leader>wRd', ':wincmd r<CR>')
map('n', '<Leader>wRu', ':wincmd R<CR>')

-- Move windows
map('n', '<Leader>wmh', ':wincmd h<CR>')
map('n', '<Leader>wmj', ':wincmd j<CR>')
map('n', '<Leader>wmk', ':wincmd k<CR>')
map('n', '<Leader>wml', ':wincmd l<CR>')

-- Delete window
map('n', '<Leader>wq', ':wincmd q<CR>')

-- Split window
map('n', '<Leader>ws', ':wincmd s<CR>')
map('n', '<Leader>wv', ':wincmd v<CR>')

-- Buffers stuff
map('n', '<Leader>bn', ':bnext<CR>')
map('n', '<Leader>bp', ':bprevious<CR>')
map('n', '<leader>bo', ':%bdelete | e# | bdelete#<CR>')

-- Line navigation
map('n', 'H', '^')
map('v', 'H', '^')
map('n', 'L', 'g_')
map('v', 'L', 'g_')

-- Yank should behave like copy
map('n', 'Y', 'y$')

-- Indent
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Move lines
map('v', '<C-j>', ":m '>+1<CR>gv=gv")
map('v', '<C-k>', ":m '<-2<CR>gv=gv")

-- Disable Ex mode. Can be accessed with gQ anyways
map('', 'Q', '')

-- Quit all
map('n', '<leader>q', ':qa<CR>')
map('n', '<leader>Q', ':qa!<CR>')

-- NVim config stuff
map('n', '<leader>vc', ':e $MYVIMRC<CR>')
-- map('n', '<Leader>vr', ':Reload<CR>')
-- map('n', '<Leader>vR', ':Restart<CR>')

local keys = {
  q = 'Quit all',
  Q = 'Force quit all',
  b = {
    name = '+buffer',
    ['n'] = 'Next buffer',
    ['p'] = 'Previous buffer',
    ['o'] = 'Clear all but current buffer',
  },
  t = {
    name = '+toggle',
    ['h'] = 'Highlight',
  },
  v = {
    name = '+vim',
    ['c'] = 'Edit config',
    -- ['r'] = 'Reload modules',
    -- ['R'] = 'Restart vim',
  },
  w = {
    name = '+window',
    ['r'] = {
      name = '+resize',
      ['='] = 'Balance',
      ['+'] = 'Increase height',
      ['-'] = 'Decrease height',
      ['>'] = 'Increase width',
      ['<'] = 'Decrease width',
    },
    ['R'] = {
      name = '+rotate',
      ['d'] = 'Rotate down/right',
      ['u'] = 'Rotate up/left',
    },
    ['m'] = {
      name = '+move',
      ['h'] = 'Move left',
      ['j'] = 'Move below',
      ['k'] = 'Move above',
      ['l'] = 'Move right',
    },
    ['q'] = 'Close window',
    ['s'] = 'Split horizontally',
    ['v'] = 'Split vertically',
  },
}

wk.register({[' '] = '+leader'})
wk.register(keys, {prefix = '<leader>'})
