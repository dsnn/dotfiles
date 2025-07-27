{
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "catppuccin";
        };
        globalstatus = true;
        extensions = [
          "fzf"
          "neo-tree"
        ];
        disabled_filetypes = {
          statusline = [
            "startup"
            "alpha"
          ];
        };
      };
    };
  };
}
