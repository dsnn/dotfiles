-- Neovim options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Visual settings
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = false

-- Search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Window behavior
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 10

-- Editing
opt.mouse = "a"
opt.breakindent = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Performance and behavior
opt.timeoutlen = 300
opt.updatetime = 100
opt.swapfile = true
opt.undofile = true
opt.foldenable = false
opt.spell = false
