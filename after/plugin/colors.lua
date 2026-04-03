require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- force no italic
    no_bold = false, -- force no bold
    no_underline = false, -- force no underline
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        -- for more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

require('jellybeans').setup({
    transparent = false,
    italics = false,
    bold = true,
    flat_ui = true, -- toggles "flat UI" for pickers
    background = {
        dark = "jellybeans",       -- default dark palette
        light = "jellybeans", -- default light palette
    },
    plugins = {
        all = false,
        auto = true, -- auto-detect installed plugins via lazy.nvim
    },
    on_colors = function(c)
        c.background = "#000000"
    end,
})
vim.cmd('colorscheme jellybeans')

