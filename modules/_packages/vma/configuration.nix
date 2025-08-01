{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    python3
  ];

  networking = {
    defaultGateway = {
      address = "192.168.2.1";
      interface = "eth0";
    };
    interfaces.eth0.useDHCP = false;
  };

  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.cloud-init.enable = true;
  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  time.timeZone = "Europe/Stockholm";

  users.users.dsn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    ];
  };

  users.users.root = {
    hashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    ];
  };

  nix.settings = {
    trusted-users = [
      "dsn"
      "root"
      "@wheel"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
