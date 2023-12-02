{ ... }: {
  imports = [
    # ./awesomewm
    # ./boot.nix
    # ./cifs.nix
    # ./ergodox.nix
    # ./fail2ban.nix
    # ./libinput.nix
    # ./locale.nix
    # ./networkmanager.nix
    # ./nix.nix
    # ./overlays.nix
    # ./pulseaudio.nix
    # ./ssh.nix
    # ./timezone.nix
    # ./user.nix
    # ./xrdp.nix
    # ./zfs.nix
    ./environment.nix
    ./homebrew.nix
    ./nix-doc.nix
  ];
}

