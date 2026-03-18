{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ keychain ];

      programs = {
        keychain = {
          enable = true;
          enableZshIntegration = true;
          extraFlags = [
            "--quiet"
            "--quick"
          ];
          keys = [ "id_rsa" ];
        };
      };
    };
}
