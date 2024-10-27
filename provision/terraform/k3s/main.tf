provider "dns" {
  update {
    server        = "192.168.2.110"
    key_name      = "tsig-key."
    key_algorithm = "hmac-sha256"
    key_secret    = var.TSIG_KEY
  }
}

module "dns" {
  source = "../modules/dns"
  for_each = var.servers

  name = each.value.name
  ipv4 = each.value.ip_address
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = ""
  pm_api_token_secret = ""
}

module "proxmox" {
  source = "../modules/lxc"
  for_each = var.servers

  vmid = each.value.vmid
  name = each.value.name
  memory = each.value.memory
  ipv4 = each.value.ip_address
  ostemplate   = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
  size = "20G"
  cmode = "console"

  unprivileged = true
  nesting = true
  ssh_password = var.ssh_password
}
