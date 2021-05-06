local map = require('utils').map
local wk = require('which-key')

map('n', '<leader>vr', ':Reload<CR>')
map('n', '<leader>vR', ':Restart<CR>')

wk.register({
  v = {
    name = '+vim',
    ['r'] = 'Reload modules',
    ['R'] = 'Restart vim',
  }
}, {prefix = '<leader>'})
