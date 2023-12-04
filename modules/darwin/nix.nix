{ ... }: {

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # nix.package = pkgs.nixUnstable;

  nix.gc.automatic = true;
  nix.gc.interval = {
    Weekday = 0;
    Hour = 0;
    Minute = 0;
  };
  nix.gc.options = "--delete-older-than 30d";
}
