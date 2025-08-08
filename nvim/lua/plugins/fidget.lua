return {
  'j-hui/fidget.nvim',

  config = function()
    require 'fidget'.setup {
      notification = { override_vim_notify = true }
    }

    -- vim.keymap.set('n', '<leader><leader>h', require 'telescope'.extensions.fidget.fidget,
    --   { desc = 'Notification History' })
  end,
}
