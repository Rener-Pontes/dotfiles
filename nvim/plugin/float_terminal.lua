---@class TermState
---@field float FloatingState
---
---@class FloatingState
---@field bufnr integer
---@field win integer

---@type TermState
local state = {
  float = { bufnr = -1, win = -1 },
}

---Creates the floating window
---@param opt FloatingState
---@return FloatingState
local function create_window(opt)
  opt = opt or {}

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local bufnr = opt.bufnr
  if not vim.api.nvim_buf_is_valid(bufnr) then
    bufnr = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
    title = 'terminal',
    title_pos = 'center',
  }
  local win = vim.api.nvim_open_win(bufnr, true, win_config)

  return { bufnr = bufnr, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.float.win) then
    state.float = create_window(state.float)

    if vim.bo[state.float.bufnr].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    vim.cmd.startinsert()

    vim.keymap.set('n', 'q', toggle_terminal, { desc = '', buffer = state.float.bufnr })
    vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = '', buffer = state.float.bufnr })
    vim.keymap.set('n', 'd', '<C-d>', { desc = '', buffer = state.float.bufnr })
    vim.keymap.set('n', 'u', '<C-u>', { desc = '', buffer = state.float.bufnr })
  else
    vim.api.nvim_win_hide(state.float.win)
  end
end

vim.keymap.set({ 'n', 'v', 't' }, '<leader>tt', toggle_terminal, { desc = 'Terminal' })
