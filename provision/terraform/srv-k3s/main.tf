terraform {
    required_version = ">= 0.13.0"

    required_providers {
			proxmox = {
				source = "Telmate/proxmox"
				version = "3.0.1-rc3"
			}
    }
}

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
  type      = string
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

provider "proxmox" {
		pm_api_url = "${var.proxmox_api_url}"
		pm_api_token_id = "${var.proxmox_api_token_id}"
		pm_api_token_secret = "${var.proxmox_api_token_secret}"
    pm_tls_insecure = true
}

variable "srv-k3s-cluster" {
  default = {
    "srv-k3s-01" = {
      vmid = "201"
      name = "srv-k3s-01"
      ip_address = "192.168.2.121/24"
      gateway = "192.168.2.1"
    }
    "srv-k3s-02" = {
      vmid = "202"
      name = "srv-k3s-02"
      ip_address = "192.168.2.122/24"
      gateway = "192.168.2.1"
    }
    "srv-k3s-03" = {
      vmid = "203"
      name = "srv-k3s-03"
      ip_address = "192.168.2.123/24"
      gateway = "192.168.2.1"
    }
    "srv-k3s-agent-01" = {
      vmid = "220"
      name = "srv-k3s-agent-01"
      ip_address = "192.168.2.124/24"
      gateway = "192.168.2.1"
    }
    "srv-k3s-agent-02" = {
      vmid = "221"
      name = "srv-k3s-agent-02"
      ip_address = "192.168.2.125/24"
      gateway = "192.168.2.1"
    }
  }
}

resource "proxmox_vm_qemu" "srv-k3s-cluster" {
    for_each = var.srv-k3s-cluster

    # general
    agent = 1
    cipassword = "${var.ssh_password}"
    ciuser = "${var.ssh_username}"
    clone = "pkr-ubuntu-noble-1"
		cores = 1 
    cpu = "host"
		memory = 2024 
    name = each.value.name
		onboot = true 
    os_type = "cloud-init"
		sockets = 1 
    target_node = "omega" 
    vmid = each.value.vmid

    network {
        bridge = "vmbr0"
        model  = "virtio"
				firewall = false
    }

    # cloud init
    ipconfig0 = "ip=${each.value.ip_address},gw=${each.value.gateway}"
    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF
    EOF
}

