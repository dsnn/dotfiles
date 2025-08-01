{ inputs, config, ... }:
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

  imports = [ inputs.files.flakeModules.default ];

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
