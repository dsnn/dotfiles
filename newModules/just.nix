{
  flake.modules.home.just = pkgs: {
    home.packages = with pkgs; [ just ];

    programs.zsh = {
      shellAliases = {
        j = "just";
      };
      initContent = ''
        export JUST_UNSTABLE=1
      '';
    };
  };
}
