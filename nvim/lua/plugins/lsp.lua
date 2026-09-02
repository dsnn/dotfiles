-- Language Server Protocol setup
local servers = {
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  "ts_ls",
  "yamlls",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
      },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function set_lsp_keymaps(bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gD", vim.lsp.buf.references, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "gh", vim.lsp.buf.hover, opts)
        map("n", "gt", vim.lsp.buf.type_definition, opts)
        map("n", "<space>r", vim.lsp.buf.rename, opts)
        map("n", "<space>.", vim.lsp.buf.code_action, opts)
        map("n", "<space>fo", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      local group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
          set_lsp_keymaps(args.buf)
        end,
      })

      vim.keymap.set("n", "<space>n", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, { silent = true, desc = "Next diagnostic" })
      vim.keymap.set("n", "<space>p", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, { silent = true, desc = "Previous diagnostic" })

      vim.lsp.config("*", {
        capabilities = capabilities,
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enabled = false },
          },
        },
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = servers,
      })

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<space>t", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics" },
      { "<space>c", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
  },
}
