return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'jay-babu/mason-nvim-dap.nvim'
  },

  config = function()
    require 'mason'.setup { ui = { border = 'rounded' } }
  end
}
