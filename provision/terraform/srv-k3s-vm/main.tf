resource "proxmox_vm_qemu" "k3s-cluster" {
  for_each = var.servers

  vmid             = each.value.vmid
  name             = each.value.name
  target_node      = "omega"
  desc             = ""
  agent            = 1
  qemu_os          = "other"
  bios             = "seabios"
  full_clone       = true
  onboot           = true
  startup          = ""
  automatic_reboot = false

  cores   = 4
  sockets = 1
  cpu     = "host"
  memory  = 4096

  scsihw = "virtio-scsi-pci"

  define_connection_info = false

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  ipconfig0  = each.value.ipconfig
  nameserver = "192.168.2.1"

  sshkeys = var.ssh_public_key
}
