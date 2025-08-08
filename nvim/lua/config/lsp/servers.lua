local M = {}

local get_installed_lsps = function()
  local installed = require 'mason-lspconfig'.get_installed_servers()
  local installed_map = {}

  for _, name in ipairs(installed) do
    installed_map[name] = {}
  end

  return installed_map
end

M.setup = function()
  local lsp = require 'lspconfig'
  local capabilities = lsp.util.default_config.capabilities

  local status, blink = pcall(require, 'blink.cmp')
  if status then
    capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())
  else
    vim.notify("Couldn't find the blink plugin")
  end

  local servers = {
    bashls = {
      filetypes = { 'sh', 'bash', 'zsh' },
    },
    clangd = {
      filetypes = { 'c', 'cpp' },
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
      },
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--completion-style=detailed',
        '--compile-commands-dir=build',
        '--function-arg-placeholders=true',
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace'
          },
        },
      },
    },
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'basic',
            diagnosticMode = 'workspace',
          },
        }
      },
    },
  }

  local ensure_installed = { 'lua_ls', 'clang-format', 'pyright' }
  vim.list_extend(ensure_installed, vim.tbl_keys(servers))
  require 'mason-tool-installer'.setup { ensure_installed = ensure_installed, auto_update = true }

  -- Adding other servers installed by Mason
  servers = vim.tbl_extend('keep', servers, get_installed_lsps())

  -- Adding servers obtained in other ways
  servers = vim.tbl_deep_extend('force', servers, {
    gdscript = {
      filetypes = { 'gd', 'gdscript' },
      cmd = { 'nc', '-U', '/tmp/godot.pipe' },
      root_dir = function()
        lsp.util.root_pattern('project.godot')(fname)
      end
    },
    gdshader_lsp = {},
    -- For some reason, I can't download gopls via Mason
    gopls = {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
            nilness = true,
          },
          staticcheck = true,
          usePlaceholders = true,
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            assignVariableTypes = true,
          },
        }
      },
    },
    rust_analyzer = {
      settings = {
        ['rust-analyzer'] = {
        },
      },
    },
  })

  for name, config in pairs(servers) do
    config = vim.tbl_deep_extend('force', {}, {
      capabilities = capabilities,
    }, config)

    lsp[name].setup(config)
  end

  vim.notify('Servers setup successfully', vim.log.levels.INFO)
end

return M
