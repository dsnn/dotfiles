{ config, ... }:
{
  text.readme = {
    order = [
      "intro"
      "second"
      "files"
    ];

    parts.intro =
      # markdown
      ''
        # Dotfiles 
      '';

    parts.second =
      # markdown
      ''
        this is a second test
      '';
  };

  perSystem =
    { pkgs, ... }:
    {
      # packages.readme = pkgs.writeTextFile {
      #   name = "README.md";
      #   destination = "/README.md";
      #   text = config.text.readme;
      # };
      files.files = [
        {
          path_ = "README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
