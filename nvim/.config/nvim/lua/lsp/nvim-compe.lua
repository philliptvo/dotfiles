local fn = vim.fn
local api = vim.api

local map = require('utils').map
local npairs = require('nvim-autopairs')

vim.o.completeopt = 'menu,menuone,noselect'

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = true,
        buffer = true,
        calc = true,
        vsnip = false,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = false,
        snippets_nvim = false,
        treesitter = false,
    }
}

npairs.setup()

vim.g.completion_confirm_key = ''

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local t = require'utils'.t

_G.MUtils = {}
MUtils.completion_confirm = function()
  if fn.pumvisible() ~= 0 then
    if fn.complete_info()['selected'] ~= -1 then
      return fn['compe#confirm'](npairs.esc(''))
    else
      api.nvim_select_popupmenu_item(0, false, true, {})
      return fn['compe#complete'](npairs.esc('<C-n>'))
    end
  else
    return npairs.autopairs_cr()
  end
end

MUtils.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t'<C-n>'
  elseif check_back_space() then
    return t'<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

MUtils.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t'<C-p>'
  else
    return t'<S-Tab>'
  end
end

map('i', '<C-Space>', 'v:lua.MUtils.completion_confirm()', {silent = true, expr = true})
map('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {silent = true, expr = true})
map('i', '<C-e>', 'compe#close("<C-e>")', {silent = true, expr = true})

map("i", "<Tab>", "v:lua.MUtils.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.MUtils.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.MUtils.s_tab_complete()", {expr = true})
