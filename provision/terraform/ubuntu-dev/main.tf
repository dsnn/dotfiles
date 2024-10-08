terraform {
    required_version = ">= 0.13.0"

    required_providers {
			proxmox = {
				source = "Telmate/proxmox"
				version = "3.0.1-rc3"
			}
    }
}

resource "proxmox_vm_qemu" "ubuntu-dev" {
    # general
    agent = 1
    cipassword = "${var.ssh_password}"
    ciuser = "${var.ssh_username}"
    clone = "pkr-ubuntu-noble-1"
		cores = 1
    cpu = "host"
		memory = 3024
    name = "ubuntu-dev"
    onboot = true
    os_type = "cloud-init"
		sockets = 1
    target_node = "alpha"
    vmid = 101
		automatic_reboot = false
	  bios   = "seabios"
	  boot = "order=virtio0;ide0;net0"

		disks {
			ide {
        ide0 {
          cloudinit {
            storage = "local-lvm"
          }
        }
      }
			virtio {
				virtio0 {
					disk {
						size    = "20G"
						cache   = "writeback"
						storage = "local-lvm"
						discard = true
					}
				}
			}
	  }

		network {
        bridge = "vmbr0"
        model  = "virtio"
				firewall = false
    }

    # cloud init
    ipconfig0 = "ip=192.168.2.101/24,gw=192.168.2.1"
    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF
    EOF
}

