return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'folke/lazydev.nvim',      ft = 'lua',   opts = {} },

    { "williamboman/mason.nvim", config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    'stevearc/conform.nvim'
  },

  config = function()
    require 'config.lsp.servers'.setup()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event_args)
        local client = vim.lsp.get_client_by_id(event_args.data.client_id)
        if not client then return end

        vim.notify('LSP started!', vim.log.levels.INFO)

        local methods = vim.lsp.protocol.Methods
        if client:supports_method(methods.textDocument_documentHighlight) then
          local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })
          local create_command = function(events, callback)
            vim.api.nvim_create_autocmd(events, {
              group = group,
              buffer = event_args.buf,
              callback = callback
            })
          end

          create_command({ 'CursorHold', 'CursorHoldI' }, vim.lsp.buf.document_highlight)
          create_command({ 'CursorMoved', 'CursorMovedI' }, vim.lsp.buf.clear_references)
        end

        if client:supports_method(methods.textDocument_formatting) then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('lsp-format', { clear = true }),
            callback = function()
              -- vim.lsp.buf.format { bufnr = event_args.buf, id = client.id, filter = function()
              --   return client.name ~= 'clangd'
              -- end, formatting_options = {} }
              require 'conform'.format { bufnr = event_args.buf, id = client.id, formatting_options = {}, lsp_format = 'fallback', }
            end
          })
        end

        -- if client:supports_method(methods.textDocument_inlayHint) then
        if client.server_capabilities.inlayHintProvider then
          vim.notify('Inlay hints is available', vim.log.levels.INFO)
          vim.lsp.inlay_hint.enable(true, { bufnr = event_args.buf })
        end


        local t_builtin = require 'telescope.builtin'
        ---@param modes string|table
        ---@param map string
        ---@param callback function
        ---@param desc string
        local keymap = function(modes, map, callback, desc)
          vim.keymap.set(modes, map, callback, { desc = 'LSP: ' .. desc, buffer = event_args.buf })
        end

        keymap({ 'n', 'v' }, '<leader>cD', vim.lsp.buf.declaration, 'Goto Declaration')
        keymap({ 'n', 'v' }, '<leader>cd', t_builtin.lsp_definitions, 'Goto Definition')
        keymap({ 'n', 'v' }, '<leader>cR', t_builtin.lsp_references, 'Goto References')
        keymap({ 'n', 'v' }, '<leader>ci', t_builtin.lsp_implementations, 'Goto Implementation')
        keymap({ 'n', 'v' }, '<leader>ct', t_builtin.lsp_type_definitions, 'Type definintion')

        keymap({ 'n', 'v' }, '<leader>ws', t_builtin.lsp_workspace_symbols, 'Workspace Symbols')

        keymap({ 'n', 'v' }, 'K', vim.lsp.buf.hover, 'Retrieves information about the symbol')
        keymap({ 'n', 'v' }, '<a-s-k>', vim.lsp.buf.signature_help, 'Retrieves the function signature')

        keymap({ 'n', 'v' }, '<leader>cr', vim.lsp.buf.rename, 'Rename word under cursor')
        keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Execute some code action')
        keymap({ 'i' }, '<a-enter>', vim.lsp.buf.code_action, 'Execute some code action')

        keymap({ 'n', 'v' }, '<leader>cq', vim.diagnostic.setqflist, 'Create diagnostic list')
      end
    })
  end
}
