variable "proxmox_api_url" {
  type = string
  default = "https://proxmox.dsnn.io/api2/json"
}

variable "vmid" {
  type = number
}

variable "name" {
  type = string
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "memory" {
  type = number
  default = 2048
}

variable "cmode" {
  type = string
  default = "tty"
}

variable "size" {
  type = string
  default = "8G"
}

variable "storage" {
  type = string
  default = "local-lvm"
}

variable "ipv4" {
  type = string
}

variable "gateway" {
  type = string
  default = "192.168.2.1"
}

variable "ssh_public_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
}

variable "ostemplate" {
  type= string
  default =  "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "unprivileged" {
  type = bool
  default = true
}

variable "nesting" {
  type = bool
  default = false
}
