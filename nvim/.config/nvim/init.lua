local cmd = vim.cmd
local fn = vim.fn

require('colors')
require('settings')
require('mappings')
require('auto')

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  cmd('packadd packer.nvim')

  -- Load plugins
  require('plugins')

  -- Automatically sync Packer
  cmd('PackerSync')
  require'utils'.create_augroups({
    Packer = {
      {'User', 'PackerComplete', 'lua require"utils".Restart()'}
    },
  })
else
  -- Load plugins
  require('plugins')

  -- Load plugin configurations
  require('plugin-settings')

  -- Setup LSP servers
  require('lsp')
end
