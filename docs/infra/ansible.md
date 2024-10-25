# Ansible

## Ping

```console
ansible -i inventory/k3s.yaml -m ping
```

## Install requirements

```console
ansible-galaxy install -r ./collections/requirements.yml
```
