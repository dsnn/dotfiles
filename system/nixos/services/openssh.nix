{ ... }: {

  services.openssh = {
    enable = true;
    # allowSFTP = true;
    # forwardX11 = false;
    # permitRootLogin = "no";
    # passwordAuthentication = false;
  };

  # sshd.enable = true;
}
