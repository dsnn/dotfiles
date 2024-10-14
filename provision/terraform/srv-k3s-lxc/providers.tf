terraform {
  required_version = ">= 0.13.0"

  cloud {
    organization = "dsw"
    workspaces {
      name = "proxmox"
    }
  }

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_tls_insecure     = true
}
