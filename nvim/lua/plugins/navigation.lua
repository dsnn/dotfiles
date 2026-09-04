-- Navigation: file finding, tree explorer, file browser, tmux integration
return {
  -- Fuzzy finder with native FZF
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader><space>", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<space>sa", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<space>sg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<space>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Search word" },
      { "<space>sW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Search WORD" },
      { "<space>sh", "<cmd>FzfLua helptags<cr>", desc = "Help tags" },
      { "<space>sk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<space>sl", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<space>sr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<space>sc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme" },
      { "<space>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
      { "<space>gc", "<cmd>FzfLua git_bcommits<cr>", desc = "Buffer commits" },
      { "<space>gf", "<cmd>FzfLua git_files<cr>", desc = "Git files" },
      { "<space>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<space>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix" },
      { "<space>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<space>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
    },
    config = function()
      require("fzf-lua").setup({
        "telescope",
        fzf_opts = { ["--layout"] = "reverse-list" },
        defaults = {
          cwd_prompt = false,
        },
      })
    end,
  },

  -- Neo-tree file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
      { "<leader>k", "<cmd>Neotree reveal_file=%<cr>", desc = "Show current file" },
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
        },
        window = {
          position = "left",
          width = 30,
          mappings = {
            ["<space>"] = "toggle_node",
            ["<cr>"] = "open",
            ["P"] = {
              "toggle_preview",
              config = { use_float = true },
            },
            ["l"] = "focus_preview",
            ["s"] = "open_vsplit",
            ["S"] = "open_split",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["z"] = "close_all_nodes",
            ["Z"] = "expand_all_nodes",
          },
        },
      })
    end,
  },

  -- Oil file browser
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "<space>o", "<cmd>Oil<cr>", desc = "Oil browser" },
    },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-r>"] = "actions.refresh",
          ["<leader>q"] = "actions.close",
        },
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },

  -- Seamless tmux/vim navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux navigate right" },
    },
  },
}
