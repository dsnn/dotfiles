{
  plugins = {
    conform-nvim = {
      enable = false;
      autoLoad = true;

      settings = {
        formatters_by_ft = {
          bash = [
            "shellcheck"
            # "shellharden"
            "shfmt"
          ];
          css = [
            "prettierd"
            "prettier"
          ];
          graphql = [
            "prettierd"
            "prettier"
          ];
          html = [
            "prettierd"
            "prettier"
          ];
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
          javascriptreact = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
          json = [
            "prettierd"
            "prettier"
          ];
          jsonc = [
            "prettierd"
            "prettier"
          ];
          less = [
            "prettierd"
            "prettier"
          ];
          lua = [ "stylua" ];
          markdown = [
            "prettierd"
            "prettier"
          ];
          scss = [
            "prettierd"
            "prettier"
          ];
          sh = [ "shfmt" ];
          typescript = [
            "prettierd"
            "prettier"
          ];
          typescriptreact = [
            "prettierd"
            "prettier"
          ];
          yaml = [
            "prettierd"
            "prettier"
          ];
          nix = [ "nixfmt" ];
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
        format_on_save = # Lua
          ''
            	  function(bufnr)
            	    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            	      return
            	    end

            	    if slow_format_filetypes[vim.bo[bufnr].filetype] then
            	      return
            	    end

            	    local function on_format(err)
            	      if err and err:match("timeout$") then
            		slow_format_filetypes[vim.bo[bufnr].filetype] = true
            	      end
            	    end

            	    return { timeout_ms = 200, lsp_fallback = true }, on_format
            	   end
            	'';
        format_after_save = # Lua
          ''
            	  function(bufnr)
            	    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            	      return
            	    end

            	    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            	      return
            	    end

            	    return { lsp_fallback = true }
            	  end
            	'';
        log_level = "warn";
        notify_on_error = false;
        notify_no_formatters = false;
      };
    };
  };
}
