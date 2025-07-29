{
  plugins = {
    lint = {
      enable = false;
      lintersByFt = {
        # terraform = [ "tflint" ];
        # dockerfile = [ "hadolint" ];
        jsonc = [ "jsonlint" ];
        json = [ "jsonlint" ];
        markdown = [
          "vale"
          "markdownlint"
          "proselint"
        ];
        text = [ "vale" ];
        yaml = [
          "yamllint"
          "ansible_lint"
        ];
        javascript = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        javascriptreact = [ "eslint_d" ];
        typescriptreact = [ "eslint_d" ];
        sh = [ "shellcheck" ];
        nix = [ "statix" ];
        gitcommit = [ "commitlint" ];
        css = [ "stylelint" ];
      };
    };
  };
}
