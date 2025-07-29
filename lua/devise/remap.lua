-- Keymaps for better default experience
vim.g.mapleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- find and replace
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>\\', ':noh<CR>')
vim.keymap.set('n', '<C-s>', vim.cmd.wall)
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", '<leader>on', vim.cmd.on)
vim.keymap.set("n", '<leader>q', vim.cmd.copen)

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({'n', 'i'}, '<M-h>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i'}, '<M-l>', '<Nop>', { noremap = true, silent = true })

vim.keymap.set("x", "<leader>P", "\"_dP")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set('i', '<D-v>', '<C-r>+', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', '<D-v>', '"+p', { desc = 'Paste from system clipboard' })
