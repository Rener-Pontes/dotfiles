---@class FloatWindow
---@field options WindowOptions
---@field state WindowState

---@class WindowOptions
---@field width integer
---@field height integer
---@field title string
---@field blend? integer

---@class WindowState
---@field bufnr integer
---@field win integer

local M = {}

---Creates an float window
---@param options WindowOptions
---@param bufnr? integer
---@return WindowState
M.create_window = function(options, bufnr)
  local lines = vim.o.lines
  local columns = vim.o.columns

  local start_row = math.floor((lines - options.height) / 2)
  local start_col = math.floor((columns - options.width) / 2)

  options.blend = options.blend or 0
  bufnr = bufnr or -1
  if not vim.api.nvim_buf_is_valid(bufnr) then
    bufnr = vim.api.nvim_create_buf(false, true)
  end

  ---@type vim.api.keyset.win_config
  local win_config = {
    relative = 'editor',
    height = options.height,
    width = options.width,
    row = start_row,
    col = start_col,

    style = 'minimal',
    border = 'rounded',
    title = options.title,
    title_pos = 'center'
  }
  local win = vim.api.nvim_open_win(bufnr, true, win_config)
  vim.api.nvim_set_option_value("winblend", options.blend, { win = win })

  return { bufnr = bufnr, win = win }
end

return M
