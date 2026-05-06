local lint = require('lint')

-- Define oxlint if nvim-lint doesn't ship it as a builtin
if not lint.linters.oxlint then
  lint.linters.oxlint = {
    name = 'oxlint',
    cmd = 'oxlint',
    stdin = false,
    append_fname = true,
    args = { '--format', 'default' },
    stream = 'stdout',
    ignore_exitcode = true,
    parser = require('lint.parser').from_pattern(
      '([^:]+):(%d+):(%d+)%s+(.+)%[(.-)%]',
      { 'file', 'lnum', 'col', 'message', 'code' },
      nil,
      { source = 'oxlint' }
    ),
  }
end

-- ── helpers ───────────────────────────────────────────────────────────────

local function resolve_bin(name)
  local bufname = vim.api.nvim_buf_get_name(0)
  local search_dir = bufname ~= '' and vim.fn.fnamemodify(bufname, ':h') or vim.fn.getcwd()
  local local_bin = vim.fn.findfile('node_modules/.bin/' .. name, search_dir .. ';')
  if local_bin ~= '' then
    return vim.fn.fnamemodify(local_bin, ':p')
  end
  return name
end

local function has_local_bin(name)
  local bufname = vim.api.nvim_buf_get_name(0)
  local search_dir = bufname ~= '' and vim.fn.fnamemodify(bufname, ':h') or vim.fn.getcwd()
  return vim.fn.findfile('node_modules/.bin/' .. name, search_dir .. ';') ~= ''
end

-- ── dynamic binary resolution ─────────────────────────────────────────────

lint.linters.eslint.cmd = function()
  return resolve_bin('eslint')
end

lint.linters.oxlint.cmd = function()
  return resolve_bin('oxlint')
end

-- ── fallback linters_by_ft ────────────────────────────────────────────────

lint.linters_by_ft = {
  javascript      = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescript      = { 'eslint' },
  typescriptreact = { 'eslint' },
  vue             = { 'eslint' },
}

-- ── autocmd ───────────────────────────────────────────────────────────────

local web_fts = {
  javascript = true, javascriptreact = true,
  typescript = true, typescriptreact = true,
  vue = true,
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    local ft = vim.bo.filetype
    if not web_fts[ft] then
      lint.try_lint()
      return
    end
    -- oxlint takes precedence when present in project node_modules
    if has_local_bin('oxlint') then
      lint.try_lint('oxlint')
    else
      lint.try_lint('eslint')
    end
  end,
})
