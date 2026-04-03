-- nvim-treesitter v0.9+ API (incompatible rewrite, requires Neovim 0.12)
-- Parsers are installed with :TSInstall or programmatically below.
-- tree-sitter-cli must be in PATH: `brew install tree-sitter`
require('nvim-treesitter').install({
  'lua', 'typescript', 'vimdoc', 'luadoc', 'jsdoc', 'javascript', 'vue', 'css', 'scss'
})

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
