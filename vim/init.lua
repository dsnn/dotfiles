vim.bo.autoindent=true
vim.bo.expandtab = true
vim.bo.shiftwidth=2
vim.bo.smartindent=true
vim.bo.softtabstop=2
vim.bo.tabstop=2
vim.bo.textwidth=120
vim.bo.wrapmargin=8
vim.cmd('set cpoptions+=$')             
vim.cmd('set iskeyword+=-')
vim.cmd('set shortmess+=c')             
vim.cmd('set showbreak=_')
vim.cmd('set tags=./tags;,tags;')
vim.cmd('set whichwrap+=<,>,[,],h,l')
vim.o.backup=false                      
vim.o.clipboard="unnamedplus"           
vim.o.cmdheight=2                       
vim.o.conceallevel=0                    
vim.o.fileencoding="utf-8"              
vim.o.hidden=true                       
vim.o.history = 1000
vim.o.ignorecase = true
vim.o.ignorecase = true
vim.o.inccommand = 'nosplit'
vim.o.mouse="a"                         
vim.o.pumheight=10                      
vim.o.scrolloff = 10
vim.o.shiftround = true
vim.o.showmatch = true
vim.o.showmode = false
vim.o.showmode=false                    
vim.o.showtabline=2                     
vim.o.smartcase = true
vim.o.splitbelow=true                   
vim.o.splitright=true                   
vim.o.swapfile = false
vim.o.syntax = 'on'
vim.o.t_Co="256"                        
vim.o.termguicolors=true
vim.o.timeoutlen=300                    
vim.o.updatetime=300                    
vim.o.writebackup=false                 
vim.wo.cursorline=true                  
vim.wo.foldenable = false
vim.wo.foldlevel=1
vim.wo.foldmethod = "syntax"
vim.wo.foldnestmax=10
vim.wo.linebreak=true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn="yes"                 
vim.wo.wrap=true                       

require('plugins')
require('dsn.globals')
require('dsn.treesitter')
require('dsn.nvimtree')

-- colorscheme
vim.cmd('colorscheme aurora')
vim.cmd('let g:nvcode_termcolors=256')

-- mappings
vim.g.mapleader = ','

local map_options = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', ',,', ':w<CR>', map_options)
vim.api.nvim_set_keymap('n', ',q', ':q<CR>', map_options)
vim.api.nvim_set_keymap('n', ',w', ':Bdelete<CR>', map_options)
vim.api.nvim_set_keymap('n', '<Leader>.', '<C-^>', map_options)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':set hlsearch!<CR>', map_options)

-- nvim tree 
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', map_options)
vim.api.nvim_set_keymap('n', '<Leader>k', ':NvimTreeFindFile<CR>', map_options)

-- line indentation
vim.api.nvim_set_keymap('v', '<', '<gv', map_options)
vim.api.nvim_set_keymap('v', '>', '>gv', map_options)

-- esc
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', map_options)
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', map_options)
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', map_options)

-- move lines
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', map_options)
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', map_options)

-- splits
vim.api.nvim_set_keymap('n', '<Leader>s', ':split<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>v', ':vsplit<CR>', {silent = true})

-- window navigation 
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- terminal navigation

vim.g.floaterm_keymap_toggle = '<leader>t'
vim.g.floaterm_keymap_next   = '<leader>tn'
vim.g.floaterm_keymap_prev   = '<leader>tp'
vim.g.floaterm_keymap_new    = '<leader>ta'
vim.g.floaterm_keymap_kill   = '<leader>tk'
vim.g.floaterm_title=''

vim.g.floaterm_gitcommit='floaterm'
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_wintitle=0
vim.g.floaterm_autoclose=1

-- vim.api.nvim_set_keymap('n', '<leader>tn', ':FloatermNew<CR>', {silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>tk', ':FloatermKill<CR>', {silent = true})

vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
]])

-- buffer navigation
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', map_options)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', map_options)

-- window resizing
vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

-- telescope
require('dsn.telescope')
require('dsn.telescope.pickers')
local h = require('dsn.telescope.helpers')

h.set_tele_keymap('<leader>fd', 'edit_dotfiles')
h.set_tele_keymap('<leader>gb', 'git_branches')
h.set_tele_keymap('<leader>fb', 'buffers')
h.set_tele_keymap('<leader>fh', 'help_tags')
h.set_tele_keymap('<leader>fa', 'search_all_files')
h.set_tele_keymap('<leader>ff', 'search_all_files')
h.set_tele_keymap('<leader>fc', 'colorscheme')
h.set_tele_keymap('<leader>fr', 'registers')
h.set_tele_keymap('<leader>fq', 'quickfix')
-- h.set_tele_keymap('<leader>fe', 'file_browser')
-- h.set_tele_keymap('<leader>ff', 'curbuf')
-- h.set_tele_keymap('<leader>gw', 'grep_str')
-- h.set_tele_keymap('<leader>f/', 'grep_last_search')
-- h.set_tele_keymap('<leader>gf', 'git_files')
-- h.set_tele_keymap('<leader>fg', 'grep_live')

-- comments
require('nvim_comment').setup()

-- lsp & completion 
require('dsn.compe')
require('dsn.lsp')

