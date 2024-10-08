resource "proxmox_lxc" "k3s-cluster" {
  for_each		 = var.servers

  vmid         = each.value.vmid
  target_node  = "omega"
  hostname     = each.value.name
  ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  password     = var.ssh_password
  unprivileged = true
  onboot       = true # start on boot
  start        = true # start after creation

  rootfs {
    size    = "8G"
    storage = "local-lvm"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = false
    ip       = each.value.ip_address
    gw       = each.value.gateway
  }

  features {
    nesting = true
  }

  ssh_public_keys = var.public_ssh_key 
}
