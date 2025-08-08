local autocmd = vim.api.nvim_create_autocmd
local augroup = function(group_name) vim.api.nvim_create_augroup(group_name, { clear = true }) end

autocmd('FileType', {
  group = augroup('exit-win'),
  pattern = { 'help', 'qf' },
  callback = function()
    vim.keymap.set('n', 'q', ':q<cr>', { desc = '', silent = true, buffer = vim.api.nvim_get_current_buf() })
  end
})

autocmd('TextYankPost', {
  group = augroup('yank-highlight'),
  callback = function()
    vim.hl.on_yank()
  end
})

autocmd('VimEnter', {
  group = augroup('listen-godotserver'),
  callback = function()
    local cwd = vim.fn.getcwd()
    local project_file = cwd .. '/project.godot'
    local host_file = '/tmp/godot.pipe'

    -- Verifica se estamos em um projeto Godot
    if cwd:match('^' .. vim.fn.expand('~/Projects/Godot')) and vim.fn.filereadable(project_file) == 1 then
      -- Verifica se o arquivo godothost já existe
      if vim.fn.filereadable(host_file) == 1 then
        -- O arquivo já existe, então provavelmente já tem um servidor rodando
        return
      end

      vim.fn.serverstart(host_file)
    end
  end
})
