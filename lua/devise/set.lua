vim.o.hlsearch = true
vim.o.incsearch = true

vim.opt.relativenumber = true
vim.opt.nu = true
vim.o.foldmethod = 'expr'
vim.opt.foldtext = [[v:lua.vim.treesitter.foldtext()]]

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.wrap = true
vim.o.textwidth = 90
-- vim.o.colorcolumn = '90'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = false
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
vim.diagnostic.config({virtual_text = true})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.tsx",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
vim.filetype.add({
  extension = {
    tsx = "typescriptreact",
  },
})
vim.o.tabstop = 2 -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting
