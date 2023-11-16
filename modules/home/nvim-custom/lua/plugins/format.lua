return {
  "mhartington/formatter.nvim",
  config = function()
    require('formatter').setup({
      filetype = {
        javascript = {
          -- prettier
          function()
            return {
              exe = "prettier",
              args = {
                "--config-precedence",
                "prefer-file",
                "--stdin-filepath",
                vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
              },
              stdin = true
            }
          end
        },
        nix = {
          function()
            return {
              exe = "nixfmt",
              args = {
                vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
              },
              stdin = false
            }
          end
        }
      }
    })
  end
}
