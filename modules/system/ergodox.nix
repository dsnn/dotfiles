{ config, pkgs, ... }: {

  # plugdev is required for ergodox ez 
  users.users.dsn.extraGroups = [ "plugdev" ];

  # enables udev rules for keyboards from ZSA 
  hardware.keyboard.zsa.enable = true;
}
