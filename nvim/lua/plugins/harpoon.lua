return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },

  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local t_conf = require 'telescope.config'.values
    local t_pickers = require 'telescope.pickers'
    local t_finders = require 'telescope.finders'
    ---@param harpoon_files HarpoonList
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      t_pickers.new({}, {
        prompt_title = 'Harpoon',
        finder = t_finders.new_table { results = file_paths },
        previewer = t_conf.file_previewer {},
        sorter = t_conf.generic_sorter {}
      }):find()
    end


    local keymap = vim.keymap.set
    keymap('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Add current buffer' })
    keymap('n', '<leader>hr', function()
      ---@type HarpoonList
      local list = harpoon:list()

      list:remove(list:get_by_value(vim.fn.expand('%:p')))
    end, { desc = 'Remove current buffer' })
    keymap('n', '<leader>hR', function()
      local list = harpoon:list()

      for i = 1, list:length() do
        list:remove_at(i)
      end
    end, { desc = 'Remove all buffers from list' })

    keymap('n', '<leader>hs', function()
      toggle_telescope(harpoon:list())

      -- I don't know yet if I will keep telescope search or use standard harpoon menu
      -- harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Search file' })

    for i, key in ipairs({ 'h', 'j', 'k', 'l', 'ç' }) do
      keymap('n', '<leader>h' .. key, function() harpoon:list():select(i) end, { desc = 'Select ' .. i .. 'st buffer' })
    end
  end
}
