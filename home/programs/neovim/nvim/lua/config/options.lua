-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.backup = false -- don't use backup files
vim.opt.writebackup = false -- don't backup the file while editing
vim.opt.swapfile = false -- don't create swap files for new buffers
vim.opt.updatecount = 0 -- don't write swap files after some number of updates
vim.opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
vim.opt.directory = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }

vim.cmd([[abbr funciton function]])
vim.cmd([[abbr teh the]])
vim.cmd([[abbr tempalte template]])
vim.cmd([[abbr fitler filter]])
vim.cmd([[abbr cosnt const]])
vim.cmd([[abbr attribtue attribute]])
vim.cmd([[abbr attribuet attribute]])
vim.cmd([[abbr flase false]])
