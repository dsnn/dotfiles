
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

" Delete trailing white space on save
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" Statusline
function! GitBranch()
	  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	endfunction

function! StatuslineGit()
	  let l:branchname = GitBranch()
		  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
		endfunction

set laststatus=2 "always show statusline
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\%F
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]

" APPEARANCE
if (has("termguicolors"))
	set termguicolors
endif

set t_Co=256
colorscheme base16-gooey
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" KEYS
let mapleader = ' '
nmap ,, :w<CR>
nmap ,q :q<CR>
nmap ,w :bd<CR>
nmap <leader>u :so ~/.config/nvim/init.vim<CR>
nmap <leader>. <c-^>
" nmap <leader>, :w<CR>
" nmap <leader>q :bd<CR>
" nmap <leader>w :q<CR>
" nmap <leader><space> :%s/\s\+$<CR>
" nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<CR>
" nmap <leader>b :files<CR>
" nmap <C-p> :b

" netrw
" let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
" let g:netrw_banner = 0
" nmap <leader>ve :Explore<CR>
" nmap <leader>vh :Sexplore<CR>
" nmap <leader>vs :Vexplore<CR>

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
" noremap <space> :set hlsearch! hlsearch?<CR>
noremap <leader>, :set hlsearch! hlsearch?<CR>
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>S
nnoremap S :%s//g<Left><Left>
nnoremap <leader>p :cd ..<CR>

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

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

" ---------------------------------------------------------

" Refresh vim-devicons to ensure they render properly (fixes render issues
" after sourcing config file)
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" ALE Move between linting errors
nnoremap ]r :ALENext<CR>
nnoremap [r :ALEPrevious<CR>

" limelight
noremap <leader>l :Limelight!!<CR>

" ultisnips
function! Chomp(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction

let g:snips_author = Chomp(get(g:, 'snips_author', executable('git')? system('git config --global user.name') : expand('$USER')))
let g:snips_email = get(g:, 'snips_email', executable('git')? system('git config --global user.email') : expand('$HOST'))
let g:snips_github = get(g:, 'snips_github', 'https://github.com/' . g:snips_author)
nmap <silent> <leader>es :UltiSnipsEdit<cr>

call plug#begin('~/.config/nvim/plugged')

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-repeat'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'nicknisi/vim-base16-lightline'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'unblevable/quick-scope'
Plug 'sheerun/vim-polyglot' 
Plug 'junegunn/limelight.vim'
Plug 'liuchengxu/vim-which-key' 
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'

call plug#end()
