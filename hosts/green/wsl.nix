{ ... }:
{
  wsl = {
    enable = true;
    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
    defaultUser = "dsn";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = false;
  };

  # wsl.enable = true;
  # wsl.defaultUser = "dsn";
  # wsl.automountPath = "/mnt";
  # wsl.startMenuLaunchers = true;

}
