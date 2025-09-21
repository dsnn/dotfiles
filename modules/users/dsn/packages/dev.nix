{
  flake.modules.homeManager.user-dsn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nixos-generators
        colmena
        watchexec
        lazydocker
        gum
        # combine multiple dotnet SDK versions
        (
          with dotnetCorePackages;
          combinePackages [
            sdk_8_0
            sdk_9_0
          ]
        )
      ];
    };
}
