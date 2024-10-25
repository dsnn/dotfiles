# shell.nix
with import <nixpkgs> { };

mkShell {
  name = "dotfiles";
  packages = [
    mkdocs
    python310Packages.mkdocs-material
    # dotnet-sdk
    # (
    #   with dotnetCorePackages;
    #   combinePackages [
    #     sdk_6_0
    #     sdk_7_0
    #   ]
    # )
  ];
}
