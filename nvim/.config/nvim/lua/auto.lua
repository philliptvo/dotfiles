local autogroups = {
  AutoAdjustResize = {
    {'VimResized', '*', 'wincmd ='},
  },
  Terminal = {
    {'TermOpen', '*', 'setlocal', 'nonumber', 'norelativenumber', 'signcolumn=no'},
  },
  TemplateSupport = {
    {'BufNewFile', '*', 'silent!', '0read', '$HOME/.config/nvim/templates/%:e.tpl'},
  },
}

require'utils'.create_augroups(autogroups)
