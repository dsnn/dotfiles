{
  eval = {
    target = {
      args = [
        "--expr"
        "with import <nixpkgs> { }; callPackage ./somePackage.nix { }"
      ];
      installable = "";
    };
    # Force thunks
    depth = 10;
  };
  formatting.command = "nixpkgs-fmt";
  options = {
    enable = true;
    target = {
      args = [ ];
      # nixOS configuration
      # installable = "../#nixosConfigurations.dev.options";

      # home-manager configuration
      installable = "../#homeConfigurations.dev.options";
    };
  };
}
