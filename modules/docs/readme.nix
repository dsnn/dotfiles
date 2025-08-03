{ config, ... }:
{
  text.readme = {
    order = [
      "intro"
      "files"
      "hosts"
      "links"
    ];

    parts.intro =
      # markdown
      ''
        # Dotfiles

        Dotfiles to manage everything, powered by [nix](https://nix.dev/).

      '';
  };

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = "README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
