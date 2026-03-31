{
  flake.modules.homeManager.lazygit =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [ lazygit ];

      programs.lazygit = {
        enable = true;
        settings = {
          # Catppuccin mocha
          gui.theme = {
            lightTheme = false; # mocha is dark

            activeBorderColor = [
              "#89b4fa"
              "bold"
            ];
            inactiveBorderColor = [ "#a6adc8" ];
            optionsTextColor = [ "#89b4fa" ];
            selectedLineBgColor = [ "#313244" ];
            cherryPickedCommitBgColor = [ "#45475a" ];
            cherryPickedCommitFgColor = [ "#89b4fa" ];
            unstagedChangesColor = [ "#f38ba8" ];
            defaultFgColor = [ "#cdd6f4" ];
            searchingActiveBorderColor = [ "#f9e2af" ];
          };
          git = {
            paging = {
              colorArg = "always";
              pager = "delta --color-only --dark --paging=never";
              useConfig = false;
            };
          };
        };
      };

      programs.zsh.initContent = ''
        # ---------------------- #
        #        lazygit         #
        # ---------------------- #

        function run_lazy_git() {
          BUFFER="lazygit && clear"
          zle accept-line
        }
        zle -N run_lazy_git
        bindkey "^g" run_lazy_git
      '';
    };
}
