-- when running at every change you may want to disable quickfix
-- vim.cmd('let g:prettier#quickfix_enabled = 0')
-- vim.cmd('let g:prettier#autoformat = 0')

-- vim.api.nvim_exec([[
--   autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.yml PrettierAsync
-- ]])
