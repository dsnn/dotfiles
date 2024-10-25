# Terraform

## Documentation

[Documentation](https://developer.hashicorp.com/terraform?product_intent=terraform)

## Basic Usage

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

## Formatting

For manual formatting:

```console
terraform fmt -write -recursive <folder>
```
