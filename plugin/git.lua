-- gitsigns: per-hunk work while editing. fugitive: whole-repo work (status,
-- commit, log) without leaving the editor; replaces lazygit.
-- diffview: VS Code-style review of everything changed since the last commit.
vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/sindrets/diffview.nvim",
})

require("gitsigns").setup({
  on_attach = function(buf)
    local gs = require("gitsigns")
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end
    map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
    map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
    map({ "n", "x" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
    map({ "n", "x" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
    map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")
  end,
})

local map = vim.keymap.set
map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git status (fugitive)" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Commit" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Diff file vs index" })
map("n", "<leader>gl", "<cmd>Git log --oneline --graph --decorate<CR>", { desc = "Log" })

map("n", "<leader>gv", function()
  -- One key to open and close: diffview tabs are easy to forget otherwise
  if next(require("diffview.lib").views) then vim.cmd("DiffviewClose") else vim.cmd("DiffviewOpen") end
end, { desc = "Review changes (diffview)" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Repo history" })
