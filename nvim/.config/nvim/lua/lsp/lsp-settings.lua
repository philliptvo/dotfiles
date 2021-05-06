local fn = vim.fn

local nvim_lsp = require('lspconfig')

local lsp_config = require('lsp.common').common_config()
local lsp_path = lsp_config.lsp_path
local system_name = lsp_config.system_name
local sumneko_root_path = lsp_path .. '/lua-language-server'

local servers = {
  clangd = {},

  jdtls = {
    custom_setup = function()
      require'utils'.create_augroups({
        JdtlsLsp = {
          {'Filetype', 'java', 'lua require"lsp.java".setup()'},
        },
      })
    end,
  },

  pyright = {},

  sumneko_lua = {
    cmd = {
      sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server',
      '-E',
      sumneko_root_path .. '/main.lua'
    },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [fn.expand('$VIMRUNTIME/lua')] = true,
            [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  },

  texlab = {
    cmd = {lsp_path .. '/texlab/texlab'},
  },
}

for lsp, opts in pairs(servers) do
  local client = nvim_lsp[lsp]
  if opts.custom_setup then
    opts.custom_setup()
  else
    client.setup({
      cmd = opts.cmd or client.cmd,
      filetypes = opts.filetypes or client.filetypes,
      on_init = opts.on_init or require'lsp.common'.common_on_init,
      on_attach = opts.on_attach or require'lsp.common'.common_on_attach,
      handlers = opts.handlers or client.handlers,
      root_dir = opts.root_dir or client.root_dir,
      capabilities = opts.capabilities or require'lsp.common'.common_capabilities(),
      settings = opts.settings or {},
    })
  end
end
