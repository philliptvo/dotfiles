vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  position = 'right',
  keymaps = {
    close = '<ESC>',
    goto_location = '<CR>',
    focus_location = 'o',
    hover_symbol = 'K',
    rename_symbol = 'r',
    code_actions = 'a',
  },
  lsp_blacklist = {},
}

require'utils'.map('n', '<leader>ts', ':SymbolsOutline<CR>')
require'which-key'.register({
  t = {
    ['s'] = 'Symbols outline',
  }
})
