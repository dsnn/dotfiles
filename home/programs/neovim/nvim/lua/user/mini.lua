-- https://github.com/echasnovski/mini.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring

require("ts_context_commentstring").setup({
  enable_autocmd = false,
})

require("mini.bufremove").setup()

require("mini.comment").setup({
  options = {
    -- custom_commentstring = nil,
    custom_commentstring = function()
      return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
    end,
    ignore_blank_line = false,
    start_of_line = false,
    pad_comment_parts = true,
  },
  mappings = {
    comment = "gc",
    comment_line = "gcc",
    comment_visual = "gc",
    textobject = "gc",
  },
  hooks = {
    pre = function() end,
    post = function() end,
  },
})

require("mini.surround").setup({
  custom_surroundings = nil,
  highlight_duration = 500,
  mappings = {
    add = "sa",
    delete = "sd",
    replace = "sr",

    suffix_last = "l",
    suffix_next = "n",
  },
  n_lines = 20,
  respect_selection_type = false,
  search_method = "cover",
  silent = false,
})
