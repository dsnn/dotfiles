-- Neovim configuration
-- Main entry point

-- Setup leaders before lazy.nvim
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocommands")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to install lazy.nvim:\n" .. output)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins with lazy.nvim
require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
})
