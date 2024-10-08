# Infrastructure

## [NixOS Anywhere](https://github.com/nix-community/nixos-anywhere)

```console
    nix run github:nix-community/nixos-anywhere -- --flake .#template --build-on-remote user@ip
```

## [Packer](https://developer.hashicorp.com/packer/docs?product_intent=packer)

Create proxmox templates. Run command inside OS folder e.g pkr-ubuntu-noble-1

```console
    packer build -var-file=<(sops -d ~/dotfiles/secrets/secret.tfvars.json) .
```

## [Terraform](https://developer.hashicorp.com/terraform?product_intent=terraform)

Create and run infrastructure (virtual machines, DNS etc).
Sync state in cloud with terraform login.

```console
    terraform plan -var-file=<(sops -d ~/dotfiles/secrets/secret.tfvars.json)
    terraform apply -var-file=<(sops -d ~/dotfiles/secrets/secret.tfvars.json) -auto-approve
```

or decrypt secrets first to \*.dec.json (ignored by git but be careful anyway)

```console
sops -d ~/dotfiles/secrets/secrets.tfvars.json > secrets.dec.json
terraform plan --var-file=secrets.dec.json
terraform apply --var-file=secrets.dec.json

```

For manual formatting:

```console
terraform fmt -write -recursive <folder>
```

## [Generate documentation](https://github.com/NixOS/nixpkgs/blob/master/nixos/doc/manual/default.nix)

```console
    nix build .#options-doc
```

## Ansible

```console
ansible k3s-cluster -m ping
```

```console
ansible-galaxy install -r ./collections/requirements.yml
```
