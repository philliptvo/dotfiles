local api = vim.api
local fn = vim.fn

local wk = require('which-key')

local M = {}

function M.common_on_init(client)
  print('LSP started!')

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

function M.common_on_attach(client, bufnr)
  local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = {noremap = true, silent = true}
  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gr', ':LspTroubleToggle lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>lr', ':lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ldd', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>ldn', ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>ldp', ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  local keys = {
    l = {
      name = '+lsp',
      ['d'] = {
        name = '+diagnostics',
        ['d'] = 'Show diagnostics',
        ['n'] = 'Next diagnostics',
        ['p'] = 'Previous diagnostics',
      },
      ['r'] = 'Rename',
      ['s'] = 'Signature help',
      ['w'] = {
        name = '+workspace',
        ['a'] = 'Add workspace',
        ['r'] = 'Remove workspace',
        ['l'] = 'List workspaces',
      }
    }
  }

  local goto_keys = {
    d = 'Definition',
    D = 'Declaration',
    i = 'Implementation',
    r = 'References',
  }

  local visual_keys = {}

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>lf", ":lua vim.lsp.buf.formatting()<CR>", opts)
    keys.l.f = 'Format'
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>lf", ":lua vim.lsp.buf.range_formatting()<CR>", opts)
    visual_keys.l.f = 'Format range'
  end

  local optsOrDefault = function(o)
    local options = {prefix = '<leader>', noremap = true, silent = true, buffer = bufnr}
    if o then
      options = vim.tbl_extend('force', options, o)
    end
    return options
  end

  wk.register(keys, optsOrDefault())
  wk.register(goto_keys, optsOrDefault({prefix = 'g'}))
  wk.register(visual_keys, optsOrDefault({mode = 'v'}))

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

function M.common_config()
  local system_name
  if fn.has('mac') == 1 then
    system_name = 'macOS'
  elseif fn.has('unix') == 1 then
    system_name = 'Linux'
  elseif fn.has('win32') == 1 then
    system_name = 'Windows'
  else
    print('Unsupported system')
  end

  return {
    lsp_path = fn.stdpath('data') .. '/lspconfig',
    system_name = system_name,
  }
end

return M
