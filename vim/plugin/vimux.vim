" Prompt for a command to run
" nmap <leader>z :call VimuxRunCommand("test")<CR>

" Prompt for a command to run
map <leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane (vi move in temp console)
map <leader>vi :VimuxInspectRunner<CR>

" Zoom the tmux runner pane
map <leader>vz :VimuxZoomRunner<CR>

