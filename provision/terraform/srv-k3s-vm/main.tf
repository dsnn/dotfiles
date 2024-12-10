resource "proxmox_vm_qemu" "k3s-cluster" {
  for_each = var.servers

  vmid             = each.value.vmid
  name             = each.value.name
  target_node      = "omega"
  os_type          = "cloud-init"

  clone            = "nixos-cloud"

  onboot           = true
  automatic_reboot = false
  boot             = "order=virtio0;ide2;net0"
  scsihw           = "virtio-scsi-single"

  agent            = 1

  cpu     = "host"
  cores   = 4
  sockets = 1
  memory  = 4096


  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = "10G"
          storage = "local"
          format  = "raw"
          cache   = "writeback"
          backup  = false
        }
      }
    }
  }

  ipconfig0  = each.value.ipconfig
  nameserver = "192.168.2.1"
  cipassword = var.ssh_password
  ciuser     = var.ssh_username
  sshkeys   = var.ssh_public_key
}
