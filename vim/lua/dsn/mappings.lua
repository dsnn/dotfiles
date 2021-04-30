local silent = { silent = true }
local silent_no = { noremap = true, silent = true }

-- general
vim.g.mapleader = ','

vim.api.nvim_set_keymap('n', '<Leader>q', ':BufferClose<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader>.', '<C-^>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader>,', ':wall<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':set hlsearch!<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<Leader>x', '<cmd>:luafile %<CR>', silent_no)

-- noremap <C-A> ^
-- noremap <C-E> $
-- noremap <C-Q> %

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

-- window resizing
vim.api.nvim_set_keymap('n', '<M-j>',  ':resize -2<CR>',          silent_no)
vim.api.nvim_set_keymap('n', '<M-k>',  ':resize +2<CR>',          silent_no)
vim.api.nvim_set_keymap('n', '<M-h>',  ':vertical resize -2<CR>', silent_no)
vim.api.nvim_set_keymap('n', '<M-l>',  ':vertical resize +2<CR>', silent_no)

-- terminal navigation
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

-- telescope
-- vim.api.nvim_set_keymap('n', '<space>f',  "<cmd>:lua require('dsn.telescope').find_files()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>gs', "<cmd>:lua require('dsn.telescope').grep_prompt()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>gw', "<cmd>:lua require('dsn.telescope').grep_word()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fh', "<cmd>:lua require('dsn.telescope').help_tags()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fd', "<cmd>:lua require('dsn.telescope').dotfiles()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fe', "<cmd>:lua require('dsn.telescope').file_browser()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>gb', "<cmd>:lua require('dsn.telescope').git_branches()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fb', "<cmd>:lua require('dsn.telescope').buffers()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fa', "<cmd>:lua require('dsn.telescope').find_files()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fc', "<cmd>:lua require('dsn.telescope').colorscheme()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fr', "<cmd>:lua require('dsn.telescope').registers()<CR>", silent_no)
vim.api.nvim_set_keymap('n', '<space>fq', "<cmd>:lua require('dsn.telescope').quickfix()<CR>", silent_no)

-- comments
require('nvim_comment').setup()

-- limelight
vim.api.nvim_set_keymap('n', '<leader>l', ":Limelight!!<CR>", silent_no)

-- colorizer
require("colorizer").setup()
-- :ColorizerToggle
