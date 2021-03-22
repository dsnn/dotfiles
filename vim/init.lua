vim.bo.autoindent=true
vim.bo.smartindent=true
vim.bo.softtabstop=2
vim.bo.wrapmargin=8
vim.cmd('set autoread')             
vim.cmd('set backspace=indent,eol,start')             
vim.cmd('set cpoptions+=$')             
vim.cmd('set encoding=utf8')             
vim.cmd('set history=1000')             
vim.cmd('set ignorecase')
vim.cmd('set inccommand=nosplit')
vim.cmd('set incsearch')
vim.cmd('set iskeyword+=-')             -- local to buffer
vim.cmd('set laststatus=2')
vim.cmd('set noerrorbells')
vim.cmd('set nolazyredraw')
vim.cmd('set noshowmode')             
vim.cmd('set noswapfile')             
vim.cmd('set shiftround')
vim.cmd('set shiftwidth=4')             -- local to buffer                     
vim.cmd('set shortmess+=c')             
vim.cmd('set showbreak=_')
vim.cmd('set showcmd')
vim.cmd('set showmatch')
vim.cmd('set smartcase')
vim.cmd('set smarttab')
vim.cmd('set scrolloff=10')
vim.cmd('set tabstop=4')                     -- local to buffer
vim.cmd('set tags=./tags;,tags;')
vim.cmd('set textwidth=120')                -- local to buffer
vim.cmd('set visualbell')
vim.cmd('set whichwrap+=<,>,[,],h,l')
vim.cmd('syntax on')             
vim.o.backup=false                      
vim.o.clipboard="unnamedplus"           
vim.o.cmdheight=2                       
vim.o.conceallevel=0                    
vim.o.fileencoding="utf-8"              
vim.o.hidden=true                       
vim.o.mouse="a"                         
vim.o.pumheight=10                      
vim.o.showmode=false                    
vim.o.showtabline=2                     
vim.o.splitbelow=true                   
vim.o.splitright=true                   
vim.o.t_Co="256"                        
vim.o.termguicolors=true
vim.o.timeoutlen=300                    
vim.o.updatetime=300                    
vim.o.writebackup=false                 
vim.wo.cursorline=true                  
vim.wo.foldlevel=1
vim.wo.foldnestmax=10
vim.wo.linebreak=true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn="yes"                 
vim.wo.wrap=true                       
-- vim.wo.nofoldenable=true
-- vim.wo.list listchars=tab:»·,trail:·,nbsp:·
-- vim.bo.noexpandtab=true
-- vim.wo.foldmethod=syntax
-- vim.wo.foldlevelstart=99
-- vim.bo.spelllang=en
-- vim.bo.spellfile=~/.config/nvim/spell/en.utf-8.add
-- vim.bo.complete+=kspell

vim.cmd('colorscheme nvcode')
vim.cmd('let g:nvcode_termcolors=256')

vim.g.mapleader = ','

vim.api.nvim_set_keymap('n', ',,', ':w<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',q', ':q<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',w', ':bd<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>.', '<C-^>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<Leader><space>', ':set hlsearch!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- navigation 
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

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

vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

vim.cmd([[
  nnoremap <silent> <C-Up>    :resize -2<CR>
  nnoremap <silent> <C-Down>  :resize +2<CR>
  nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  nnoremap <silent> <C-Right> :vertical resize +2<CR>
]])

vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- telescope
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

require('plugins')
