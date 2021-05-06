local api = vim.api
local fn = vim.fn

local wk = require('which-key')

local M = {}

function M.setup()
  local function jdtls_on_attach(_, bufnr)
    require'jdtls_setup'.add_commands()
    require'lsp.common'.common_on_attach()

    local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = {noremap = true, silent = true}
    -- Workspaces
    buf_set_keymap('n', '<leader>lwa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>lwr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>lwl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    -- jdtls
    buf_set_keymap("n", "<leader>li", ":lua require'jdtls'.organize_imports()<CR>", opts)
    buf_set_keymap("n", "<leader>le", ":lua require('jdtls').extract_variable()<CR>", opts)
    buf_set_keymap("v", "<leader>le", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    buf_set_keymap("v", "<leader>lm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    -- nvim-dap
    buf_set_keymap("n", "<leader>dt", ":lua require'jdtls'.test_class()<CR>", opts)
    buf_set_keymap("n", "<leader>dn", ":lua require'jdtls'.test_nearest_method()<CR>", opts)

    local keys = {
      l = {
        ['w'] = {
          name = '+workspace',
          ['a'] = 'Add workspace',
          ['r'] = 'Remove workspace',
          ['l'] = 'List workspaces',
        },
        ['i'] = 'Organize imports',
        ['e'] = 'Extract variable',
      },
      d = {
        name = '+debug',
        ['t'] = 'Test class',
        ['n'] = 'Test nearest method',
      },
    }

    local visual_keys = {
      l = {
        ['e'] = 'Extract variable',
        ['m'] = 'Extract method',
      }
    }

    local optsOrDefault = function(o)
      local options = {prefix = '<leader>', noremap = true, silent = true, buffer = bufnr}
      if o then
        options = vim.tbl_extend('force', options, o)
      end
      return options
    end

    wk.register(keys, optsOrDefault())
    wk.register(visual_keys, optsOrDefault({mode = 'v'}))
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local config = {
    flags = {
      allow_incremental_sync = true,
    },
    capabilities = capabilities,
    on_attach = jdtls_on_attach,
  }

  local home = os.getenv('HOME')
  local lsp_config = require('lsp.common').common_config()
  local jdtls_exec = lsp_config['lsp_path'] .. '/jdtls/bin/' .. lsp_config['system_name'] .. '/jdtls.sh'

  local root_markers = {'build.gradle', 'pom.xml', '.git'}
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local workspace_folder = home .. '/.local/share/eclipse/' .. fn.fnamemodify(root_dir, ':p:h:t')
  config.settings = {
    ['java.format.settings.url'] = home .. '/work/eclipse-formatter.xml',
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = home .. '/.jenv/versions/11',
          },
          {
            name = 'JavaSE-15',
            path = home .. '/.jenv/versions/15',
          },
        },
      },
    }
  }
  -- config.cmd = {jdtls_exec, workspace_folder}
  config.cmd = {jdtls_exec, home..'/.local/share/eclipse'..fn.fnamemodify(require'jdtls.setup'.find_root({'build.gradle', 'pom.xml', '.git'}), ':p:h:t')}
  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', {settings = config.settings})
  end

  require'jdtls'.start_or_attach(config)
end

return M
