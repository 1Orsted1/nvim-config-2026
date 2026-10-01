-- Native vim.lsp does the work; lspconfig only supplies server defaults (cmd,
-- filetypes, root markers) and Mason installs the binaries so nothing is global.
-- Per-server tweaks live in after/lsp/<name>.lua (after/ so they win over lspconfig).
-- Dart is not here: flutter-tools owns dartls (plugin/flutter.lua).
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    -- language servers
    "vtsls", "eslint-lsp", "pyright", "ruff",
    "lua-language-server", "json-lsp", "yaml-language-server",
    -- formatters (used by plugin/format.lua)
    "prettierd", "stylua",
    -- debug adapters (used by plugin/debug.lua and plugin/rust.lua)
    "js-debug-adapter", "codelldb", -- debugpy comes via uv (see debug.lua)
  },
})

vim.lsp.enable({ "vtsls", "eslint", "pyright", "ruff", "lua_ls", "jsonls", "yamlls" })

-- 0.11+ hides inline diagnostics by default; they're the fastest feedback loop
vim.diagnostic.config({
  virtual_text = { spacing = 2, source = "if_many" },
  severity_sort = true,
  float = { source = true },
})

-- Buffer-local so they only exist where a server can answer them.
-- Neovim already provides grn (rename), gra (action), grr, gri, gO, K, <C-s>.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
  callback = function(ev)
    local function map(lhs, rhs, desc, mode)
      vim.keymap.set(mode or "n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    local P = Snacks.picker
    map("gd", function() P.lsp_definitions() end, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gy", function() P.lsp_type_definitions() end, "Go to type definition")
    map("grr", function() P.lsp_references() end, "References")
    map("gri", function() P.lsp_implementations() end, "Implementations")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>uh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
    end, "Toggle inlay hints")
  end,
})
