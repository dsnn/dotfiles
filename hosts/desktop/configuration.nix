# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ../shared-configuration.nix ];
  networking.hostId = "8d549888";
  networking.hostName = "dsn";
}

