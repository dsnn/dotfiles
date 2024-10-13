locals {
  ipv4 = "192.168.2.103"
}

resource "proxmox_vm_qemu" "srv-nixos-01" {
  target_node      = "alpha"
  vmid             = 103
  name             = "srv-nixos-01"
  clone            = "nixos-minimal-24.05.3566.8b5b6723aca5-x86_64-linux.iso"
  cores            = 4
  memory           = 4096
  sockets          = 1
  bios             = "seabios"
  boot             = "order=virtio0;net0"
  agent            = 1
  cpu              = "host"
  onboot           = true
  automatic_reboot = false

  disks {
    virtio {
      virtio0 {
        disk {
          size    = "32G"
          cache   = "writeback"
          storage = "ssd"
        }
      }
    }
  }

  network {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = false
  }

  ipconfig0 = "ip=192.168.2.101/24,gw=192.168.2.1"
  nameserver = "192.168.2.1"
}


module "deploy" {
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.service.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.service.config.system.build.diskoScript"

  target_host = local.ipv4
  instance_id = local.ipv4
}
