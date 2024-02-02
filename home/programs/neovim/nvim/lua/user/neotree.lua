vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr)
      local actions = require "telescope.actions"
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require "telescope.actions.state"
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if (filename == nil) then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end
  }
end

-- local M = {
--   "nvim-neo-tree/neo-tree.nvim",
--   dependencies = {
--     "mrbjarksen/neo-tree-diagnostics.nvim",
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",
--     "MunifTanjim/nui.nvim",
--   },
--   tag = "3.16", 
-- }


require("plenary")
require("nvim-web-devicons")
require("nui.tree")

require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,

  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(arg)
        vim.cmd [[ setlocal relativenumber ]]
      end,
    }
  },

  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "",
        modified  = "",
        deleted   = "✖",
        renamed   = "➜",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "✓",
        conflict  = "",
      }
    },
  },

  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "diagnostics",
  },

  source_selector = {
    winbar = true,
    statusline = false,
  },

  diagnostics = {
    autopreview = false,
    autopreview_config = { use_float = true },
    autopreview_event = "neo_tree_buffer_enter",
    bind_to_cwd = true,
    diag_sort_function = "severity",
    group_dirs_and_files = true,
    group_empty_dirs = true,
    show_unloaded = true,
  },

  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<"] = "prev_source",
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel",
      ["<space>"] = { "toggle_node", nowait = false, },
      [">"] = "next_source",
      ["?"] = "show_help",
      ["A"] = "add_directory",
      ["C"] = "close_node",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["R"] = "refresh",
      ["S"] = "open_split",
      ["Z"] = "expand_all_nodes",
      ["a"] = { "add", config = { show_path = "relative" } },
      ["c"] = "copy",
      ["d"] = "delete",
      ["m"] = "move",
      ["p"] = "paste_from_clipboard",
      ["q"] = "close_window",
      ["r"] = "rename",
      ["s"] = "open_vsplit",
      ["te"] = "telescope_find",
      ["ts"] = "telescope_grep",
      ["w"] = "open_with_window_picker",
      ["x"] = "cut_to_clipboard",
      ["y"] = "copy_to_clipboard",
      ["z"] = "close_all_nodes",
      ["h"] = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' and node:is_expanded() then
          require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
        else
          require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
        end
      end,
      ["l"] = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' then
          if not node:is_expanded() then
            require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
          elseif node:has_children() then
            require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
          end
        end
      end,
    }
  },
  filesystem = {
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').find_files(getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
      end,
    },
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = {
        --".gitignored",
      },
      never_show = {
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = {
        --".null-ls_*",
      },
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = false,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["C-k"] = "prev_git_modified",
        ["C-j"] = "next_git_modified",
      }
    }
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      }
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"]  = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      }
    }
  }
  -- filesystem = {
  --   follow_current_file = true,
  --   hijack_netrw_behavior = "open_current",
  -- },
})
