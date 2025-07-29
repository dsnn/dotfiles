{
  keymaps = [
    {
      action = "<cmd>Trouble diagnostics toggle<cr>";
      key = "<space>t";
      mode = "n";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>Trouble qflist toggle<cr>";
      key = "<space>c";
      mode = "n";
      options = {
        silent = true;
      };
    }
  ];

  plugins.trouble.enable = true;
}
