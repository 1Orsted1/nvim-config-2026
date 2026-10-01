-- One plugin for fuzzy finding, a toggle terminal and small QoL modules,
-- instead of separate telescope/toggleterm/indent-blankline plugins.
vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  picker = { enabled = true },
  terminal = { enabled = true },
  indent = { enabled = true },
  bigfile = { enabled = true }, -- huge files (logs, bundles) open without LSP/treesitter lag
  input = { enabled = true },   -- nicer vim.ui.input for LSP rename
})

local map = vim.keymap.set
local P = Snacks.picker

-- Fuzzy finding
map("n", "<leader><space>", function() P.files() end, { desc = "Find files" })
map("n", "<leader>/", function() P.grep() end, { desc = "Grep project" })
map("n", "<leader>?", function() P.keymaps() end, { desc = "Search keymaps" })
map("n", "<leader>ff", function() P.files({ hidden = true }) end, { desc = "Files (incl. hidden)" })
map("n", "<leader>fg", function() P.grep() end, { desc = "Grep" })
map("n", "<leader>fb", function() P.buffers() end, { desc = "Buffers" })
map("n", "<leader>fr", function() P.recent() end, { desc = "Recent files" })
map({ "n", "x" }, "<leader>fw", function() P.grep_word() end, { desc = "Grep word/selection" })
map("n", "<leader>fh", function() P.help() end, { desc = "Help pages" })
map("n", "<leader>fR", function() P.resume() end, { desc = "Resume last search" })

-- Diagnostics / symbols
map("n", "<leader>xx", function() P.diagnostics_buffer() end, { desc = "Buffer diagnostics" })
map("n", "<leader>xX", function() P.diagnostics() end, { desc = "Workspace diagnostics" })
map("n", "<leader>cs", function() P.lsp_symbols() end, { desc = "Document symbols" })
map("n", "<leader>cS", function() P.lsp_workspace_symbols() end, { desc = "Workspace symbols" })

-- Buffers: keep the window layout when closing a buffer
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Close buffer" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Close other buffers" })

-- Terminal. <C-_> is what most terminals actually send for Ctrl-/
for _, lhs in ipairs({ "<C-/>", "<C-_>" }) do
  map({ "n", "t" }, lhs, function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })
end
map("n", "<leader>t", function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })
