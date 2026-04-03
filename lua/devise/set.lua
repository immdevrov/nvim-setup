vim.o.hlsearch = true
vim.o.incsearch = true

vim.opt.relativenumber = true
vim.opt.nu = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = [[v:lua.vim.treesitter.foldtext()]]
vim.o.foldlevelstart = 99

vim.o.mouse = 'a'

vim.o.wrap = true
vim.o.textwidth = 90
-- vim.o.colorcolumn = '90'

vim.o.breakindent = true

vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('data') .. '/undo'
vim.o.cmdheight = 0

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.swapfile = false
vim.o.winborder = 'rounded'

vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.o.completeopt = 'menuone,noselect'
vim.diagnostic.config({ virtual_text = { current_line = true } })

vim.filetype.add({
  extension = {
    tsx = "typescriptreact",
  },
})
vim.o.tabstop = 2      -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2   -- Number of spaces inserted when indenting

vim.opt.spelllang = "en,ru"
-- vim.opt.spell = true
