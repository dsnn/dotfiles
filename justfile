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

[group('common')]
path:
   echo $PATH | tr ':' '\n'

# Update all the flake inputs
[group('nix')]
up:
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

[group('nix')]
test:
  pre-commit run -a

############################################################################
#
#  Homelab - Kubevirt Cluster related commands
#
############################################################################

# Remote deployment via colmena
[linux]
[group('homelab')]
col tag:
  colmena apply --on '@{{tag}}' --verbose --show-trace

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
