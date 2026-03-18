{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        xfce.thunar
        xfce.tumbler # thunar thunbnails
        xfce.xfconf # thunar persist settings
      ];
    };
}
