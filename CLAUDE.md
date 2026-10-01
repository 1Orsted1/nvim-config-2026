# Neovim config — context

Neovim 0.12.5 on macOS (Ghostty). Daily languages: Node/TS, Flutter/Dart (via fvm), Python.
Goal: as minimal as possible without losing features or comfort. Leader = Space.

## Architecture
- Plugin manager: native `vim.pack` (no lazy.nvim). `nvim-pack-lock.json` is auto-generated — commit it, never hand-edit.
- `init.lua` — sets leader, requires `config.options`, `config.keymaps`, `config.autocmds`.
- `lua/config/` — core, plugin-independent settings and keymaps.
- `plugin/*.lua` — one file per concern, auto-sourced alphabetically. Each = `vim.pack.add` + setup + that concern's keymaps.
  A file lists its own dependencies in `vim.pack.add` (idempotent), so load order doesn't matter.
  Build hooks go in a `PackChanged` autocmd *before* `vim.pack.add` (see `treesitter.lua`).
- `after/lsp/<server>.lua` — per-server overrides, merged by native `vim.lsp.config`. Must be under `after/` to win over nvim-lspconfig's defaults.
- Comments explain *why*, not *what*.

| File | Concern |
|---|---|
| colorscheme.lua | tokyonight (night) |
| which-key.lua | Key popup + group labels |
| snacks.lua | Fuzzy finder, terminal, indent guides, bigfile, input |
| oil.lua | `-` / `nvim .` directory-as-buffer |
| tree.lua | nvim-tree sidebar (`<leader>e`); doesn't hijack dirs (Oil does) |
| treesitter.lua | nvim-treesitter `main` branch; parsers + highlight/indent autocmd |
| lsp.lua | lspconfig defaults + Mason (via mason-tool-installer) + `vim.lsp.enable` + LspAttach keymaps |
| flutter.lua | flutter-tools: owns dartls (fvm-aware) + run/reload/devices |
| completion.lua | blink.cmp (1.* prebuilt binary) + friendly-snippets |
| format.lua | conform: prettierd / ruff / dart format / stylua, format-on-save toggle |
| git.lua | gitsigns (hunks) + fugitive (status/commit/log/diff) |
| mini.lua | icons (+ devicons mock for nvim-tree), pairs, surround, ai, statusline |

Servers: vtsls, eslint, pyright, ruff, lua_ls, jsonls, yamlls (Mason) + dartls (Flutter SDK).
pyright, not basedpyright: Mason's basedpyright needs Python ≥3.10 and system python3 is 3.9.

## Maintenance
- Update plugins: `<leader>pu`. Mason tools: `:Mason`. Parsers: `:TSUpdate`.
- Remove plugin: delete its file + `:lua vim.pack.del({ "name" })`.
- External deps (Homebrew): `tree-sitter-cli`, `ripgrep`, `fd`.

## Verification (definition of done)
- `nvim --headless +qa` prints nothing.
- `nvim --headless "+checkhealth" "+w! /tmp/h.txt" +qa`. Known, accepted leftovers:
  - snacks: errors for *disabled* modules (image tools, lazygit, notifier). `vim.ui.input/select` errors only appear headless (snacks sets them on UIEnter).
  - mason: optional runtimes (Go, cargo, PHP, Java, ...) not installed — not needed.
  - blink: "providers may show up as disabled" is informational.
- Per-language attach test: open a file headless and print `vim.lsp.get_clients({bufnr=0})`.

## Keymaps (Space = leader; Shift-letter groups = language/tool)
| Keys | Action |
|---|---|
| `<Space><Space>` / `<Space>/` / `<Space>?` | Find files / grep / search keymaps |
| `-` / `<Space>e` | Oil parent dir / file tree |
| `H` / `L`, `<Space>bd`, `<Space>bo` | Prev/next buffer, close buffer, close others |
| `<Space>f…` | ff files(+hidden), fg grep, fb buffers, fr recent, fw word, fh help, fR resume |
| `gd` `gD` `gy` `grr` `gri` `K` | Definition, declaration, type def, references, implementations, hover |
| `grn` / `gra` (or `<Space>cr` / `<Space>ca`) | Rename / code action |
| `<Space>c…` | cf format, cd line diagnostic, cs/cS symbols |
| `]d` `[d` / `]h` `[h` | Diagnostics / git hunks |
| `<Space>x…` | xx buffer diagnostics, xX workspace, xq quickfix |
| `<Space>g…` | gg status, gc commit, gd diff, gl log, gs/gr stage/reset hunk, gp preview, gb blame, gB inline blame |
| `<Space>F…` | Fr run, Fq quit, Fh hot reload, FR restart, Fd devices, Fe emulators, Fo outline, Fl log, Fp pub get, Fc all |
| `<C-/>` / `<Space>t` | Toggle terminal |
| `<Space>u…` | uf format-on-save, uw wrap, ur relnum, ud diagnostics, uh inlay hints |
| `<Space>w` / `q` / `Q` | Save / quit window / quit all |
| `sa` `sd` `sr` | Surround add/delete/replace (mini.surround) |
| `gc` | Comment (built-in) |

## Later
- DAP debugging (Node, Python, Dart) — deliberately postponed.
