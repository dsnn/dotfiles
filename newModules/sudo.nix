{
  flake.modules.nixos.sudo = {
    security = {
      sudo = {
        wheelNeedsPassword = false;
        extraRules = [
          {
            users = [ "dsn" ];
            commands = [
              {
                command = "ALL";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      };
    };
  };
}
