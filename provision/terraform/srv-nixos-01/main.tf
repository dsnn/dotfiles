terraform {
    required_version = ">= 0.13.0"

    required_providers {
			proxmox = {
				source = "Telmate/proxmox"
				version = "3.0.1-rc3"
			}
    }
}

resource "proxmox_lxc" "srv-nixos-01" {
		vmid = 110
    target_node = "omega"
    hostname = "srv-nixos-01"
		ostemplate = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
		# clone = 0 # vmid of template to clone
    password = "${var.ssh_password}"
    unprivileged = true
		onboot = true # start on boot
		start = true # start after creation
		cmode = "console" # make the console shell work.

		rootfs {
			size    = "20G"
			storage = "local-lvm"
		}

		# TODO: mounts / mountpoints ?

		network {
				name = "eth0"
        bridge = "vmbr0"
				firewall = false
        ip = "dhcp"
        ip6 = "dhcp"
    }

    features {
				# fuse = true
				# mount = ""
        nesting = true
    }

    ssh_public_keys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF
    EOF
}
