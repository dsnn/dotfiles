{ config, ... }:
{
  text.readme = {
    order = [
      "intro"
    ];

    parts.intro =
      # markdown
      ''
        Testing
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
