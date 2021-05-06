local map = require('utils').map
local wk = require('which-key')

-- noremap must be false
local opts = {noremap = false}

map('n', '<leader>c<space>', '<Plug>kommentary_line_default', opts)
map('n', '<leader>cc<space>', '<Plug>kommentary_motion_default', opts)
map('v', '<leader>cc', '<Plug>kommentary_visual_default', opts)

-- Extended mappings
map('n', '<leader>ci', '<Plug>kommentary_line_increase', opts)
map('n', '<leader>cci', '<Plug>kommentary_motion_increase', opts)
map('v', '<leader>ci', '<Plug>kommentary_visual_increase', opts)
map('n', '<leader>cd', '<Plug>kommentary_line_decrease', opts)
map('n', '<leader>ccd', '<Plug>kommentary_motion_decrease', opts)
map('v', '<leader>cd', '<Plug>kommentary_visual_decrease', opts)

wk.register({
  c = {
    name = '+comment',
    [' '] = 'Toggle commenting',
    ['i'] = 'Increase commenting',
    ['d'] = 'Decrease commenting',
    ['c'] = {
      name = '+motion',
      [' '] = 'Toggle commenting with motion',
      ['i'] = 'Increase commenting with motion',
      ['d'] = 'Decrease commenting with motion',
    },
  }
}, {prefix = '<leader>'})

wk.register({
  c = {
    name = '+comment',
    ['c'] = 'Toggle commenting for selection',
    ['i'] = 'Increase commenting for selection',
    ['d'] = 'Decrease commenting for selection',
  }
}, {mode = 'v'})

-- Configurations
require('kommentary.config').configure_language('default', {
  prefer_single_line_comments = true
})
