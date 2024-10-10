resource "proxmox_vm_qemu" "srv-docker-01" {

  vmid        = 110
  name        = "srv-docker-01"
  target_node = "omega"
  os_type     = "cloud-init"

  # clone template
  clone = "ubuntu-cloud"

  # boot (scsi0 is the boot/OS disk)
  onboot           = true
  automatic_reboot = false
  boot             = "order=scsi0;ide2;net0"

  # qemu
  agent = 1

  # define resources
  cpu     = "host"
  cores   = 4
  sockets = 1
  memory  = 8192

  scsihw = "virtio-scsi-single"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "32G"
          storage = "local-lvm"
          format  = "raw"
          cache   = "writeback"
          backup  = false
        }
      }
    }
  }

  serial {
    id   = 0
    type = "socket"
  }

  network {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = false
  }

  # cloud init
  ipconfig0 = "ip=192.168.2.110/24,gw=192.168.2.1"
  nameserver = "192.168.2.1"
  cipassword = var.ssh_password
  ciuser     = var.ssh_username
  sshkeys   = var.ssh_public_key
}
