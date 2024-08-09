{
  description = "A very basic flake";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      pve_ssh_tgt = "root@alpha";
      vmid = "901";
      vm_ip = "ip=192.168.2.200/24,gw=192.168.2.1";
    in {
      nixosConfigurations.test-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ lib, modulesPath, pkgs, ... }: {
            imports = [ "${modulesPath}/virtualisation/proxmox-image.nix" ];
            proxmox = {
              qemuConf = {
                name = "nixos-template";
                cores = 4;
                memory = 4096;
              };
              qemuExtraConf.ipconfig0 = vm_ip;
            };
            networking = {
              hostName = lib.mkForce "";
              useDHCP = false;
            };
            services = {
              cloud-init = {
                enable = true;
                network.enable = true;
              };
              getty.autologinUser = "root";
              sshd.enable = true;
            };
          })
        ];
      };
      packages.x86_64-linux.deploy =
        nixpkgs.legacyPackages.x86_64-linux.writeScriptBin "deploy" ''
          VMA=$(tail -n1 ${self.nixosConfigurations.test-vm.config.system.build.VMA}/nix-support/hydra-build-products | awk '{print $NF}')
          [ -z $VMA ] && false
          scp $VMA ${pve_ssh_tgt}:/var/lib/vz/dump/vzdump-qemu-nixos-template.vma.zst
          ssh ${pve_ssh_tgt} "qm stop ${vmid} && qm destroy ${vmid}; qmrestore local:backup/vzdump-qemu-nixos-template.vma.zst 9918 --unique --storage local-lvm && qm set ${vmid} --ide2 local-lvm:cloudinit && qm start ${vmid}"
        '';

    };
}
