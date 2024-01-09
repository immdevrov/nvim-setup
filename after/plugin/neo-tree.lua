require('neo-tree').setup({
    filesystem = {
        hijack_netrw_behavior = "open_current",
    }
})

vim.keymap.set('n', '<leader>pv', function ()
    require('neo-tree.command').execute({
        reveal = true,
        toggle = true,
    })
end)
