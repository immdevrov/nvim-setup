return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript', 'javascriptreact', 'javascript.jsx',
    'typescript', 'typescriptreact', 'typescript.tsx',
    'vue',
  },
  root_markers = {
    'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs', 'eslint.config.ts',
    '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json',
    '.eslintrc.yaml', '.eslintrc.yml',
  },
  settings = {
    validate = 'on',
    useESLintClass = true,
    format = false,
    onIgnoredFiles = 'off',
    workingDirectory = { mode = 'auto' },
    codeActionOnSave = { mode = 'all' },
    experimental = { useFlatConfig = false },
    problems = { shortenToSingleLine = false },
    rulesCustomizations = {},
    run = 'onType',
    nodePath = '',
  },
}
