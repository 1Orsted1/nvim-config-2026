-- blink.cmp over nvim-cmp: one plugin (no source plugins), Rust fuzzy matcher,
-- built-in signature help. The 1.* tag pulls a prebuilt binary, no cargo needed.
vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  keymap = { preset = "enter" }, -- <CR> accepts, <Tab>/<S-Tab> jump snippet fields, <C-space> opens
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    list = { selection = { preselect = true, auto_insert = false } },
  },
  signature = { enabled = true },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
})
