return {
  'folke/which-key.nvim',
  event = 'VeryLazy',

  config = function()
    require 'which-key'.setup {
      preset = 'modern',
      keys = {
        scroll_down = '<c-n>',
        scroll_up = '<c-p>',
      },
      ---@type wk.Spec[]
      spec = {
        { '<leader>c',       group = 'Code',             mode = { 'n', 'v' } },
        { '<leader>d',       group = 'Debug',            mode = { 'n', 'v' } },
        { '<leader>e',       group = 'Edit config files' },
        { '<leader>f',       group = 'Find...',          mode = { 'n', 'v' } },
        { '<leader>h',       group = 'Harpoon' },
        { '<leader>l',       group = 'Lazy' },
        { '<leader>n',       group = 'Neotest' },
        { '<leader>s',       group = 'Surrounding...',   mode = { 'n', 'v' } },
        { '<leader>t',       group = 'Toggle...',        mode = { 'n', 'v' } },
        { '<leader>w',       group = 'Workspace' },

        { '<leader><space>', group = 'More keymaps',     mode = { 'n', 'v' } }
      }
    }

    --- Delete the ':W' command which-key creates
    vim.api.nvim_create_user_command('W', '', {})
  end,
}
