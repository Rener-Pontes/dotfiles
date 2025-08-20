local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.showmode = false -- Don't need to show mode 'cause lualine plugin
opt.scrolloff = 10
opt.list = true
opt.listchars = {
  tab = '» ', trail = '·', nbsp = '␣'
}
opt.guicursor = {                                 -- Sets differents cursors for modes
  "n-v-c:block",                                  -- Normal, Visual, and Command modes use a block cursor
  "i-ci:ver25",                                   -- Insert and Insert Command modes use a vertical bar (25% width)
  "r-cr:hor20",                                   -- Replace and Command Replace modes use a horizontal bar (20% height)
  "o:hor50",                                      -- Operator-pending mode uses a thicker horizontal bar
  "sm:block-blinkwait700-blinkon400-blinkoff250", -- Show blinking block cursor in Select mode
  "a:blinkon0"                                    -- Disable blinking for all other modes
}
opt.fillchars:append({ eob = ' ' })

opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.foldmethod = 'expr'
opt.foldexpr = require 'nvim-treesitter'.foldexpr

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen'

opt.wrap = true
opt.linebreak = true
opt.breakindent = true

opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.ignorecase = true
opt.inccommand = 'split'

opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undo'
opt.undofile = true
opt.swapfile = false

opt.clipboard = 'unnamedplus'

opt.spell = true
opt.spelllang = 'pt_br,en_us'
