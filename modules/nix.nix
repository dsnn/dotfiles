{ config, pkgs, ... }: {
  nix = {

    # enable flakes
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # replace duplicates w/ hard links (and save space)
    nix.autoOptimiseStore = true;
  };
}
