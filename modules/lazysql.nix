{
  flake.modules.homeManager.lazysql =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        lazysql
      ];
    };
}
