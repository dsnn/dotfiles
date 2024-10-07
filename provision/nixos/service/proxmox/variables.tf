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

variable "target_node" {
	type = string
}

variable "vmid" {
	type = string
}

variable "name" {
	type = string
}

variable "image" {
	type = string
}

variable "cores" {
	type = string
}

variable "memory" {
	type = string
}
