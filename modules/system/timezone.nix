{ config, pkgs, ... }: {

  # used when displaying times and dates
  time.timeZone = "Europe/Stockholm";

  # enable systemd NTP client daemon
  services.timesyncd.enable = true;
}
