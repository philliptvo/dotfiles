vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = true,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)

vim.fn.sign_define('LspDiagnosticsSignError', {text = '✗', texthl = 'LspDiagnosticsSignError'})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = '', texthl = 'LspDiagnosticsSignWarning'})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = '', texthl = 'LspDiagnosticsSignInformation'})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = '', texthl = 'LspDiagnosticsSignHint'})
