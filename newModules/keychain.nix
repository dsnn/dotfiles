{
  flake.modules.home.keychain = {
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
