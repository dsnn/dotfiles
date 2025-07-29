{
  keymaps = [
    {
      action = ":Neotree toggle<CR>";
      key = "<C-n>";
      mode = "n";
      options = {
        silent = true;
      };
    }
    {
      action = ":Neotree reveal_file=%<CR>";
      key = "<Leader>k";
      mode = "n";
      options = {
        silent = true;
      };
    }
  ];

  plugins = {
    neo-tree = {
      enable = true;
      eventHandlers = {
        neo_tree_buffer_enter = ''
          function(arg)
            vim.cmd([[ setlocal relativenumber ]])
          end'';
      };
      filesystem = {
        followCurrentFile = {
          enabled = true;
          leaveDirsOpen = true;
        };
        filteredItems = {
          hideDotfiles = false;
          hideGitignored = false;
          hideHidden = false;
          hideByName = [ ];
          hideByPattern = [ ];
          alwaysShow = [ ];
          neverShow = [ ];
          neverShowByPattern = [ ];
        };
      };
      window = {
        mappings = {
          "<space>" = {
            command = "toggle_node";
            nowait = false;
          };
          "<2-LeftMouse>" = "open";
          "<cr>" = "open";
          "<esc>" = "revert_preview";
          P = {
            command = "toggle_preview";
            config = {
              use_float = true;
            };
          };
          l = "focus_preview";
          S = "open_split";
          s = "open_vsplit";
          t = "open_tabnew";
          w = "open_with_window_picker";
          C = "close_node";
          z = "close_all_nodes";
          Z = "expand_all_nodes";
          R = "refresh";
          a = {
            command = "add";
            config = {
              show_path = "relative";
            };
          };
          A = "add_directory";
          d = "delete";
          r = "rename";
          y = "copy_to_clipboard";
          x = "cut_to_clipboard";
          p = "paste_from_clipboard";
          c = "copy";
          m = "move";
          e = "toggle_auto_expand_width";
          q = "close_window";
          "?" = "show_help";
          "<" = "prev_source";
          ">" = "next_source";
          # ["te"] = "telescope_find",
          # ["ts"] = "telescope_grep",
          # h = ''
          #   function(state)
          #     local node = state.tree:get_node()
          #     if node.type == "directory" and node:is_expanded() then
          #       require("neo-tree.sources.filesystem").toggle_directory(state, node)
          #     else
          #       require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          #     end
          #   end,
          # '';
          # l = ''
          #   function(state)
          #     local node = state.tree:get_node()
          #     if node.type == "directory" then
          #       if not node:is_expanded() then
          #         require("neo-tree.sources.filesystem").toggle_directory(state, node)
          #       elseif node:has_children() then
          #         require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          #       end
          #     end
          #   end'';
        };
      };
    };
  };
}

# telescope_find = function(state)
#   local node = state.tree:get_node()
#   local path = node:get_id()
#   require("telescope.builtin").find_files(getTelescopeOpts(state, path))
# end,
# telescope_grep = function(state)
#   local node = state.tree:get_node()
#   local path = node:get_id()
#   require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
# end,
