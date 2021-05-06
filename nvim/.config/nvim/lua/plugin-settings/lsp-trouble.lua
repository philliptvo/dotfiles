local map = require('utils').map
local wk = require('which-key')

-- setup called in lua/plugins.lua

map('n', '<leader>xx', ':LspTroubleToggle<CR>')
map('n', '<leader>xw', ':LspTroubleToggle lsp_workspace_diagnostics<CR>')
map('n', '<leader>xd', ':LspTroubleToggle lsp_document_diagnostics<CR>')
map('n', '<lealer>xl', ':LspTroubleToggle loclist<CR>')
map('n', '<lealer>xq', ':LspTroubleToggle quickfix<CR>')

wk.register({
  x = {
    name = '+trouble',
    ['x'] = 'Toggle',
    ['w'] = 'Workspace diagnostics',
    ['d'] = 'Diagnostics',
    ['l'] = 'Location list',
    ['q'] = 'Quickfix list',
  }
}, {prefix = '<leader>'})
