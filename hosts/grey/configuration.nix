{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/fail2ban.nix
    ../../modules/nixos/containers/gitea.nix
    ../../modules/common.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "grey";
  networking.hostId = "199f97e0";
  networking.networkmanager.enable = true;

  # TODO: Remove later.
  # Temp / testing workaround for remote deploy.
  # Insecure and not recommended
  security.sudo.extraRules = [{
    users = [ "dsn" ];
    commands = [{
      command = "ALL";
      options =
        [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
    }];
  }];

  # TODO: Review and try this later
  # security.sudo.extraRules = let
  #   storePrefix = "/nix/store/*";
  #   systemName = "nixos-system-${config.networking.hostName}-*";
  # in [
  #   {
  #     commands = [{
  #       command =
  #         "${storePrefix}-nix-*/bin/nix-env -p /nix/var/nix/profiles/system --set ${storePrefix}-${systemName}";
  #       options = [ "NOPASSWD" ];
  #     }];
  #     groups = [ "wheel" ];
  #   }
  #   {
  #     commands = [{
  #       command = "${storePrefix}-${systemName}/bin/switch-to-configuration";
  #       options = [ "NOPASSWD" ];
  #     }];
  #     groups = [ "wheel" ];
  #   }
  # ];

  # persist settings for some apps (https://nixos.wiki/wiki/I3#DConf)
  programs.dconf.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Europe/Stockholm";
  services.timesyncd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  # keyMap = "sv-latin1";

  services.xserver = {

    enable = true;
    autorun = false;
    layout = "us";
    xkbOptions = "eurosign:e,caps:escape";
    dpi = 120;
    # videoDrivers = [ " nvidia " ];

    # desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    # desktopManager.gnome.enable = true;

    displayManager = {
      lightdm.enable = true;
      # gdm.enable = true;
      defaultSession = "none+i3";
    };

    windowManager = {
      i3.enable = true;
      i3.extraPackages = with pkgs; [ i3status ];
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.zsh.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;

  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };
  users.users.dsn = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "docker" ];
    hashedPassword =
      "$y$j9T$Wg1CGw.yYxfHmeXp.joE3/$Z70N2uCHfh2BcQ978valtj/FByc3jwX.3q94hzD39U0";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
    ];
  };

  # users.users.root.passwordFile = config.sops.secrets."password/root".path;
  # security.sudo.wheelNeedsPassword = false;
  # https://github.com/serokell/deploy-rs/issues/25
  # nix.trustedUsers = [ "@wheel" ];

  # sops = {
  #   secrets."password/root" = {
  #     sopsFile = ../.secrets/passwords.yaml;
  #     neededForUsers = true;
  #   };
  # };

  users.groups.docker.members = config.users.groups.wheel.members;

  environment.systemPackages = with pkgs; [
    gcc
    inetutils
    pavucontrol
    pciutils
  ];

  services.openssh.enable = true;
  # services.openssh.forwardX11 = false;
  # services.openssh.permitRootLogin = "no";
  # services.openssh.passwordAuthentication = false;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "23.05";
}

