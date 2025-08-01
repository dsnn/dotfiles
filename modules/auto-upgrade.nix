{
  flake.modules.nixos.autoUpgrade = {
    system.autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-25.05";
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
      ];
      dates = "07:00";
    };
  };
}
