{
  flake.modules.homeManager.home-settings = {
    home = {
      username = "dsn";
      stateVersion = "25.05";
      sessionVariables.NIXD_FLAGS = "-log=error";
    };
  };

  flake.modules.darwin.users = {
    users.users.dsn.home = "/Users/dsn";
  };

  flake.modules.nixos.users =
    { pkgs, ... }:
    {
      users.users.dsn = {
        shell = pkgs.zsh;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF%"
        ];
        hashedPassword = "$2a$12$U.fpBTbteaXgHhAY0q16HuiJozo2QLXHvEKkpCgIS6mA8Mn1stntS";
        extraGroups = [
          "dsn"
          "users"
          "wheel"
          "networkmanager"
          "docker"
        ];
      };
    };
}
