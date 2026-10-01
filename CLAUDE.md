# Neovim config — context

Neovim 0.12.5 on macOS. Built incrementally: one feature/plugin per step, verified, then ask before the next.

## Architecture
- Plugin manager: native `vim.pack` (no lazy.nvim).
- `init.lua` — sets `mapleader`/`maplocalleader` to Space, then requires `config.options`, `config.keymaps`, `config.autocmds`.
- `lua/config/` — core, plugin-independent settings.
- `plugin/*.lua` — one file per plugin, auto-sourced alphabetically after init.lua. Pattern:
  ```lua
  vim.pack.add({ "https://github.com/owner/repo" })
  require("repo").setup({ ... })
  ```
  Build hooks (e.g. treesitter `:TSUpdate`) go in a `PackChanged` autocmd defined *before* the `vim.pack.add` call.
- `nvim-pack-lock.json` — auto-generated, never edit by hand, commit it.
- Remove plugin: delete its file + `:lua vim.pack.del({ "name" })` (don't rm dirs manually).
- Update: `<leader>pu`. Health: `:checkhealth vim.pack`.
- Verify changes with: `nvim --headless +qa`.

## Status (2026-09-30)
- [x] Core options / keymaps / autocmds
- [x] Colorscheme — tokyonight (night), placeholder
- [ ] Fuzzy finder
- [ ] Treesitter
- [ ] LSP + completion
- [ ] Git signs
- [ ] File explorer

## Open questions for the user
1. Main languages/stacks (guess: Flutter/Dart, JS/TS backend)?
2. OK with the plugin order above?
3. Preferred colorscheme?
4. `git init` this directory?
