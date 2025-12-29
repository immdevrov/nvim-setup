require("devise.remap")
require("devise.set")
require("devise.packer")

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_command('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue Prettier')

vim.api.nvim_create_user_command('W', function ()
  vim.cmd.wall()
end, {})
