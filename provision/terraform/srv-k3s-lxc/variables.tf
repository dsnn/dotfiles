variable "proxmox_api_url" {
  type = string
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_public_key" {
  type = string
}

variable "TSIG_KEY" {
  type      = string
  sensitive = true
}

variable "servers" {
  default = {
    "srv-k3s-01" = {
      vmid       = "121"
      name       = "srv-k3s-01"
      ip_address = "192.168.2.121"
      gateway    = "192.168.2.1"
      memory     = 4096
    }
    "srv-k3s-02" = {
      vmid       = "122"
      name       = "srv-k3s-02"
      ip_address = "192.168.2.122"
      gateway    = "192.168.2.1"
      memory     = 4096
    }
    "srv-k3s-03" = {
      vmid       = "123"
      name       = "srv-k3s-03"
      ip_address = "192.168.2.123"
      gateway    = "192.168.2.1"
      memory     = 4096
    }
    "srv-k3s-agent-01" = {
      vmid       = "124"
      name       = "srv-k3s-agent-01"
      ip_address = "192.168.2.124"
      gateway    = "192.168.2.1"
      memory     = 4096
    }
    "srv-k3s-agent-02" = {
      vmid       = "125"
      name       = "srv-k3s-agent-02"
      ip_address = "192.168.2.125"
      gateway    = "192.168.2.1"
      memory     = 4096
    }
  }
}
