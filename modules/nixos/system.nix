{ ... }: {
  system.autoUpgrade = {
    enable = true;
    # flake = inputs.self.outPath;
    channel = "https://nixos.org/channels/nixos-24.05";
    # flags = [ "--update-input" "nixpkgs" "-L" ];
    # dates = "09:00";
    # randomizeDelaySec = "45min";
  };
}
