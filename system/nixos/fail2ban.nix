{ config, pkgs, ... }: {

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
  services.fail2ban.maxretry = 5;

}
