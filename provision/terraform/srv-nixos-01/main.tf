locals {
  ipv4 = "192.168.2.103"
}

resource "proxmox_vm_qemu" "srv-nixos-01" {
  target_node      = "alpha"
  vmid             = 103
  name             = "srv-nixos-01"
  clone            = "nixos-cloud"
  cores            = 4
  memory           = 4096
  sockets          = 1
  cpu              = "host"
  onboot           = true
  automatic_reboot = false

  # cloud init
  ipconfig0 = "ip=${local.ipv4}/24,gw=192.168.2.1"
  nameserver = "192.168.2.1"
  cipassword = var.ssh_password
  ciuser     = var.ssh_username
  sshkeys   = var.ssh_public_key

}


# module "deploy" {
#   source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
#   nixos_system_attr      = ".#nixosConfigurations.service.config.system.build.toplevel"
#   nixos_partitioner_attr = ".#nixosConfigurations.service.config.system.build.diskoScript"
#
#   target_host = local.ipv4
#   instance_id = local.ipv4
# }
