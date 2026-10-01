-- Formatting runs the project's real tools (prettier, ruff, dart format, rustfmt) instead of
-- whatever the LSP ships, so output matches CI and teammates.
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

-- Only with a prettier config in the project: otherwise prettier's defaults (and the
-- LSP fallback) would rewrite every file you save in repos that never used it
local prettier = { "prettierd", lsp_format = "never" }

require("conform").setup({
  formatters_by_ft = {
    javascript = prettier, javascriptreact = prettier,
    typescript = prettier, typescriptreact = prettier,
    json = prettier, jsonc = prettier, yaml = prettier,
    css = prettier, html = prettier, markdown = prettier,
    python = { "ruff_organize_imports", "ruff_format" },
    dart = { "dart_format" },
    lua = { "stylua" },
    rust = { "rustfmt" },
  },
  formatters = { prettierd = { require_cwd = true } },
  -- Set here, not in format_on_save, so the per-filetype "never" above can override it
  default_format_opts = { lsp_format = "fallback" },
  -- Toggleable because some repos aren't formatted and a save would rewrite whole files
  format_on_save = function()
    if vim.g.disable_autoformat then return end
    return { timeout_ms = 1000 }
  end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" -- `gq` uses the same formatters

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format" })

vim.keymap.set("n", "<leader>uf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
end, { desc = "Toggle format on save" })
