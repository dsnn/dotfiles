variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "ssh_username" {
  type = string
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "public_ssh_key" {
	type			= string
}

variable "servers" {
  default = {
    "srv-k3s-01" = {
      vmid       = "201"
      name       = "srv-k3s-01"
      ip_address = "192.168.2.121/24"
      gateway    = "192.168.2.1"
    }
    "srv-k3s-02" = {
      vmid       = "202"
      name       = "srv-k3s-02"
      ip_address = "192.168.2.122/24"
      gateway    = "192.168.2.1"
    }
    "srv-k3s-03" = {
      vmid       = "203"
      name       = "srv-k3s-03"
      ip_address = "192.168.2.123/24"
      gateway    = "192.168.2.1"
    }
    "srv-k3s-agent-01" = {
      vmid       = "220"
      name       = "srv-k3s-agent-01"
      ip_address = "192.168.2.124/24"
      gateway    = "192.168.2.1"
    }
    "srv-k3s-agent-02" = {
      vmid       = "221"
      name       = "srv-k3s-agent-02"
      ip_address = "192.168.2.125/24"
      gateway    = "192.168.2.1"
    }
  }
}
