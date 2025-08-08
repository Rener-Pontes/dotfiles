local keymap = vim.keymap.set

keymap('n', '<leader><leader>s', function()
  vim.cmd 'source %'
  print 'File sourced'
end, { desc = 'Source current file' })

keymap('n', '<leader><leader>x', ':.lua<cr>', { desc = 'Execute current line' })
keymap('v', '<leader><leader>x', ':lua<cr>', { desc = 'Execute selected lines' })

keymap('t', '<esc><esc>', '<C-\\><C-n>', { desc = '' })
keymap('n', '<esc>', ':nohlsearch<cr>', { desc = '', silent = true })
keymap('i', '<c-c>', '<esc>', { desc = '', })

keymap('n', '<m-n>', '<cmd>bn<cr>', { desc = 'Change to next buffer.' })
keymap('n', '<m-p>', '<cmd>bp<cr>', { desc = 'Change to prev buffer.' })

keymap('n', '<m-j>', '<cmd>cnext<cr>', { desc = 'Change to next item of quickfix.' })
keymap('n', '<m-k>', '<cmd>cprev<cr>', { desc = 'Change to prev item of quickfix.' })

keymap('n', '<c-d>', '<c-d>zz', { desc = '', silent = true })
keymap('n', '<c-u>', '<c-u>zz', { desc = '', silent = true })
