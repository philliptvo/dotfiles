local api = vim.api
local cmd = vim.cmd
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

M = {}

function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    cmd('augroup ' .. group_name)
    cmd('autocmd!')
    for _, def in ipairs(definition) do
      cmd('autocmd ' .. table.concat(def, ' '))
    end
    cmd('augroup END')
  end
end

function M.t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

function M.P(str)
  print(vim.inspect(str))
end

return M
