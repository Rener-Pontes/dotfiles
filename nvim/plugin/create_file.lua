local scan = require 'plenary.scandir'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local themes = require 'telescope.themes'


---Creates the directories in case they don't exists
---@param path string
local function create_directories(path)
  local full_path = ''

  for dir in path:gmatch("([^/]+)") do
    full_path = full_path .. dir .. '/'
    if vim.fn.isdirectory(full_path) == 0 then
      vim.fn.mkdir(full_path)
    end
  end
end


---Creates the file in the chosen directory
---@param dir string
local function create_file(dir)
  ---@type WindowState
  local float_window = require 'utils.float_window'
  local win_state = float_window.create_window({ height = 1, width = 60, title = 'Filename:', blend = 20, })
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = win_state.bufnr })

  vim.api.nvim_buf_set_lines(win_state.bufnr, 0, -1, false, { '' })
  vim.api.nvim_set_option_value('filetype', 'prompt', { buf = win_state.bufnr })
  vim.api.nvim_set_option_value('modifiable', true, { buf = win_state.bufnr })
  vim.api.nvim_set_current_win(win_state.win)

  vim.keymap.set('i', '<esc>', function()
    vim.api.nvim_win_close(win_state.win, true)
  end, { buffer = win_state.bufnr })

  vim.keymap.set('i', '<cr>', function()
    local filename = vim.api.nvim_get_current_line()
    if filename == '' then return end

    create_directories(dir)

    local file_path = dir .. '/' .. filename
    local file = io.open(file_path, 'r')
    if file then
      vim.notify('File already exists', vim.log.levels.WARN)
      file:close()
      return
    else
      file = io.open(file_path, 'w')
      if file then
        vim.notify('File created.', vim.log.levels.INFO)
        file:close()

        vim.schedule(function()
          vim.cmd('edit ' .. file_path)
        end)
      else
        vim.notify('File ' .. filename " couldn't be created", vim.log.levels.ERROR)
      end
    end

    vim.api.nvim_win_close(win_state.win, true)
  end, { buffer = win_state.bufnr })

  vim.schedule(function()
    vim.cmd.startinsert()
  end)
end

local function file_creator(opts)
  opts = opts or {}

  local directories = scan.scan_dir('.', {
    -- hidden = true,
    only_dirs = true,
    respect_gitignore = true,

    ---@param entry string
    on_insert = function(entry)
      return entry:sub(2)
    end
  })
  table.insert(directories, '.')

  local dropdown_theme = themes.get_dropdown()
  pickers.new(opts, {
    prompt_tile = 'Select directory',
    finder = finders.new_table({ results = directories }),
    sorter = sorters.get_generic_fuzzy_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)
        create_file(selection[1])
      end)
      return true
    end,
    winblend = dropdown_theme.winblend,
    borderchar = dropdown_theme.borderchars,
    layout_config = dropdown_theme.layout_config
  }):find()
end

vim.api.nvim_create_user_command('CreateFile', file_creator, {})

vim.keymap.set('n', '<leader>wf', file_creator, { desc = 'Create a new File' })
