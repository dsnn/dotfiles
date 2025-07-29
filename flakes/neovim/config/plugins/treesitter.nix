{
  plugins = {
    mini-ai.enable = true;
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          disable = [
            "latex"
            "markdown"
          ];
        };
        auto_install = true;
        indent_enable = true;
        folding = true;
        autoLoad = true;
        incremental_selection.enable = true;
      };
    };
    treesitter-textobjects = {
      enable = true;
      # select = {
      #   enable = true;
      #   lookahead = true;
      #   keymaps = {
      #     af = "@function.outer";
      #     if = "@function.inner";
      #     ac = "@class.outer";
      #     ic = "@class.inner";
      #     ab = "@block.outer";
      #     ib = "@block.inner";
      #     aa = "@parameter.outer";
      #     ia = "@parameter.inner";
      #   };
      # };
      # swap = {
      #   enable = true;
      #   swap_next = {
      #     ["psn"] = "@parameter.inner";
      #   };
      #   swap_previous = {
      #     ["psp"] = "@parameter.inner";
      #   };
      # };
    };
    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 4;
        min_window_height = 40;
      };
    };
    # tpope's indent fixes
    sleuth.enable = true;
  };
}
