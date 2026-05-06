local conform = require('conform')
local util = require('conform.util')

local function node_bin(name)
  return util.find_executable({ 'node_modules/.bin/' .. name }, name)
end

local function project_has(bin, dirname)
  return vim.fn.findfile('node_modules/.bin/' .. bin, dirname .. ';') ~= ''
end

local function js_formatters(bufnr)
  local dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:h')
  local steps = {}

  if project_has('oxfmt', dirname) then
    table.insert(steps, 'oxfmt')
  elseif project_has('biome', dirname) then
    table.insert(steps, 'biome')
  elseif project_has('prettier', dirname) then
    table.insert(steps, 'prettier')
  end

  if project_has('oxlint', dirname) then
    table.insert(steps, 'oxlint_fix')
  end

  return steps
end

conform.setup({
  formatters_by_ft = {
    javascript      = js_formatters,
    javascriptreact = js_formatters,
    typescript      = js_formatters,
    typescriptreact = js_formatters,
    vue             = js_formatters,
  },

  formatters = {
    oxfmt = {
      command = node_bin('oxfmt'),
      stdin = true,
      args = { '--stdin-filepath', '$FILENAME' },
    },

    prettier = {
      command = node_bin('prettier'),
    },

    biome = {
      command = node_bin('biome'),
    },

    oxlint_fix = {
      command = node_bin('oxlint'),
      stdin = false,
      args = { '--fix', '--report-unused-disable-directives-severity=off', '$FILENAME' },
    },
  },

  format_on_save = {
    timeout_ms = 1500,
    lsp_format = 'never',
  },
})
