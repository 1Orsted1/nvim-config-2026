-- Popup listing keys after <leader>: the answer to "I don't remember my mappings".
vim.pack.add({ "https://github.com/folke/which-key.nvim" })

local wk = require("which-key")
wk.setup({ preset = "helix" })

-- Group labels only; the mappings themselves are defined where they belong
wk.add({
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code" },
  { "<leader>d", group = "debug" },
  { "<leader>f", group = "find" },
  { "<leader>g", group = "git" },
  { "<leader>p", group = "plugins" },
  { "<leader>u", group = "ui toggles" },
  { "<leader>x", group = "diagnostics" },
  { "<leader>F", group = "flutter" },
  { "<leader>R", group = "rust" },
})
