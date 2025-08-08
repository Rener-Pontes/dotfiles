return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
  },

  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      defaults = {
        winblend = 25
      },
      pickers = {
      },
      extensions = {
        fzf = {},
        ['ui-select'] = {
          require 'telescope.themes'.get_dropdown()
        },
        fidget = {},
      }
    }

    telescope.load_extension 'fzf'
    telescope.load_extension 'ui-select'

    local builtin = require 'telescope.builtin'
    local keymap = vim.keymap.set
    keymap({ 'n', 'v' }, '<leader>fh', builtin.help_tags, { desc = 'Help entries' })
    keymap({ 'n', 'v' }, '<leader>ff', function()
      builtin.find_files({})
    end, { desc = 'Files' })
    keymap({ 'n', 'v' }, '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    keymap({ 'n', 'v' }, '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
    keymap('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = 'String' })

    keymap('n', '<leader>en', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[N]eovim config' })
    keymap('n', '<leader>ep', function()
      ---@diagnostic disable-next-line: param-type-mismatch
      builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy') }
    end, { desc = 'Lazy [P]lugins' })
  end

}
