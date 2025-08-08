return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local oil = require 'oil'

    oil.setup {
      default_file_explorer = true,
      float = {
        win_options = { winblend = 15 },
        preview_split = "right",
      },
      keymaps = {
        ['q'] = { 'actions.close', opts = { exit_if_last_buf = true } },
      },
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      watch_for_changes = true,
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>te', oil.toggle_float, { desc = 'Explorer' })
  end,
}
