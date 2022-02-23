local silent = { silent = true }
local silent_no = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap;

-- general
vim.g.mapleader = ','

map('n', '<Leader>q', ':Bdelete<CR>', silent_no)
map('n', '<Leader>.', '<C-^>', silent_no)
map('n', '<Leader>,', ':wall<CR>', silent_no)
map('n', '<Leader><space>', ':set hlsearch!<CR>', silent_no)
map('n', '<Leader>x', '<cmd>luafile %<CR>', silent_no)

-- do not replace yank on multiple paste
map('x', 'p', 'pgvy', silent_no)

-- nvim tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', silent_no)
map('n', '<Leader>k', ':NvimTreeFindFile<CR>', silent_no)

-- line indentation
map('v', '<', '<gv', silent_no)
map('v', '>', '>gv', silent_no)

-- window navigation
map('n', '<C-h>', '<C-w>h', silent)
map('n', '<C-j>', '<C-w>j', silent)
map('n', '<C-k>', '<C-w>k', silent)
map('n', '<C-l>', '<C-w>l', silent)

-- window resizing
map('n', '<Up>',    ':resize -2<CR>',          silent_no)
map('n', '<Down>',  ':resize +2<CR>',          silent_no)
map('n', '<Right>', ':vertical resize -2<CR>', silent_no)
map('n', '<Left>',  ':vertical resize +2<CR>', silent_no)

-- buffer navigation
map('n', '<TAB>', ':bnext<CR>', silent_no)
map('n', '<S-TAB>', ':bprevious<CR>', silent_no)

-- buffer split
map('n', 'vv', '<C-w>v', silent_no)
map('n', 'ss', '<C-w>s', silent_no)

-- telescope
map('n', '<space>gp', "<cmd>:lua require('dsn.telescope').grep_prompt()<CR>", silent_no)
map('n', '<space>gs', "<cmd>:lua require('dsn.telescope').git_status()<CR>", silent_no)
map('n', '<space>gw', "<cmd>:lua require('dsn.telescope').grep_word()<CR>", silent_no)
map('n', '<space>fh', "<cmd>:lua require('dsn.telescope').help_tags()<CR>", silent_no)
map('n', '<space>fd', "<cmd>:lua require('dsn.telescope').dotfiles()<CR>", silent_no)
map('n', '<space>fe', "<cmd>:lua require('dsn.telescope').file_browser()<CR>", silent_no)
map('n', '<space>gb', "<cmd>:lua require('dsn.telescope').git_branches()<CR>", silent_no)
map('n', '<space>b', "<cmd>:lua require('dsn.telescope').buffers()<CR>", silent_no)
map('n', '<space>fa', "<cmd>:lua require('dsn.telescope').find_files()<CR>", silent_no)
map('n', '<space>fc', "<cmd>:lua require('dsn.telescope').colorscheme()<CR>", silent_no)
map('n', '<space>fr', "<cmd>:lua require('dsn.telescope').registers()<CR>", silent_no)
map('n', '<space>fq', "<cmd>:lua require('dsn.telescope').quickfix()<CR>", silent_no)
map('n', '<space>ff', "<cmd>:lua require('dsn.telescope').curbuf()<CR>", silent_no)

-- limelight
map('n', '<leader>ll', ":Limelight!!<CR>", silent_no)

-- colorizer
require("colorizer").setup()

-- lsp trouble
require("trouble").setup()
map('n', '<leader>lt', ":LspTroubleToggle<CR>", silent_no)

map('n', '<leader>uc', "<cmd>:lua require('ts_context_commentstring.internal').update_commentstring()<CR>", silent_no)

-- auto closetag
-- :CloseTagToggleBuffer in case of annoyance
vim.cmd("let g:closetag_filenames = '*.html,*.tsx'")

-- remove whitespace manually
vim.cmd([[ nnoremap <leader>c :%s/\s\+$//<CR> ]])

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

