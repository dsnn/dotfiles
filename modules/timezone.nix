{ config, pkgs, ... }: {
  # timezone
  time.timeZone = "Europe/Stockholm";

  # time sync daemon
  services.timesyncd.enable = true;
}
