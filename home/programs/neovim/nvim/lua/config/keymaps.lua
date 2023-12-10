-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })

vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-Space>", "<Cmd>TmuxNavigatePrevious<CR>", { silent = true })

vim.keymap.set("n", ",q", "<Cmd>bd<CR>", { silent = true, desc = "Close buffer" })
vim.keymap.set("n", ",.", "<c-^>", { silent = true, desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>.", "<c-^>", { silent = true, desc = "Go to previous buffer" })

vim.keymap.set("n", "<C-w>h", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-w>j", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-w>k", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-w>l", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
