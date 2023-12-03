{ config, pkgs, ... }: {
  imports = [ ./hardware.nix ];

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

  # window manager
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.defaultSession = "none+i3";
  # services.xserver.windowManager.i3.enable = true;
  # services.xserver.windowManager.i3.extraPackages = with pkgs; [ i3status ];

  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";
  services.xserver.dpi = 120;
  # services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # services.xserver.layout = "us";
  # services.xserver.videoDrivers = [ " nvidia " ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;

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

  nix = let users = [ "root" "dsn" ];
  in {
    settings = {
      experimental-features = "nix-command flakes";
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      sandbox = "relaxed";
      auto-optimise-store = true;
      trusted-users = users;
      allowed-users = users;
    };
    gc = { automatic = true; };
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
    coreutils
    gcc
    git
    home-manager
    man
    tree
    vim
    neovim
    wget
    pciutils
    pavucontrol
    age
    sops
    inetutils
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

