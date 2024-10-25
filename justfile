# https://cheatography.com/linux-china/cheat-sheets/justfile/

import 'provision/ansible/ansible.just'

set quiet
# alias t := test

[group('general')]
default:
  just -l

[group('general')]
list:
  @just --choose

[group('general')]
test:
  pre-commit run -a

[group('system')]
systemd:
  # command := `systemctl show '*' --state=loaded --property=Id --value --no-pager | grep . | sort | uniq | fzf`
  # output := shell(command)
  @echo "TODO: Fix pip systemctl units to fzf for easy status/restart/etc"
