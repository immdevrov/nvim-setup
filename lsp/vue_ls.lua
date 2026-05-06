-- Hybrid mode: vue_ls handles templates/CSS, ts_ls handles <script> blocks.
-- on_new_config prefers project-local typescript, covering both Vue 2 JS and Vue 3 TS repos.
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json', '.git' },
  init_options = {
    typescript = {
      tsdk = require('devise.npm').root_g() .. '/typescript/lib',
    },
  },
  on_new_config = function(new_config, new_root_dir)
    local lib_path = vim.fs.find('node_modules/typescript/lib', { path = new_root_dir, upward = true })[1]
    if lib_path then
      new_config.init_options.typescript.tsdk = lib_path
    end
  end,
}
