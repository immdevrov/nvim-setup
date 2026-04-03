-- Build hooks must be registered before vim.pack.add()
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end

    if name == 'vim-prettier' then
      vim.system({ 'npm', 'install', '--frozen-lockfile', '--production' }, { cwd = ev.data.path })
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',

  -- Completion
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',

  -- Treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter',

  -- Navigation
  'https://github.com/stevearc/oil.nvim',
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  'https://github.com/abeldekat/harpoonline',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/mrloop/telescope-git-branch.nvim',

  -- Git
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/lewis6991/gitsigns.nvim',

  -- Themes
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  'https://github.com/arcticicestudio/nord-vim',
  'https://github.com/AlexvZyl/nordic.nvim',
  'https://github.com/WTFox/jellybeans.nvim',

  -- UI
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/petertriho/nvim-scrollbar',
  { src = 'https://github.com/nvim-mini/mini.notify', version = 'stable' },

  -- Editing
  'https://github.com/prettier/vim-prettier',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/folke/which-key.nvim',
})
