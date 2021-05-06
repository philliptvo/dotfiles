local wk = require('which-key')

require('neuron').setup({
  virtual_titles = true,
  mappings = true,
  run = nil,
  neuron_dir = '~/zettelkasten',
  leader = '<leader>z',
})

wk.register({
  z = {
    name = '+zettelkasten',
    ['n'] = 'Create a new note',
    ['z'] = 'Find zettels',
    ['Z'] = 'Insert zettel ID',
    ['b'] = 'Find backlinks',
    ['B'] = 'Insert backlink ID',
    ['t'] = 'Find tags',
    ['s'] = 'Neuron server',
    [']'] = 'Next extmark',
    ['['] = 'Previous extmark',
  }
}, {prefix = '<leader>'})
