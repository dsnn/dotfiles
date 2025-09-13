{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = false;
        prettier.enable = true;
        shfmt.enable = true;
        yamlfmt.enable = true;
      };
      settings = {
        on-unmatched = "warn";
        global.excludes = [
          "*.jpg"
          "*.png"
          "*.toml"
          "*/.gitignore"
          "*karabiner/**"
          "LICENSE"
          "envdis"
          "modules/_scripts/*"
        ];
      };
    };
    pre-commit.settings.hooks.treefmt.enable = false;
  };
}
