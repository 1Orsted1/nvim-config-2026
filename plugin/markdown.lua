-- Renders markdown in the buffer (headings, code blocks, tables, checkboxes,
-- callouts) instead of raw syntax; the line under the cursor stays raw for editing.
-- Parsers (markdown, markdown_inline, html, yaml) come from treesitter.lua; icons from mini.icons.
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  latex = { enabled = false },               -- needs external converters; not used
  completions = { blink = { enabled = true } }, -- checkbox/callout syntax in blink.cmp
})

-- Global (not buffer-local) so it's listed in <leader>? from anywhere
vim.keymap.set("n", "<leader>um", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
