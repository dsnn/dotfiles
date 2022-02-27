{ config, pkgs, ... }: {
  # package channel
  nix.package = pkgs.nixUnstable;

  # enable flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # collect garbage & optimize 
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  # replace duplicates w/ hard links (and save space)
  # settings.auto-optimise-store = true;
}
