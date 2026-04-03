require("devise.remap")
require("devise.set")
require("devise.plugins")

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue' },
  command = 'Prettier',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function() vim.lsp.buf.format() end,
})

vim.api.nvim_create_user_command('W', function ()
  vim.cmd.wall()
end, {})
