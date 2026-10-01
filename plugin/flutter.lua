-- Runs dartls from the active Flutter SDK and adds run/hot-reload/devices,
-- which a bare LSP setup can't do.
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-flutter/flutter-tools.nvim",
})

require("flutter-tools").setup({
  fvm = true, -- respect a project's .fvm SDK; falls back to `flutter` on PATH
  debugger = { enabled = true }, -- registers the `dart` adapter used by launch.json flavors
  widget_guides = { enabled = true },
  closing_tags = { enabled = true },
  lsp = {
    -- Function form: resolved at server start, after blink.cmp has loaded
    capabilities = function(defaults) return require("blink.cmp").get_lsp_capabilities(defaults) end,
    settings = { completeFunctionCalls = true, renameFilesWithClasses = "prompt" },
  },
})

local map = vim.keymap.set
map("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "Run" })
map("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Quit" })
map("n", "<leader>Fh", "<cmd>FlutterReload<CR>", { desc = "Hot reload" })
map("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Hot restart" })
map("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "Devices" })
map("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Emulators" })
map("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Widget outline" })
map("n", "<leader>Fl", "<cmd>FlutterLogToggle<CR>", { desc = "Log" })
map("n", "<leader>Fp", "<cmd>FlutterPubGet<CR>", { desc = "Pub get" })
map("n", "<leader>Fc", "<cmd>FlutterCommands<CR>", { desc = "All commands" })
