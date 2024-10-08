resource "proxmox_vm_qemu" "srv-dev-01" {
  agent            = 1
  cipassword       = var.ssh_password
  ciuser           = var.ssh_username
  clone            = "pkr-ubuntu-noble-1"
  cores            = 1
  cpu              = "host"
  memory           = 2024
  name             = "srv-dev-01"
  onboot           = true
  os_type          = "cloud-init"
  sockets          = 1
  target_node      = "omega"
  vmid             = 101
  automatic_reboot = false
  bios             = "seabios"
  boot             = "order=virtio0;ide0;net0"

  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "20G"
          cache   = "writeback"
          storage = "local-lvm"
          discard = true
        }
      }
    }
  }

  network {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = false
  }

  # cloud init
  ipconfig0 = "ip=192.168.2.101/24,gw=192.168.2.1"
  sshkeys   = var.ssh_public_keys
}

