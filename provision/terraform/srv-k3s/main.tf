resource "proxmox_lxc" "k3s-cluster" {
  for_each = var.servers

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
    # fuse = true
    # mount = ""
    nesting = true
  }

  ssh_public_keys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF
    EOF
}
