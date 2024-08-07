-- https://github.com/folke/persistence.nvim

require("persistence").setup({
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
  options = { "buffers", "curdir", "tabpages", "winsize" },
  pre_save = nil,
  save_empty = false,
})

vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
