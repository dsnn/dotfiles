{
  flake.modules.homeManager.shell =
    { inputs, ... }:
    {
      home.packages = [
        inputs.myflakes.packages."aarch64-darwin".neovim
      ];

      programs.zsh.initContent = ''
        # ---------------------- #
        #        neovim          #
        # ---------------------- #

        # ctrl + n to open nvim 
        function run_nvim() {
          BUFFER="nvim && clear"
          zle accept-line
        }
        zle -N run_nvim
        bindkey "^n" run_nvim
      '';
    };
}
