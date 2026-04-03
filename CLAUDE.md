# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim 0.12 configuration written in Lua, organized as a personal `devise` module. It uses **vim.pack** (native package manager) and targets web development workflows (TypeScript, Vue, JavaScript, CSS).

## Architecture

**Entry point chain:** `init.lua` → `require('devise')` → `lua/devise/init.lua`

**Core modules** (`lua/devise/`):
- `set.lua` — Editor options (relativenumber, folding, indentation, undo, spell, etc.)
- `remap.lua` — All keymaps; leader key is `<Space>`
- `plugins.lua` — Plugin list via `vim.pack.add()` with `PackChanged` build hooks

**Plugin configs** (`after/plugin/`): Each file configures a single plugin, auto-loaded after plugins initialize. Add new plugin setup calls and plugin-specific keymaps here.

**LSP server configs** (`lsp/`): One file per server, loaded natively by Neovim via `vim.lsp.config`. Contains `cmd`, `filetypes`, `root_markers`, and server-specific settings. No `nvim-lspconfig` plugin involved.

## Plugin Manager

`vim.pack` (Neovim 0.12 built-in). Add plugins to `plugins.lua` with `vim.pack.add()`. Plugins install automatically on next startup. To update: `lua vim.pack.update()`. Lockfile at `nvim-pack-lock.json`.

Build hooks (e.g. `make` for fzf-native) are handled via the `PackChanged` autocmd at the top of `plugins.lua` — register hooks **before** `vim.pack.add()`.

## LSP Setup (`after/plugin/lsp.lua`)

Configured servers: `lua_ls`, `vue_ls` (Vue, hybrid mode), `ts_ls` (TypeScript/JS + Vue via `@vue/typescript-plugin`), `cssls`.

- Global `on_attach` and `capabilities` set once via `vim.lsp.config('*', {...})`
- `ensure_npm_package()` auto-installs missing global npm packages on startup
- Vue hybrid mode: `vue_ls` handles templates/CSS, `ts_ls` handles `<script>` blocks
- `on_new_config` in `lsp/vue_ls.lua` prefers project-local typescript SDK (handles both Vue 2 JS and Vue 3 TS repos)
- Completion: `nvim-cmp` with `LuaSnip` snippets

## Linting

ESLint runs via **nvim-lint** (`after/plugin/lint.lua`), not as an LSP server. Triggers on `BufWritePost` and `BufReadPost`. Uses project-local `node_modules/.bin/eslint` when found (walks up directory tree — monorepo safe), falls back to global `eslint`.

## Key Conventions

- **2-space indentation** (`set.lua`; `vim-sleuth` auto-detects per file)
- **Prettier on save** for `*.tsx`, `*.ts`, `*.jsx`, `*.js`, `*.vue` (`lua/devise/init.lua`)
- **LSP format on save** for `*.lua` (`lua/devise/init.lua`)
- **Folding** uses treesitter expr (`foldmethod=expr`, `foldlevelstart=99` so files open unfolded)
- **Persistent undo** enabled (`undofile=true`, stored in stdpath data)
- New plugin configs → `after/plugin/<name>.lua`
- New global keymaps → `remap.lua`; plugin-specific keymaps → relevant `after/plugin/` file
- New LSP servers → create `lsp/<name>.lua`, add to `vim.lsp.enable()` in `lsp.lua`

## Notable Keymaps

| Key | Action |
|-----|--------|
| `<leader>f` | LSP format buffer |
| `<leader>sf/sw/sg` | Telescope: files / word / grep |
| `<C-a>` / `<C-e>` | Harpoon add / toggle menu |
| `<leader>hh/hj/hk/hl` | Harpoon jump to file 1–4 |
| `-` | Open Oil file browser |
| `jj` | Exit insert mode |
| `<C-s>` / `:W` | Save all buffers |
| `<C-u>zz` / `<C-d>zz` | Scroll up/down centered |
| `<leader>y` | Yank to system clipboard |
