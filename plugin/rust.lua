-- rustaceanvim is to Rust what flutter-tools is to Dart: it owns rust-analyzer
-- (so it's not in lsp.lua) and adds runnables/macros, plus codelldb debugging.
-- rust-analyzer comes from rustup so it always matches the installed compiler.
-- Pinned to a major version: the author ships breaking changes only on majors.
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = { check = { command = "clippy" } }, -- lint on save, not just type-check
    },
  },
}

vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("9") } })

-- Buffer-local: :RustLsp only exists in Rust buffers
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_rust", { clear = true }),
  pattern = "rust",
  callback = function(ev)
    local function map(lhs, cmd, desc)
      vim.keymap.set("n", lhs, "<cmd>RustLsp " .. cmd .. "<CR>", { buffer = ev.buf, desc = desc })
    end
    map("<leader>Rr", "runnables", "Runnables")
    map("<leader>Rd", "debuggables", "Debuggables")
    map("<leader>Rt", "testables", "Testables")
    map("<leader>Rm", "expandMacro", "Expand macro")
    map("<leader>Re", "explainError", "Explain error")
    map("<leader>Rc", "openCargo", "Open Cargo.toml")
  end,
})
