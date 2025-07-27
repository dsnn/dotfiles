{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>:lua require(\"luasnip.loaders\").edit_snippet_files()<CR>";
      key = "<Leader>s";
      mode = "n";
      options = {
        silent = true;
      };
    }
  ];

  programs.nixvim.plugins = {
    lspkind = {
      enable = true;
      # symbolMap = {
      #   Copilot = " ";
      # };
      extraOptions = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };

    # luasnip = {
    #   enable = true;
    #   fromVscode = [ ];
    #   lazyLoad.enable = true;
    # };

    # cmp-vim-lsp.enable = true;
    # cmp_luasnip.enable = true;
    # cmp-buffer.enable = true;
    # cmp-path.enable = true;
    # cmp-cmdline.enable = false;

    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental.ghost_text = true;
        snippet.expand = "luasnip";

        window = {
          completion.border = "solid";
          documentation.border = "solid";
        };

        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };

        formatting.fields = [
          "kind"
          "abbr"
          "menu"
        ];

        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          { name = "luasnip"; }
          { name = "nvim_lua"; }
          {
            name = "path";
            keywordLength = 3;
          }
        ];

        mapping = {
          "<C-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
  };
}
