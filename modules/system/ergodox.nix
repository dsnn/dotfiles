{ config, pkgs, ... }: {
  # plugdev is required for ergodox ez 
  users.users.dsn.extraGroups = [ "plugdev" ];

  # enable flash support for ergodox ez 
  hardware.keyboard.zsa.enable = true;
}
