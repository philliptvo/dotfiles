local opt = require('utils').opt

require('nvim-treesitter.configs').setup({
  ensure_installed = {'bash', 'c', 'cpp', 'java', 'lua', 'python'},
  highlight = {
    enable = true,
  },
  -- indent = {
  --   enable = true,
  -- },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  }
})

vim.cmd[[set foldmethod=expr]]
vim.cmd[[set foldexpr=nvim_treesitter#foldexpr()]]
