local packer = require('packer')
local use = packer.use

packer.reset()
packer.init()

use 'wbthomason/packer.nvim'

-- Config reloading
use {
  'famiu/nvim-reload',
  requires = {'nvim-lua/plenary.nvim'},
}

-- Colorscheme
use 'folke/tokyodark.nvim'
use {'dylanaraps/wal.vim', opt = true}

-- LSP
use 'neovim/nvim-lspconfig'
use 'mfussenegger/nvim-jdtls'
use {
  'folke/lsp-trouble.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('trouble').setup({

    })
  end,
}

-- Treesitter
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
}
use 'nvim-treesitter/nvim-treesitter-textobjects'

-- Autocomplete and snippets
use 'hrsh7th/nvim-compe'
use 'norcalli/snippets.nvim'

-- Dashboard
use 'glepnir/dashboard-nvim'

-- Status line
use {
  'hoob3rt/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true},
}

-- Search tool
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
  }
}

-- Formatting
use 'b3nj5m1n/kommentary'
use 'tpope/vim-surround'
use 'tpope/vim-repeat'
use 'windwp/nvim-autopairs'

-- Buffer line
use {
  'jose-elias-alvarez/buftabline.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true},
}

-- File explorer
use {
  'kyazdani42/nvim-tree.lua',
  requires = {'kyazdani42/nvim-web-devicons', opt = true},
}

-- Symbols outline
use 'simrat39/symbols-outline.nvim'

-- Indent blanklines
use {
  'lukas-reineke/indent-blankline.nvim',
  branch = 'lua',
}

-- Note taking
use {
  'oberblastmeister/neuron.nvim',
  branch = 'unstable',
  requires = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'}
}

-- Which-key
use {
  'folke/which-key.nvim',
  config = function() require'plugin-settings.whichkey' end
}
