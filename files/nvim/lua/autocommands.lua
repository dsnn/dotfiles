vim.cmd([[autocmd FileType markdown setlocal spell]])

vim.cmd([[
  augroup TelescopeColorOverrides
    autocmd!
    autocmd ColorScheme * highlight TelescopePromptBorder  guifg=#282828
    autocmd ColorScheme * highlight TelescopeResultsBorder guifg=#282828
    autocmd ColorScheme * highlight TelescopePreviewBorder guifg=#282828
  augroup end
]])
