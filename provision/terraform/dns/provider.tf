terraform {
  required_version = ">= 0.13.0"

  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.2"
    }
  }

  cloud {
    organization = "dsw"
    workspaces {
      name = "dns"
    }
  }
}

provider "dns" {
  update {
    server        =  "192.168.2.110"
    key_name      =  "tsig-key."
    key_algorithm =  "hmac-sha256"
    key_secret    = var.TSIG_KEY
  }
}
