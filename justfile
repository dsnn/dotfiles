# https://cheatography.com/linux-china/cheat-sheets/justfile/

set quiet

############################################################################
#
#  Ansible commands
#
############################################################################

import 'provision/ansible/ansible.just'

############################################################################
#
#  Common commands
#
############################################################################

# List all the just commands
default:
    @just --list

# List PATH-vars separated by new line
[group('common')]
path:
   echo $PATH | tr ':' '\n'

############################################################################
#
#  Homelab - Remote deployment
#
############################################################################

# Run colmena apply on host
[linux]
[group('homelab')]
col host:
  colmena apply --on '@{{host}}' --verbose --show-trace

# Run nixos-anywhere with #cloud and ip as target-host
[linux]
[group('homelab')]
any ip:
  nix run github:nix-community/nixos-anywhere -- --flake ~/dotfiles#anywhere --target-host dsn'@{{ip}}'

############################################################################
#
#  Nix commands
#
############################################################################

# Update all the flake inputs
[group('nix')]
update:
  nix flake update

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d


# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d



############################################################################
#
#  Nix build commands
#
############################################################################

# Build NixOS iso image
[group('nix-build')]
iso:
  nix build .#iso

# Build NixOS .raw-disk with disko and NixOS
[group('nix-build')]
raw:
  nix build .#raw

# Build NixOS proxmox backup (restore in proxmox)
[group('nix-build')]
vma:
  nix build .#vma

############################################################################
#
#  Repo commands
#
############################################################################

# Run pre-commit on all files
[group('repo')]
test:
  pre-commit run -a

# =================================================
#
# Service commands
#
# =================================================

[group('services')]
sys:
  sysz

[linux]
[group('services')]
list-inactive:
  systemctl list-units -all --state=inactive

[linux]
[group('services')]
list-failed:
  systemctl list-units -all --state=failed
