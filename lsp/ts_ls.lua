local npm_root = vim.fn.trim(vim.fn.system('npm root -g'))
return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript', 'javascriptreact', 'javascript.jsx',
    'typescript', 'typescriptreact', 'typescript.tsx',
    'vue',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = npm_root .. '/@vue/language-server',
        languages = { 'vue' },
      },
    },
  },
}
