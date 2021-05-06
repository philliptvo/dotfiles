local map = require('utils').map
local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<ESC>'] = actions.close,
        ['<CR>'] = actions.select_default + actions.center,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      }
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
})

function SearchDotfiles()
  require('telescope.builtin').find_files({
    prompt_title = '~ Dotfiles ~',
    hidden = true,
    cwd = '$HOME/dotfiles/',
  })
end

map('n', '<leader>pp', ':lua require"telescope.builtin".git_files()<CR>')
map('n', '<leader>ps', ':lua require"telescope.builtin".grep_string({search = vim.fn.input("Grep for > ")})<CR>')
map('n', '<leader>pf', ':lua require"telescope.builtin".find_files()<CR>')
map('n', '<leader>pb', ':lua require"telescope.builtin".buffers()<CR>')
map('n', '<leader>gs', ':lua require"telescope.builtin".git_status()<CR>')
map('n', '<leader>gb', ':lua require"telescope.builtin".git_branches()<CR>')
map('n', '<leader>gc', ':lua require"telescope.builtin".git_commits()<CR>')
map('n', '<leader>vv', ':lua SearchDotfiles()<CR>')

require'which-key'.register({
  g = {
    name = '+git',
    ['b'] = 'Branches',
    ['c'] = 'Commits',
    ['s'] = 'Status',
  },
  p = {
    name = '+find',
    ['p'] = 'Git files',
    ['s'] = 'Search string',
    ['f'] = 'Files in current directory',
    ['b'] = 'Buffers',
  },
  v = {
    ['v'] = 'Search dotfiles',
  },
}, {prefix = '<leader>'})
