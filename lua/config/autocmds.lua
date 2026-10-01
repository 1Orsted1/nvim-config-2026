local augroup = vim.api.nvim_create_augroup("user_config", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Briefly highlight yanked text
autocmd("TextYankPost", {
  group = augroup,
  callback = function() vim.hl.on_yank() end,
})

-- Reopen files where you left off
autocmd("BufReadPost", {
  group = augroup,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Throwaway windows should close like a pager
autocmd("FileType", {
  group = augroup,
  pattern = { "help", "qf", "man", "checkhealth", "fugitiveblame", "git" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

-- autoread only triggers on checktime; files often change from the shell
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup,
  command = "checktime",
})

-- Keep splits balanced when the terminal is resized
autocmd("VimResized", {
  group = augroup,
  command = "tabdo wincmd =",
})
