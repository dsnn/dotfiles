{ inputs, ... }: {

  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    globals.mapleader = ",";
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
    keymaps = [{
      mode = "n";
      key = "<leader>q";
      options.silent = true;
      action = ":bd<CR>";
    }];
    plugins = {
      lightline = { enable = true; };
      nvim-cmp = { enable = true; };
      gitsigns = { enable = true; };
      gitgutter = { enable = true; };
      trouble = { enable = true; };
      lsp = { enable = true; };
      oil = { enable = true; };
      tmux-navigator = { enable = true; };
      todo-comments = { enable = true; };
      toggleterm = { enable = true; };
      floaterm = { enable = true; };
      commentary = { enable = true; };
      noice = { enable = true; };
      telescope = { enable = true; };

      nvim-tree = {
        enable = true;
        disableNetrw = true;
        openOnSetup = true;
        diagnostics = { enable = true; };
        git = { enable = true; };
      };
    };
    colorschemes.catppuccin = {
      enable = true;
      # flavor.mocha = true;
    };
  };
}
