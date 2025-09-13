{
  # perSystem =
  #   { inputs, system, ... }:
  #   {
  #     home.packages = [
  #       inputs.myflakes.packages.${system}.neovim
  #     ];
  #   };
  #
  flake.modules.homeManager.shell =
    { inputs, pkgs, ... }:
    let
      inherit (pkgs.stdenv) isDarwin;
      system = if isDarwin then "aarch64-darwin" else "x86_64-linux";
    in
    {
      home.packages = [
        inputs.myflakes.packages.${system}.neovim
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
