# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provision "shell", inline: <<~EOF
	pacman-key --init
	pacman-key --refresh-keys
	pacman-key --populate
    pacman -Syu --noconfirm --needed git ansible python python-passlib 
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
  EOF

  config.vm.provision :file, source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"
  config.vm.provision :file, source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
  config.vm.provision :shell, inline: "chmod 600 ~/.ssh/id_rsa", privileged: false
  config.vm.provision :shell, inline: "chmod 600 ~/.ssh/id_rsa.pub", privileged: false
end

