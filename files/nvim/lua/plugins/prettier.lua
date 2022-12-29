return {
  "prettier/vim-prettier",
  build = 'npm install',
  branch = 'master',
  config = function()
    -- when running at every change you may want to disable quickfix
    -- vim.cmd('let g:prettier#quickfix_enabled = 1')
    vim.cmd('let g:prettier#autoformat = 1')
    vim.cmd("let g:prettier#config#config_precedence = 'prefer-file'")
    -- vim.api.nvim_exec([[
    --   autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.yml PrettierAsync
    -- ]])
  end
}
