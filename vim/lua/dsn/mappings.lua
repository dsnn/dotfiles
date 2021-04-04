local silent = { silent = true }
local silent_no = { noremap = true, silent = true }

-- general
vim.g.mapleader = ','

vim.api.nvim_set_keymap('n', ',,', ':w<CR>', silent_no)
vim.api.nvim_set_keymap('n', ',q', ':q<CR>', silent_no)
vim.api.nvim_set_keymap('n', ',w', ':Bdelete<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader>.', '<C-^>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':set hlsearch!<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader>x', '<cmd>:luafile %<CR>', silent_no)

-- remove whitespace manually
vim.cmd([[ nnoremap <leader>c :%s/\s\+$//<CR> ]])

-- nvim tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader>k', ':NvimTreeFindFile<CR>', silent_no)

-- line indentation
vim.api.nvim_set_keymap('v', '<', '<gv', silent_no)
vim.api.nvim_set_keymap('v', '>', '>gv', silent_no)

-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', silent)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', silent)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', silent)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', silent)

-- lsp & completion
require('dsn.compe')
require('dsn.lsp')

vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc><Esc> <C-\><C-n>
]])

-- buffer navigation
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', silent_no)

-- window resizing
vim.api.nvim_set_keymap('n', '<C-Up>',    ':resize -2<CR>',          {silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>',  ':resize +2<CR>',          {silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>',  ':vertical resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true})

-- telescope
vim.api.nvim_set_keymap('n', '<leader>f',  "<cmd>:lua require('dsn.telescope').find_files()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>:lua require('dsn.telescope').grep_prompt()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>gw', "<cmd>:lua require('dsn.telescope').grep_word()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>:lua require('dsn.telescope').help_tags()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fd', "<cmd>:lua require('dsn.telescope').dotfiles()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fe', "<cmd>:lua require('dsn.telescope').file_browser()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>gb', "<cmd>:lua require('dsn.telescope').git_branches()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>:lua require('dsn.telescope').buffers()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fa', "<cmd>:lua require('dsn.telescope').find_files()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fc', "<cmd>:lua require('dsn.telescope').colorscheme()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fr', "<cmd>:lua require('dsn.telescope').registers()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<leader>fq', "<cmd>:lua require('dsn.telescope').quickfix()<CR>", silent_no)

-- luadev
vim.api.nvim_set_keymap('n', '<leader>ll',  ':Luadev-RunLine', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ls',  ':Luadev-Run', {silent = true})

-- comments
require('nvim_comment').setup()
