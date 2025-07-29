{

  keymaps = [
    {
      mode = "n";
      key = "<space>o";
      action = ":Oil<CR>";
      options.desc = "Open Oil File Browser";
    }
  ];

  plugins = {
    oil = {
      enable = true;
      autoLoad = true;
      settings = {
        columns = [
          "icon"
        ];
        keymaps = {
          "<C-r>" = "actions.refresh";
          "<leader>q" = "actions.close";
        };
        skip_confirm_for_simple_edits = true;
        constrain_cursor = "editable";
        default_file_explorer = true;
        view_options = {
          show_hidden = true;
        };
        win_options = {
          concealcursor = "ncv";
          conceallevel = 3;
          cursorcolumn = false;
          foldcolumn = "0";
          list = false;
          signcolumn = "no";
          spell = false;
          wrap = false;
        };
      };
    };
  };
}
