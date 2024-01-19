setl foldmethod=indent
setl autoindent
setl expandtab
setl tabstop=2
setl shiftwidth=2
setl number

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.nix FormatWrite
augroup END
