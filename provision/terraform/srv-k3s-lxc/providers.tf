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
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.2"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
}

provider "dns" {
  update {
    server        =  "192.168.2.110"
    key_name      =  "tsig-key."
    key_algorithm =  "hmac-sha256"
    key_secret    =  var.TSIG_KEY
  }
}
