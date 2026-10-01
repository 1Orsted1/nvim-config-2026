-- Sidebar tree for getting the lay of a project; Oil handles directory buffers.
vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })

require("nvim-tree").setup({
  hijack_netrw = false,
  hijack_directories = { enable = false }, -- leave `nvim .` to Oil
  sync_root_with_cwd = true,
  update_focused_file = { enable = true }, -- highlight the file you're editing
  filters = { dotfiles = false, git_ignored = false },
  view = { width = 32 },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "File tree" })
