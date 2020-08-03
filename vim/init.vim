source ~/.config/nvim/plugin/plugins.vim

" GENERAL
syntax on
filetype plugin indent on

" SET
set encoding=utf8
set omnifunc=syntaxcomplete#Complete
set noswapfile
set clipboard=unnamedplus
set mouse=a
set cpoptions+=$
set background=dark
set noshowmode
set encoding=utf-8
set autoread
set hidden
set history=1000
set textwidth=120
set backspace=indent,eol,start
set showcmd
set showmode
set smartindent
set tm=500
set splitbelow
set splitright
set tags=./tags;,tags;
set inccommand=nosplit
set laststatus=2
set number
set relativenumber
set wrap
set wrapmargin=8
set linebreak
set showbreak=_
set autoindent
set ttyfast
set so=10
set cmdheight=1
set showmatch
set laststatus=2
set foldmethod=syntax
set foldlevelstart=99
set foldnestmax=10
set nofoldenable
set foldlevel=1
set noerrorbells
set visualbell
set ignorecase
set smartcase
set incsearch
set nolazyredraw
set noexpandtab
set smarttab
set tabstop=2
set softtabstop=4
set shiftwidth=4
set shiftround
" set spelllang=en_us

" ABBR
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
abbr cosnt cosnt
abbr vonst const
abbr seperate separate
abbr cosnt const

" AUTO COMMANDS
if !exists("statusline_loaded")
	let statusline_loaded = 1
	set statusline+=%{FugitiveStatusline()}
	set statusline+=%F
endif

" augroup vimrc
"   autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
" augroup END

" APPEARANCE
if (has("termguicolors"))
	set termguicolors
endif

set t_Co=256
colorscheme base16-gooey
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" FUNCTIONS
function! RenameFile()
	let old_name = expand('%')
	let new_name = input('New file name: ', expand('%'),'file')
	if new_name != '' && new_name != old_name
		exec ':saveas ' . new_name
		exec ':silent !rm ' . old_name
		redraw!
	endif
endfunction
" map <leader>n :call RenameFile()<cr>

" KEYS
let mapleader = ','
nmap <leader>, :w<CR>
nmap <leader>u :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :q<CR>
nmap <leader><space> :%s/\s\+$<CR>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<CR>
nmap <leader>. <c-^>

" shortcuts
map <leader>ev :e! ~/.config/nvim/init.vim<CR>
map <leader>eg :e! ~/.gitconfig<CR>

" ultisnips
function! Chomp(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction

let g:snips_author = Chomp(get(g:, 'snips_author', executable('git')? system('git config --global user.name') : expand('$USER')))
let g:snips_email = get(g:, 'snips_email', executable('git')? system('git config --global user.email') : expand('$HOST'))
let g:snips_github = get(g:, 'snips_github', 'https://github.com/' . g:snips_author)
nmap <silent> <leader>es :UltiSnipsEdit<cr>

" change x buffer so it doesn't interfere with system clipboard
noremap x "_x"
noremap X "_x"

" move selected line(s) up and down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv 

set pastetoggle=<F2>
nnoremap <silent> Q <C-w>c
noremap <space> :set hlsearch! hlsearch?<CR>
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>S
nnoremap S :%s//g<Left><Left>

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" ale
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <silent> <leader>af :ALEFindReferences<cr>

" limelight
noremap <leader>l :Limelight!!<CR>

" Refresh vim-devicons to ensure they render properly (fixes render issues
" after sourcing config file)
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" Turn spellcheck on for markdown files. 
" augroup auto_spellcheck
"   autocmd BufNewFile,BufRead *.md setlocal spell
"   augroup END

