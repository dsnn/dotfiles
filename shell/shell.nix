# shell.nix
with import <nixpkgs> { };

mkShell {
  name = "dotnet-env";
  packages = [
    dotnet-sdk
    (with dotnetCorePackages; combinePackages [ sdk_6_0 sdk_7_0 ])
  ];
}
