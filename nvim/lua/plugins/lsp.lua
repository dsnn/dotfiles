-- Language Server Protocol setup
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps for LSP
      local function on_attach(client, bufnr)
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

      -- Diagnostic keymaps (global)
      vim.keymap.set("n", "<space>n", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, { silent = true })
      vim.keymap.set("n", "<space>p", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, { silent = true })

      -- Essential language servers (add/remove as needed)
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enabled = false },
            },
          },
        },
        ts_ls = {},
        bashls = {},
        cssls = {},
        html = {},
        jsonls = {},
        yamlls = {},
        -- Uncomment as needed:
        -- tailwindcss = {},
        -- dockerls = {},
        -- eslint = {},
      }

      -- Setup each server
      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, config))
      end

      -- Diagnostic styling
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

  -- Dev environment for Lua (improves completion for nvim API)
  {
    "folke/neodev.nvim",
    lazy = true,
  },

  -- Format on save (optional, currently disabled by default)
  {
    "lukas-reineke/lsp-format.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp-format").setup({})
    end,
    enabled = false,
  },

  -- Trouble - better diagnostics UI
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<space>t", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics" },
      { "<space>c", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
    config = function()
      require("trouble").setup({
        modes = {
          lsp = {
            win = { position = "right" },
          },
        },
      })
    end,
  },
}
