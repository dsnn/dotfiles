{
  flake.modules.homeManager.user-dsn =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "ef";

          runtimeInputs = [
            pkgs.gum
            pkgs.fzf
            pkgs.dotnet-sdk_8 # or whatever version you use
          ];

          text = builtins.readFile ./dotnet-ef-helper;
        })
      ];
    };
}
