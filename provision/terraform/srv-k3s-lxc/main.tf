resource "proxmox_lxc" "k3s-cluster" {
  for_each = var.servers

  vmid         = each.value.vmid
  target_node  = "omega"
  hostname     = each.value.name
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password     = var.ssh_password
  unprivileged = false
  onboot       = true # start on boot
  start        = true # start after creation
  memory       = each.value.memory

  rootfs {
    size    = "8G"
    storage = "local-lvm"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = false
    ip       = "${each.value.ip_address}/24"
    gw       = each.value.gateway
  }

  features {
    nesting = true
  }

  ssh_public_keys = var.ssh_public_key
}

resource "dns_a_record_set" "k3s-cluster-dns" {
  for_each = var.servers

  zone = "home.dsnn.io."
  name = each.value.name
  addresses = [
    each.value.ip_address
  ]
  ttl = 300
}
