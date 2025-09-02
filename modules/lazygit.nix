{
  flake.modules.homeManager.lazygit =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [ lazygit ];

      programs.lazygit = {
        enable = true;
        settings = {
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
