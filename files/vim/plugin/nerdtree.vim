" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight

autocmd VimEnter * wincmd p	"

" toggle nerd tree
map <C-n> :call ToggleNerdTree()<cr>
nmap <silent> <leader>k :NERDTreeFind<cr>

" toggle NERDTree
function! ToggleNerdTree()
	if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
		:NERDTreeFind
	else
		:NERDTreeToggle
	endif
endfunction

let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']

let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible

augroup nerdtree
	autocmd!
	" turn off whitespace characters
	autocmd FileType nerdtree setlocal nolist
augroup END

let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"  : "✹",
	\ "Staged"    : "✚",
	\ "Untracked" : "✭",
	\ "Renamed"   : "➜",
	\ "Unmerged"  : "═",
	\ "Deleted"   : "✖",
	\ "Dirty"     : "✗",
	\ "Clean"     : "✔︎",
	\ 'Ignored'   : '☒',
	\ "Unknown"   : "?"
\ }
