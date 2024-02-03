local silent = { silent = true }
local silent_no = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>q", ":lua MiniBufremove.delete()<CR>", silent_no)
vim.keymap.set("n", "<Leader>w", ":q<CR>", silent_no)
vim.keymap.set("n", "<Leader>.", "<C-^>", silent_no)
vim.keymap.set("n", "<Leader>,", ":wall<CR>", silent_no)
vim.keymap.set("n", "<C-s>", ":wall<CR>", silent_no)
vim.keymap.set("n", "<Leader>h", ":set hlsearch!<CR>", silent_no)
vim.keymap.set("n", "<Leader>x", ":luafile %<CR>", silent_no)
vim.keymap.set("n", "<Leader>m", ":Messages<CR>", silent_no)
vim.keymap.set("n", "<esc>", ":noh<cr>", silent_no)

-- do not replace yank on multiple paste
vim.keymap.set("x", "p", "pgvy", silent_no)

-- line indentation
vim.keymap.set("v", "<", "<gv", silent_no)
vim.keymap.set("v", ">", ">gv", silent_no)

-- visual search
-- vim.keymap.set('v', '<m-/>', '<esc>/\\%V'
vim.keymap.set("x", "/", "<Esc>/\\%V")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", silent)
vim.keymap.set("n", "<C-j>", "<C-w>j", silent)
vim.keymap.set("n", "<C-k>", "<C-w>k", silent)
vim.keymap.set("n", "<C-l>", "<C-w>l", silent)

vim.keymap.set("n", "n", "nzz", silent_no)
vim.keymap.set("n", "N", "Nzz", silent_no)
vim.keymap.set("n", "*", "*zz", silent_no)
vim.keymap.set("n", "#", "#zz", silent_no)
vim.keymap.set("n", "g*", "g*zz", silent_no)
vim.keymap.set("n", "g#", "g#zz", silent_no)

-- window resizing
vim.keymap.set("n", "<Up>", ":resize -2<CR>", silent_no)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", silent_no)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", silent_no)
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", silent_no)

-- buffer navigation
vim.keymap.set("n", "<TAB>", ":bnext<CR>", silent_no)
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", silent_no)

-- buffer split
vim.keymap.set("n", "vv", "<C-w>v", silent_no)
vim.keymap.set("n", "ss", "<C-w>s", silent_no)

-- file tree nav
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", silent_no)
vim.keymap.set("n", "<Leader>k", ":Neotree reveal_file=%<CR>", silent_no)

-- snippets
vim.keymap.set("n", "<Leader>s", '<cmd>:lua require("luasnip.loaders").edit_snippet_files()<CR>', silent_no)

-- bookmarks
vim.keymap.set("n", "<space>a", "<cmd>:lua require('harpoon.mark').add_file()<CR>", silent_no)
vim.keymap.set("n", "<space>h", "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", silent_no)
vim.keymap.set("n", "<space>1", "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", silent_no)
vim.keymap.set("n", "<space>2", "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", silent_no)
vim.keymap.set("n", "<space>3", "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", silent_no)
vim.keymap.set("n", "<space>4", "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", silent_no)

-- lsp trouble
vim.keymap.set("n", "<space>t", ":TroubleToggle<CR>", silent_no)

-- diffview
vim.keymap.set("n", "<space>do", ":DiffviewOpen<CR>", silent_no)
vim.keymap.set("n", "<space>dc", ":DiffviewClose<CR>", silent_no)

-- git
vim.keymap.set("n", "<space>g", ":Git<CR>", silent_no)

-- console.log
vim.keymap.set(
  "n",
  "<space>l",
  "<cmd> :put! =printf('console.log(''%s:'',  %s);', expand('<cword>'), expand('<cword>'))<CR>-2==+",
  silent_no
)

-- remove whitespace manually
vim.cmd([[ nnoremap <leader>c :%s/\s\+$//<CR> ]])
