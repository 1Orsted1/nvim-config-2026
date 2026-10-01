-- Entry point. Core settings live in lua/config/.
-- Plugins live in plugin/ (one file per plugin) and are auto-sourced by
-- Neovim after this file, in alphabetical order.

-- Leader must be set before any keymaps/plugins are defined.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")
