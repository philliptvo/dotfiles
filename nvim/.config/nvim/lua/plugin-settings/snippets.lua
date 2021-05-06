local map = require'utils'.map

function OptOrNil(s)
  if s == '' then
    return ''
  else
    return '[' .. s .. ']'
  end
end

function ArgOrNil(s)
  if s == '' then
    return ''
  else
    return '{' .. s .. '}'
  end
end

map('i', '<C-j>', '<cmd>lua require"snippets".expand_or_advance(1)<CR>')
map('i', '<C-k>', '<cmd>lua require"snippets".advance_snippet(-1)<CR>')

local snippets = require'snippets'
local U = require'snippets.utils'

snippets.set_ux(require'snippets.inserters.vim_input')
snippets.snippets = {
  _global = {
    todo = require'snippets.utils'.force_comment[[TODO(pv): ]],
    fix = require'snippets.utils'.force_comment('FIXME(pv): '),
  },
  lua = {
    req = [[local ${2:$1|S.v:match"([^.()]+)[()]*$"} = require '$1']],
    func = [[function ${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]],

    ['local'] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = $1]],
    ['for'] = U.match_indentation[[
for ${1: i}, ${2:v} in ipairs(${3:t}) do
  $0
end]],
  },
  tex = {
    env = U.match_indentation[[
\begin{${1:env}}${2:opts|OptOrNil(S.v)}${3:args|ArgOrNil(S.v)}
  $0
\end{$1}]],
    code = U.match_indentation[[
\begin{verbatim}
  ${1:func}(${2:params}) {
    $0
  }
\end{verbatim}]],
  }
}
