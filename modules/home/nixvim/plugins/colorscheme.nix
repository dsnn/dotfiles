{
  programs.nixvim.colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        background = {
          light = "latte";
          dark = "mocha";
        };
        flavour = "mocha";
        no_bold = false;
        no_italic = false;
        no_underline = false;
        transparent_background = true;
        integrations = {
          cmp = true;
          neotree = true;
          treesitter = true;
          telescope.enabled = true;
        };
      };
    };
  };
}
