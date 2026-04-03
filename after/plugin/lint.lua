local lint = require('lint')

lint.linters_by_ft = {
  javascript      = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescript      = { 'eslint' },
  typescriptreact = { 'eslint' },
  vue             = { 'eslint' },
}

-- Prefer project-local eslint; ';' in path makes findfile walk upward (monorepo safe)
lint.linters.eslint.cmd = function()
  local local_bin = vim.fn.findfile('node_modules/.bin/eslint', vim.fn.getcwd() .. ';')
  if local_bin ~= '' then
    return vim.fn.fnamemodify(local_bin, ':p')
  end
  return 'eslint'
end

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    lint.try_lint()
  end,
})
