-- nvim-dap speaks the same Debug Adapter Protocol as VS Code, so it reuses VS Code's
-- adapters and reads .vscode/launch.json from the cwd natively (e.g. Flutter flavors).
-- Dart's adapter is registered by flutter-tools, Rust's by rustaceanvim.
vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/mfussenegger/nvim-dap-python",
})

local dap = require("dap")

-- dap-view over dap-ui: lighter, no nvim-nio, and ships inline variable values
require("dap-view").setup({
  auto_toggle = true, -- open on session start, close on end
  virtual_text = { enabled = true },
})

-- Node/JS/TS: Mason's js-debug (same engine VS Code uses)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = { command = "js-debug-adapter", args = { "${port}" } },
}
local node_configs = {
  { type = "pwa-node", request = "launch", name = "Launch current file", program = "${file}", cwd = "${workspaceFolder}" },
  { type = "pwa-node", request = "attach", name = "Attach to process", processId = require("dap.utils").pick_process, cwd = "${workspaceFolder}" },
  { type = "pwa-node", request = "attach", name = "Attach to :9229 (--inspect)", port = 9229, cwd = "${workspaceFolder}" },
}
for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
  dap.configurations[ft] = node_configs
end

-- Python: uv fetches debugpy on demand (Mason can't: system python is 3.9);
-- the debuggee still runs with the project's .venv when there is one
require("dap-python").setup("uv")

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

local map = vim.keymap.set
map("n", "<leader>dc", dap.continue, { desc = "Start / continue" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, { desc = "Conditional breakpoint" })
map("n", "<leader>do", dap.step_over, { desc = "Step over" })
map("n", "<leader>di", dap.step_into, { desc = "Step into" })
map("n", "<leader>dO", dap.step_out, { desc = "Step out" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
map("n", "<leader>dr", dap.restart, { desc = "Restart" })
map("n", "<leader>dl", dap.run_last, { desc = "Run last" })
map("n", "<leader>dq", dap.terminate, { desc = "Stop" })
map("n", "<leader>du", "<cmd>DapViewToggle<CR>", { desc = "Toggle debug UI" })
map({ "n", "x" }, "<leader>de", function() require("dap.ui.widgets").hover() end, { desc = "Evaluate under cursor" })
map({ "n", "x" }, "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "Add to watches" })

-- F-keys for VS Code muscle memory (on macOS: fn+F5, or enable standard F-keys)
map("n", "<F5>", dap.continue, { desc = "Debug: continue" })
map("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: breakpoint" })
map("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
map("n", "<S-F11>", dap.step_out, { desc = "Debug: step out" })
