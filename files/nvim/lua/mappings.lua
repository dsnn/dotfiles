local silent = { silent = true }
local silent_no = { noremap = true, silent = true }
local map = vim.keymap.set;

map('n', '<Leader>q', ':Bdelete<CR>', silent_no)
map('n', '<Leader>.', '<C-^>', silent_no)
map('n', '<Leader>,', ':wall<CR>', silent_no)
map('n', '<Leader>h', ':set hlsearch!<CR>', silent_no)
map('n', '<Leader>x', ':luafile %<CR>', silent_no)
map('n', '<Leader>t', ':e ~/work/TODO.md<CR>', silent_no)
map('n', '<Leader>m', ':Messages<CR>', silent_no)

-- do not replace yank on multiple paste
map('x', 'p', 'pgvy', silent_no)

-- line indentation
map('v', '<', '<gv', silent_no)
map('v', '>', '>gv', silent_no)

-- visual search
-- vim.keymap.set('v', '<m-/>', '<esc>/\\%V'
vim.keymap.set('x', '/', '<Esc>/\\%V')

-- window navigation
map('n', '<C-h>', '<C-w>h', silent)
map('n', '<C-j>', '<C-w>j', silent)
map('n', '<C-k>', '<C-w>k', silent)
map('n', '<C-l>', '<C-w>l', silent)

-- window resizing
map('n', '<Up>', ':resize -2<CR>', silent_no)
map('n', '<Down>', ':resize +2<CR>', silent_no)
map('n', '<Right>', ':vertical resize -2<CR>', silent_no)
map('n', '<Left>', ':vertical resize +2<CR>', silent_no)

-- buffer navigation
map('n', '<TAB>', ':bnext<CR>', silent_no)
map('n', '<S-TAB>', ':bprevious<CR>', silent_no)

-- buffer split
map('n', 'vv', '<C-w>v', silent_no)
map('n', 'ss', '<C-w>s', silent_no)

-- file tree nav 
map('n', '<C-n>', ':Neotree toggle<CR>', silent_no)
map('n', '<Leader>k', ':Neotree reveal_file=%<CR>', silent_no)
-- map('n', '<Leader>f', ":lua require('lir.float').toggle()<CR>", silent_no)

-- snippets
map('n', '<Leader>s', '<cmd>:lua require("luasnip.loaders").edit_snippet_files()<CR>', silent_no)

-- vimux
map('n', '<leader>r', ":VimuxPromptCommand<CR>", silent_no)
map('n', '<leader>e', ":VimuxRunLastCommand<CR>", silent_no)

-- bookmarks 
map('n', '<space>a', "<cmd>:lua require('harpoon.mark').add_file()<CR>", silent_no)
map('n', '<space>h', "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", silent_no)
map('n', '<space>1', "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", silent_no)
map('n', '<space>2', "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", silent_no)
map('n', '<space>3', "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", silent_no)
map('n', '<space>4', "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", silent_no)

-- lsp trouble
map('n', '<leader>lt', ":TroubleToggle<CR>", silent_no)

-- console.log
map('n', '<space>l', "<cmd> :put! =printf('console.log(''%s:'',  %s);', expand('<cword>'), expand('<cword>'))<CR>-2==+", silent_no)

-- remove whitespace manually
vim.cmd([[ nnoremap <leader>c :%s/\s\+$//<CR> ]])
