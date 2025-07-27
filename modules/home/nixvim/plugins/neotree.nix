{
  programs.nixvim.keymaps = [
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

  programs.nixvim.plugins = {
    neo-tree = {
      enable = true;
      eventHandlers = {
        neo_tree_buffer_enter = ''
          function(arg)
            vim.cmd([[ setlocal relativenumber ]])
          end'';
      };
    };
  };
}
