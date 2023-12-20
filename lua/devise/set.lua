vim.o.hlsearch = true
vim.o.incsearch = true

vim.opt.relativenumber = true
vim.opt.nu = true
vim.o.foldmethod = 'syntax'
-- Enable mouse mode
vim.o.mouse = 'a'

vim.opt.wrap = false


-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.cmdheight = 0

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
