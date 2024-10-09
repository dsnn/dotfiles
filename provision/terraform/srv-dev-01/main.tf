resource "proxmox_vm_qemu" "srv-dev-01" {

  vmid        = 101
  name        = "srv-dev-01"
  target_node = "alpha"
  os_type     = "cloud-init"

  # clone template
  clone = "noble-ubuntu-cloud"

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
  memory  = 6144

  # specify our custom userdata script
  cipassword = var.ssh_password
  ciuser     = var.ssh_username

  # benchmarks faster then iscsi https://kb.blockbridge.com/technote/proxmox-aio-vs-iouring/#recommended-settings
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
          storage = "ssd"
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
  ipconfig0 = "ip=192.168.2.101/24,gw=192.168.2.1"
  sshkeys   = var.ssh_public_key
}

