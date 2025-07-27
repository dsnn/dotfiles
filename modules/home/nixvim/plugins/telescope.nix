{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      extensions = {
        file-browser = {
          enable = true;
        };
        fzf-native = {
          enable = true;
        };
      };
      settings = {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "bottom";
            };
          };
          sorting_strategy = "descending";
        };
      };
      keymaps = {
        "<Leader><space>" = {
          action = "buffers";
          options = {
            desc = "Show buffers";
          };
        };
        "<space>gb" = {
          action = "git_branches";
          options = {
            desc = "Show git branches";
          };
        };
        "<space>gc" = {
          action = "git_bcommits";
          options = {
            desc = "Show buffer git commits";
          };
        };
        "<space>gf" = {
          action = "git_files";
          options = {
            desc = "Show git files";
          };
        };
        "<space>gs" = {
          action = "git_status";
          options = {
            desc = "Show git status";
          };
        };
        "<space>sa" = {
          action = "find_files";
          options = {
            desc = "Find files";
          };
        };
        "<space>sc" = {
          action = "colorscheme";
          options = {
            desc = "Select colorscheme";
          };
        };
        "<space>sd" = {
          action = "find_files";
          options = {
            desc = "Find dotfiles";
          };
        };
        "<space>sf" = {
          action = "live_grep";
          options = {
            desc = "Grep current word";
          };
        };
        "<space>sg" = {
          action = "live_grep";
          options = {
            desc = "Live grep";
          };
        };
        "<space>sh" = {
          action = "help_tags";
          options = {
            desc = "Show help tags";
          };
        };
        "<space>sk" = {
          action = "keymaps";
          options = {
            desc = "Show keymaps";
          };
        };
        "<space>sl" = {
          action = "resume";
          options = {
            desc = "Resume last search";
          };
        };
        "<space>sq" = {
          action = "quickfix";
          options = {
            desc = "Show quickfix";
          };
        };
        "<space>sr" = {
          action = "oldfiles";
          options = {
            desc = "Show recently opened files";
          };
        };
      };
    };
  };
}
