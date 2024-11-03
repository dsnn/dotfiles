terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

locals {
  vmid       = "102"
  name       = "cache"
  ip_address = "192.168.2.102"
  gateway    = "192.168.2.1"
  memory     = 1024
  proxmox_api_url  ="https://proxmox.dsnn.io/api2/json"
}

provider "proxmox" {
  pm_api_url = local.proxmox_api_url
  pm_api_token_id = ""
  pm_api_token_secret = ""
}

module "proxmox" {
  source = "../modules/lxc"

  vmid = local.vmid
  name = local.name
  memory = local.memory
  ipv4 = local.ip_address
  ostemplate   = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
  size = "8G"
  cmode = "console"

  unprivileged = true
  nesting = true
  ssh_password = var.ssh_password
}
