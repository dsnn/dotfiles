resource "proxmox_lxc" "lxc" {
  vmid         = var.vmid
  target_node  = "omega"
  hostname     = var.name
  ostemplate   = var.ostemplate
  password     = var.ssh_password
  unprivileged = var.unprivileged
  onboot       = true # start on boot
  start        = true # start after creation
  memory       = var.memory
  cmode        = var.cmode

  rootfs {
    size    = var.size
    storage = var.storage
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = false
    ip       = "${var.ipv4}/24"
    gw       = var.gateway
  }

  features {
    nesting = var.nesting
  }

  ssh_public_keys = var.ssh_public_key
}
