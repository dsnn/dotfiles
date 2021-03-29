local map_options = { noremap = true, silent = true }

-- general
vim.g.mapleader = ','

vim.api.nvim_set_keymap('n', ',,', ':w<CR>', map_options)
vim.api.nvim_set_keymap('n', ',q', ':q<CR>', map_options)
vim.api.nvim_set_keymap('n', ',w', ':Bdelete<CR>', map_options)
vim.api.nvim_set_keymap('n', '<Leader>.', '<C-^>', map_options)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':set hlsearch!<CR>', map_options)
--vim.api.nvim_set_keymap('n', '<leader>c', ":%s/\s\+$//e<CR>", map_options)

-- nvim tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', map_options)
vim.api.nvim_set_keymap('n', '<Leader>k', ':NvimTreeFindFile<CR>', map_options)

-- line indentation
vim.api.nvim_set_keymap('v', '<', '<gv', map_options)
vim.api.nvim_set_keymap('v', '>', '>gv', map_options)

-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- lsp & completion
require('dsn.compe')
require('dsn.lsp')

-- terminal
vim.api.nvim_set_keymap('n', '<leader>t',  ':FloatermToggle<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>tg', ':FloatermNew --name=git --autoclose=2 lazygit<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>td', ':FloatermNew --name=docker --autoclose=2 lazydocker<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>tn', ':FloatermNew --name=npm --autoclose=2 lazynpm<CR>', {silent = true})

vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
]])

-- buffer navigation
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', map_options)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', map_options)

-- window resizing
vim.api.nvim_set_keymap('n', '<C-Up>',    ':resize -2<CR>',          {silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>',  ':resize +2<CR>',          {silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>',  ':vertical resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true})

-- telescope
require('dsn.telescope')
require('dsn.telescope.pickers')
local h = require('dsn.telescope.helpers')
h.set_tele_keymap('<leader>fd', 'edit_dotfiles')
h.set_tele_keymap('<leader>gb', 'git_branches')
h.set_tele_keymap('<leader>fb', 'buffers')
h.set_tele_keymap('<leader>fh', 'help_tags')
h.set_tele_keymap('<leader>fa', 'search_all_files')
h.set_tele_keymap('<leader>f', 'search_all_files')
h.set_tele_keymap('<leader>fc', 'colorscheme')
h.set_tele_keymap('<leader>fr', 'registers')
h.set_tele_keymap('<leader>fq', 'quickfix')

-- luadev

vim.api.nvim_set_keymap('n', '<leader>ll',  ':Luadev-RunLine', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ls',  ':Luadev-Run', {silent = true})
