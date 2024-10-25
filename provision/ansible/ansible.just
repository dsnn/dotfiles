[group('ansible')]
ping:
  ansible -i ~/dotfiles/provision/ansible/hosts.yaml all -m ping
