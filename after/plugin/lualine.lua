-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    globalstatus = true,
  },
  sections = {
    lualine_b = { {'b:gitsigns_head', icon = ''}, },
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
