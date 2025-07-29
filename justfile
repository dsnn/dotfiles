# https://cheatography.com/linux-china/cheat-sheets/justfile/

set quiet := true

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

[group('services')]
[linux]
list-inactive:
    systemctl list-units -all --state=inactive

[group('services')]
[linux]
list-failed:
    systemctl list-units -all --state=failed
