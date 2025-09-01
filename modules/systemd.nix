{
  flake.modules.homeManager.systemd =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [ systemd ];

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";
    };
}
