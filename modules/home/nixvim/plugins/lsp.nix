{
  programs.nixvim.lsp.keymaps = [
    {
      key = "<space>p";
      action.__raw = "function() vim.diagnostic.jump({ count=-1, float=true }) end";
    }
    {
      key = "<space>n";
      action.__raw = "function() vim.diagnostic.jump({ count=1, float=true }) end";
    }
  ];

  programs.nixvim.plugins = {
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
    };

    lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          gD = "references";
          gd = "definition";
          gh = "hover";
          gi = "implementation";
          gt = "type_definition";
          "<space>." = "code_action";
          "<space>fo" = "format";
          "<space>r" = "rename";
        };
        extra = [
          {
            key = "gi";
            action = "<CMD>Telescope diagnostics<CR>";
          }
          {
            key = "gr";
            action = "<CMD>Telescope lsp_references<CR>";
          }
        ];
      };
      servers = {
        # graphql.enable = true;
        ansiblels.enable = true;
        bashls.enable = true;
        cssls.enable = true;
        diagnosticls.enable = true;
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        html.enable = true;
        jsonls.enable = true;
        just.enable = true;
        lua_ls = {
          enable = true;
          settings = {
            diagnostics.globals = [ "vim" ];
            workspace.checkThirdParty = false;
            telemetry.enabled = false;
          };
        };
        nil_ls.enable = true;
        tailwindcss.enable = true;
        terraformls.enable = true;
        ts_ls.enable = true;
        yamlls.enable = true;
      };
    };
  };
}
