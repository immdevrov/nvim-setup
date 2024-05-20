-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    layout_config = {
      vertical = {
        width = 0.9,
        preview_cutoff = 0,
      }
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-k>"] = require('telescope.actions').cycle_history_next,
        ["<C-j>"] = require('telescope.actions').cycle_history_prev,
      },
    },
  },
  vimgrep_arguments = {
    "rg",
    "--with-filename",
    "--line-number",
    "--column",
    "--ignore-case",
    "--trim"   -- add this value
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
  pickers = {
    find_files = {
      -- theme = "dropdown",
    },
    live_grep = {
      -- theme = "dropdown",
    },
    grep_string = {
      -- theme = "dropdown",
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


local conf = require('telescope.config').values
-- See `:help telescope.builtin`
local function project_search()
  pcall(vim.cmd.write)
  require('telescope.builtin').find_files {
    previewer = false,
    shorten_path = true,
    layout_strategy = "vertical",
    cwd = require('lspconfig.util').root_pattern(".git")(vim.fn.expand("%:p")),
  }
end

local function grep_search()
  pcall(vim.cmd.write)
  require('telescope.builtin').live_grep {
    shorten_path = true,
    vimgrep_arguments = table.insert(conf.vimgrep_arguments, '--fixed-strings'),
    layout_strategy = "vertical",
  }
end

local function word_search()
  pcall(vim.cmd.write)
  require('telescope.builtin').grep_string {
    shorten_path = true,
    layout_strategy = "vertical",
  }
end

local function current_file_word()
  require('telescope.builtin').current_buffer_fuzzy_find {
    shorten_path = true,
    layout_strategy = "vertical",
  }
end

local function lastSearch()
  require('telescope.builtin').resume()
end

vim.keymap.set('n', '<leader>sf', project_search, { desc = '[S]ejrch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', word_search, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', grep_search, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', current_file_word, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sl', lastSearch, { desc = 'Resume with [L]ast search' })
vim.keymap.set('n', '<C-k><C-t>', require('telescope.builtin').colorscheme, { desc = 'Change colorscheme' })
