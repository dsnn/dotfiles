{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
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
