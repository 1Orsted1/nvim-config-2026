-- Several small comforts from one plugin instead of one plugin each.
vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons() -- nvim-tree expects nvim-web-devicons; no need to install it
require("mini.pairs").setup()      -- auto-close brackets/quotes
require("mini.surround").setup()   -- sa/sd/sr: add/delete/replace surroundings
require("mini.ai").setup()         -- more text objects: function args, quotes, brackets (e.g. cia, vaf)
require("mini.statusline").setup()
