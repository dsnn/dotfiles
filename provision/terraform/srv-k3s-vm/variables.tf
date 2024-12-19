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

variable "ssh_public_key" {
  type = string
}

variable "servers" {
  default = {
    "k3s" = {
      vmid     = "121"
      name     = "k3s"
      ipconfig = "ip=192.168.2.121/24,gw=192.168.2.1"
    }
    # "k3s-agent-01" = {
    #   vmid     = "122"
    #   name     = "k3s-agent-01"
    #   ipconfig = "ip=192.168.2.122/24,gw=192.168.2.1"
    # }
    # "k3s-agent-02" = {
    #   vmid     = "123"
    #   name     = "k3s-agent-02"
    #   ipconfig = "ip=192.168.2.123/24,gw=192.168.2.1"
    # }
  }
}
