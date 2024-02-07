vim.g.mapleader = ","
vim.g.maplocalleader = " "

require("user.globals")
require("user.options")
require("user.mappings")
require("user.autocommands")
require("user.cmp")
require("user.colorscheme")
require("user.copilot")
require("user.diffview")
require("user.formatters")
-- require("user.linters")
require("user.lspconfig")
require("user.mini")
require("user.neotree")
require("user.telescope")
require("user.treesitter")
require("user.trouble")
require("user.persistence")

-- return {
--   "mhinz/vim-startify",
--   "tpope/vim-repeat",
--   "tpope/vim-surround",
-- }
