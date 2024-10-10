resource "proxmox_vm_qemu" "virtual_machine" {
    target_node = var.target_node
    vmid = var.vmid
    name = var.name
    clone = var.image
        cores = var.cores
        memory = var.memory
        sockets = 1
      bios   = "seabios"
      boot = "order=virtio0;ide0;net0"
    agent = 1
    cpu = "host"
    onboot = true
        automatic_reboot = false

        disks {
            virtio {
                virtio0 {
                    disk {
                        size            = "20G"
                        cache           = "writeback"
                        storage         = "local-lvm"
                        discard         = true
                    }
                }
            }
      }

        network {
            bridge = "vmbr0"
            model  = "virtio"
            firewall = false
    }
}
