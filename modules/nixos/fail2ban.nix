{ config, pkgs, ... }: {

  # enable fail2ban
  services.fail2ban.enable = true;

  # increase a default ban time using special formula
  # default it is banTime * 1, 2, 4, 8, 16, 32... 
  services.fail2ban.bantime-increment.enable = true;

  # number of failures before a host gets banned
  services.fail2ban.maxretry = 5;

}
