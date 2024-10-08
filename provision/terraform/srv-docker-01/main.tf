resource "proxmox_lxc" "srv-docker-01" {
  vmid         = 102
  target_node  = "omega"
  hostname     = "srv-docker-01"
  ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  password     = var.ssh_password
  unprivileged = true
  onboot       = true
  start        = true

  rootfs {
    size    = "8G"
    storage = "local-lvm"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = false
    ip       = "dhcp"
    ip6      = "dhcp"
  }

  features {
    # fuse = true
    # mount = ""
    nesting = true
  }

  ssh_public_keys = var.ssh_public_keys
}
