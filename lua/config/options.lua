local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"      -- avoid text shifting when signs appear
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.wrap = false

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true        -- case-sensitive if the query has uppercase

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Behaviour
opt.clipboard = "unnamedplus" -- share clipboard with macOS
opt.undofile = true           -- persistent undo
opt.updatetime = 250
opt.mouse = "a"
