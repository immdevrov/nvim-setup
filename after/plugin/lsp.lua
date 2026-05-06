local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = capabilities,
})

local npm_root = require('devise.npm').root_g()

local function ensure_npm_package(package_name)
  local bare_name = package_name:match('^(@?[^@]+)')
  local package_path = npm_root .. '/' .. bare_name
  if vim.fn.isdirectory(package_path) == 0 then
    local install_cmd = 'npm install -g ' .. package_name
    vim.notify('Installing ' .. package_name .. ' globally...', vim.log.levels.INFO)
    local success, result = pcall(vim.fn.system, install_cmd)
    if not success or vim.v.shell_error ~= 0 then
      vim.notify('Failed to install ' .. package_name .. ': ' .. (result or ''), vim.log.levels.ERROR)
      return nil
    end
    if vim.fn.isdirectory(package_path) == 0 then
      vim.notify(package_name .. ' installation failed', vim.log.levels.ERROR)
      return nil
    end
  end
end

ensure_npm_package('typescript@5.8.2')
ensure_npm_package('typescript-language-server@4.3.4')
ensure_npm_package('@vue/language-server@2.2.8')
ensure_npm_package('@vue/typescript-plugin@2.2.8')
ensure_npm_package('vscode-langservers-extracted')

vim.lsp.enable({ 'lua_ls', 'vue_ls', 'ts_ls', 'cssls', 'eslint' })

local eslint_fix_group = vim.api.nvim_create_augroup('eslint_fix_on_save', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = eslint_fix_group,
  pattern = { '*.js', '*.jsx', '*.mjs', '*.cjs', '*.ts', '*.tsx', '*.vue' },
  callback = function(args)
    local clients = vim.lsp.get_clients({ name = 'eslint', bufnr = args.buf })
    if #clients == 0 then return end

    local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding or 'utf-16')
    params.context = { only = { 'source.fixAll.eslint' }, diagnostics = {} }

    for _, client in ipairs(clients) do
      local result = client:request_sync('textDocument/codeAction', params, 1500, args.buf)
      if result and result.result then
        for _, action in ipairs(result.result) do
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or 'utf-16')
          end
          if type(action.command) == 'table' then
            client:request_sync('workspace/executeCommand', action.command, 1500, args.buf)
          end
        end
      end
    end
  end,
})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

  local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
