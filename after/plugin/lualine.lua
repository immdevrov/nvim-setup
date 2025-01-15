local harpoonline = require("harpoonline")
local lualine = require("lualine")
harpoonline.setup({
  on_update = function() require("lualine").refresh() end,
})

lualine.setup {
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    globalstatus = true,
  },
  sections = {
    lualine_a = { {'b:gitsigns_head', icon = ''}, },
    lualine_b = { harpoonline.format },
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
    lualine_x = {'filetype'},
    lualine_z = {'searchcount', 'location'}
  },
}
