local M = {}

local cached

function M.root_g()
  if cached then return cached end

  local npm = vim.fn.exepath('npm')
  if npm ~= '' then
    local guess = vim.fn.fnamemodify(npm, ':h:h') .. '/lib/node_modules'
    if vim.fn.isdirectory(guess) == 1 then
      cached = guess
      return cached
    end
  end

  cached = vim.fn.trim(vim.fn.system('npm root -g'))
  return cached
end

return M
