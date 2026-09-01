-- Neovim keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ===== CODE MOVEMENT =====
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-1<CR>gv=gv", opts)

-- ===== UNDO/REDO =====
map("n", "U", "<C-r>", opts)

-- ===== WINDOW RESIZING =====
map("n", "<Up>", ":resize -2<CR>", opts)
map("n", "<Down>", ":resize +2<CR>", opts)
map("n", "<Right>", ":vertical resize -2<CR>", opts)
map("n", "<Left>", ":vertical resize +2<CR>", opts)

-- ===== BUFFER NAVIGATION =====
map("n", "<TAB>", ":bnext<CR>", opts)
map("n", "<S-TAB>", ":bprevious<CR>", opts)

-- ===== BUFFER SPLIT =====
map("n", "vv", "<C-w>v", opts)
map("n", "ss", "<C-w>s", opts)

-- ===== BUFFER AND QUIT COMMANDS =====
map("n", "<leader>q", ":lua MiniBufremove.delete()<CR>", opts)
map("n", "<leader>w", ":q<CR>", opts)
map("n", "<space>qq", ":qa!<CR>", opts)
map("n", "<leader>.", "<C-^>", opts)
map("n", "<leader>,", ":wall<CR>", opts)
map("n", "<C-s>", ":wall<CR>", opts)

-- ===== SEARCH BEHAVIOR =====
map("n", "<leader>h", ":set hlsearch!<CR>", opts)
map("n", "<leader>x", ":luafile %<CR>", opts)
map("n", "<leader>m", ":messages<CR>", opts)
map("n", "<esc>", ":noh<CR>", opts)

-- ===== YANK BEHAVIOR =====
map("x", "p", "pgvy", opts)

-- ===== LINE INDENTATION =====
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- ===== VISUAL SEARCH =====
map("x", "/", "<Esc>/\\%V", opts)

-- ===== WINDOW NAVIGATION =====
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- ===== SEARCH CENTER =====
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)
map("n", "#", "#zz", opts)
map("n", "g*", "g*zz", opts)
map("n", "g#", "g#zz", opts)

-- ===== LINE START/END =====
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)
