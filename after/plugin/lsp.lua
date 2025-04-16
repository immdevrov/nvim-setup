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

require('neodev').setup()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  }
}
local npm_root = vim.fn.trim(vim.fn.system('npm root -g'))

require 'lspconfig'.volar.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = npm_root .. '/typescript/lib'
    }
  },
  on_new_config = function(new_config, new_root_dir)
    local lib_path = vim.fs.find('node_modules/typescript/lib', { path = new_root_dir, upward = true })[1]
    if lib_path then
      new_config.init_options.typescript.tsdk = lib_path
    end
  end

}

local function ensure_npm_package(package_name, npm_root)
  -- Check if package is installed
  local package_path = npm_root .. '/' .. package_name
  if vim.fn.isdirectory(package_path) == false then
    -- Install package if missing
    local install_cmd = 'npm install -g ' .. package_name
    vim.notify('Installing ' .. package_name .. ' globally...', vim.log.levels.INFO)

    local success, result = pcall(vim.fn.system, install_cmd)
    if not success or vim.v.shell_error ~= 0 then
      vim.notify('Failed to install ' .. package_name .. ': ' .. (result or ''), vim.log.levels.ERROR)
      return nil
    end

    -- Verify installation after attempt
    if vim.fn.isdirectory(package_path) == 0 then
      vim.notify(package_name .. ' installation failed', vim.log.levels.ERROR)
      return nil
    end
  end
end

ensure_npm_package('typescript@5.8.2', npm_root)
ensure_npm_package('typescript-language-server@4.3.4', npm_root)
ensure_npm_package('@vue/language-server@2.2.8', npm_root)
ensure_npm_package('@vue/typescript-plugin@2.2.8', npm_root)
ensure_npm_package('vscode-langservers-extracted', npm_root)

require 'lspconfig'.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = npm_root .. "/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "vue",
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

require 'lspconfig'.eslint.setup({
  on_attach = function(_client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
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
