-- Accurate highlighting/indent for the languages used day to day.
-- The `main` branch is the rewrite targeting Neovim 0.12; parsers need the tree-sitter CLI.

-- Rebuild parsers after a plugin update; must exist before vim.pack.add runs
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })

-- Async and a no-op for parsers already installed, so cheap at startup
require("nvim-treesitter").install({
  "bash", "css", "dart", "diff", "gitcommit", "html", "javascript", "json",
  "lua", "markdown", "markdown_inline", "python", "query", "regex", "tsx",
  "typescript", "vim", "vimdoc", "yaml",
})

-- The main branch doesn't auto-enable anything; turn it on for any buffer with a parser
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
