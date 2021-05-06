vim.wo.number         = true
vim.wo.relativenumber = true
vim.bo.tabstop        = 2
vim.bo.shiftwidth     = 2
vim.bo.softtabstop    = 2
vim.bo.expandtab      = true
vim.bo.cindent        = true
vim.bo.textwidth      = 120
vim.bo.wrapmargin     = 4
vim.o.showmode        = false
vim.o.showcmd         = false
vim.o.showmatch       = true
vim.o.backup          = false
vim.o.completeopt     = "menuone,noselect"
vim.o.clipboard       = "unnamedplus"
vim.o.cmdheight       = 2
vim.o.fileencoding    = "utf-8"
vim.o.hidden          = true
vim.o.history         = 1000
vim.o.ignorecase      = true
vim.o.inccommand      = 'split'
vim.o.mouse           = "a"
vim.o.pumheight       = 10
vim.o.scrolloff       = 10
vim.o.shiftround      = true
vim.o.showmatch       = true
vim.o.showmode        = false
vim.o.showtabline     = 2
vim.o.smartcase       = true
vim.o.splitright      = true
vim.o.swapfile        = false
vim.o.syntax          = 'on'
vim.o.timeoutlen      = 300
vim.o.updatetime      = 300
vim.o.writebackup     = false
vim.wo.cursorline     = true
vim.wo.foldenable     = false
vim.wo.foldlevel      = 0
vim.wo.foldmethod     = "manual"
vim.wo.foldnestmax    = 10
vim.wo.linebreak      = true
vim.o.equalalways     = true
vim.o.splitright      = true
vim.o.splitbelow      = true
vim.o.termguicolors   = true
vim.o.swapfile        = false
vim.g.belloff        = 'all' 

vim.cmd('set cpoptions+=$')
vim.cmd('set iskeyword+=-')
vim.cmd('set shortmess+=c')
vim.cmd('set showbreak=_')
vim.cmd('set tags=./tags;,tags;')
vim.cmd('set whichwrap+=<,>,[,],h,l')
-- if !has('nvim') | set viminfofile=$XDG_CACHE_HOME/vim/viminfo | endif

vim.cmd("colorscheme onedark")
