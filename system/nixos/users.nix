{ config, pkgs, ... }: {

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

}
