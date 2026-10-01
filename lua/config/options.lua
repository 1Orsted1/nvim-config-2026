local opt = vim.opt

-- No remote plugins here; skipping providers speeds startup and silences checkhealth
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Oil and nvim-tree replace netrw; must be off before plugins load
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"      -- avoid text shifting when signs appear
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.wrap = false
opt.breakindent = true      -- wrapped lines keep indent when wrap is toggled on
opt.winborder = "rounded"   -- borders on hover/signature floats
opt.list = true             -- expose stray tabs/trailing spaces
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.showmode = false        -- statusline already shows it

-- Indentation (ftplugins override per language, e.g. Python → 4)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true        -- case-sensitive if the query has uppercase
opt.inccommand = "split"    -- live preview of :s in a split

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Behaviour
opt.clipboard = "unnamedplus" -- share clipboard with macOS
opt.undofile = true           -- persistent undo
opt.updatetime = 250
opt.timeoutlen = 400          -- which-key popup appears sooner
opt.mouse = "a"
opt.confirm = true            -- ask instead of failing on :q with unsaved changes
opt.autoread = true           -- pick up edits made from the terminal
