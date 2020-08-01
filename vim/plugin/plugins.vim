call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', {'true': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'mileszs/ack.vim'
Plug 'SirVer/ultisnips'
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
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'francoiscabrol/ranger.vim'
" Plug 'rbgrouleff/bclose.vim'
Plug 'unblevable/quick-scope'
Plug 'sheerun/vim-polyglot' 
Plug 'junegunn/limelight.vim'

call plug#end()