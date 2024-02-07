local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>q", ":lua MiniBufremove.delete()<CR>", opts)
vim.keymap.set("n", "<leader>w", ":q<CR>", opts)
vim.keymap.set("n", "<space>qq", ":qa!<CR>", opts)
vim.keymap.set("n", "<leader>.", "<C-^>", opts)
vim.keymap.set("n", "<leader>,", ":wall<CR>", opts)
vim.keymap.set("n", "<C-s>", ":wall<CR>", opts)
vim.keymap.set("n", "<leader>h", ":set hlsearch!<CR>", opts)
vim.keymap.set("n", "<leader>x", ":luafile %<CR>", opts)
vim.keymap.set("n", "<leader>m", ":messages<CR>", opts)
vim.keymap.set("n", "<esc>", ":noh<cr>", opts)

-- do not replace yank on multiple paste
vim.keymap.set("x", "p", "pgvy", opts)

-- line indentation
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- visual search
-- vim.keymap.set('v', '<m-/>', '<esc>/\\%V'
vim.keymap.set("x", "/", "<Esc>/\\%V")

-- navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)

-- start / end of line
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "L", "$", opts)
vim.keymap.set("v", "H", "^", opts)
vim.keymap.set("v", "L", "$", opts)

-- move code
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-1<CR>gv=gv", opts)

-- redo
vim.keymap.set("n", "U", "<C-r>", opts)

-- window resizing
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)

-- buffer navigation
vim.keymap.set("n", "<TAB>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", opts)

-- buffer split
vim.keymap.set("n", "vv", "<C-w>v", opts)
vim.keymap.set("n", "ss", "<C-w>s", opts)

-- bookmarks
vim.keymap.set("n", "<space>a", "<cmd>:lua require('harpoon.mark').add_file()<CR>", opts)
vim.keymap.set("n", "<space>h", "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
vim.keymap.set("n", "<space>1", "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", opts)
vim.keymap.set("n", "<space>2", "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", opts)
vim.keymap.set("n", "<space>3", "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", opts)
vim.keymap.set("n", "<space>4", "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", opts)

-- diffview
vim.keymap.set("n", "<space>do", ":DiffviewOpen<CR>", opts)
vim.keymap.set("n", "<space>dc", ":DiffviewClose<CR>", opts)

-- console.log
vim.keymap.set(
  "n",
  "<space>l",
  "<cmd> :put! =printf('console.log(''%s:'',  %s);', expand('<cword>'), expand('<cword>'))<CR>-2==+",
  opts
)

-- remove whitespace manually
vim.cmd([[ nnoremap <leader>c :%s/\s\+$//<CR> ]])
