return {
  'echasnovski/mini.nvim',

  config = function()
    require 'mini.ai'.setup()
    require 'mini.indentscope'.setup()
    require 'mini.move'.setup()
    require 'mini.surround'.setup {
      mappings = {
        add       = '<leader>sa',
        delete    = '<leader>sd',
        find      = '<leader>sf',
        find_left = '<leader>sF',
        highlight = '<leader>sh',
        replace   = '<leader>sr',
      }
    }
  end,
}
