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
set softtabstop=2
set shiftwidth=2
set shiftround
set spelllang=en
set spellfile=~/.config/nvim/spell/en.utf-8.add
set complete+=kspell
set list listchars=tab:»·,trail:·,nbsp:·

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
	set statusline+=%F
endif

" APPEARANCE
if (has("termguicolors"))
	set termguicolors
endif

set t_Co=256
colorscheme base16-gooey
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" KEYS
let mapleader = ','
nmap <leader>, :w<CR>
nmap <leader>u :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :q<CR>
nmap <leader><space> :%s/\s\+$<CR>
nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<CR>
nmap <leader>. <c-^>
nmap <leader>b :files<CR>
nmap <C-p> :b

" netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_banner = 0
nmap <leader>ve :Explore<CR> 
nmap <leader>vh :Sexplore<CR> 
nmap <leader>vs :Vexplore<CR> 

" shortcuts
map <leader>ev :e! ~/.config/nvim/init.vim<CR>
map <leader>eg :e! ~/.gitconfig<CR>

" change x buffer so it doesn't interfere with system clipboard
noremap x "_x"
noremap X "_x"

" move selected line(s) up and down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv 

" Quickly insert an empty new line without entering insert mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

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
augroup auto_spellcheck
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" " Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.

" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>S :call ToggleSpellCheck()<CR>
