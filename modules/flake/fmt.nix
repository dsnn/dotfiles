{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        prettier.enable = true;
        shfmt.enable = true;
        yamlfmt.enable = true;
      };
      settings = {
        on-unmatched = "fatal";
        global.excludes = [
          "*.jpg"
          "*.png"
          "*.toml"
          "*/.gitignore"
          "*karabiner/**"
          "LICENSE"
          "envdis"
        ];
      };
    };
    pre-commit.settings.hooks.treefmt.enable = true;
  };
}
