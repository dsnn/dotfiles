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

variable "nixos-cluster" {
  default = {
    "nixos-node-01" = {
      vmid = "111"
      name = "nixos-node-01"
      ip_address = "192.168.2.111/24"
      gateway = "192.168.2.1"
    }
    "nixos-node-02" = {
      vmid = "112"
      name = "nixos-node-02"
      ip_address = "192.168.2.112/24"
      gateway = "192.168.2.1"
    }
    "nixos-node-03" = {
      vmid = "113"
      name = "nixos-node-03"
      ip_address = "192.168.2.113/24"
      gateway = "192.168.2.1"
    }
    "nixos-agent-01" = {
      vmid = "114"
      name = "nixos-agent-01"
      ip_address = "192.168.2.114/24"
      gateway = "192.168.2.1"
    }
    "nixos-agent-02" = {
      vmid = "115"
      name = "nixos-agent-02"
      ip_address = "192.168.2.115/24"
      gateway = "192.168.2.1"
    }
  }
}

resource "proxmox_lxc" "nixos-lxc-cluster" {
    for_each = var.,ixos-cluster

    vmid = each.value.vmid
    target_node = "omega"
    hostname = each.value.name
	  ostemplate = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
    password = "${var.ssh_password}"
    unprivileged = true
		onboot = true # start on boot
		start = true # start after creation
		cmode = "console" # make the console/shell work.

		rootfs {
			size    = "8G"
			storage = "local-lvm"
		}
		network {
				name = "eth0"
        bridge = "vmbr0"
				firewall = false
        ip = each.value.ip_address 
				gw = each.value.gateway
    }
    features {
        nesting = true
    }

    ssh_public_keys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF
    EOF
}
