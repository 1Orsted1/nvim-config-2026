-- Pattern for every plugin file: vim.pack.add() + its setup, nothing else.
vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })

require("tokyonight").setup({ style = "night" })
vim.cmd.colorscheme("tokyonight")
