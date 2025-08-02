{
  flake.modules.services.fail2ban = {
    services.fail2ban = {
      enable = true;
      bantime-increment.enable = true;
      ignoreIP = [
        "10.0.0.0/24"
        "192.168.0.0/24"
      ];
      maxretry = 5;
    };
  };
}
