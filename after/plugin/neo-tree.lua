require('neo-tree').setup({
    filesystem = {
        hijack_netrw_behavior = "open_current",
        visible=true,
    }

})

vim.keymap.set('n', '<leader>pv', function ()
    require('neo-tree.command').execute({
        reveal = true,
        toggle = true,
        position = "float",
    })
end)
