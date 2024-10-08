# Privision

## Proxmox template

Cloud image with Cloud init

### Instructions

Download image

```shell
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
```

Create new VM

```shell
qm create 9000 --memory 4096 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
```

Import downloaded disk to local storage. Change (local) to the storage of your choice

```shell
qm disk import 9000 noble-server-cloudimg-amd64.img local
```

Attach the new disk to the vm as a scsi drive on the scsi controller (Change local to the storage of your choice)

```shell
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local:vm-8000-disk-0
```

Add cloud init drive (Change local to the storage of your choice)

```shell
qm set 8000 --ide2 local:cloudinit
```

Make the cloud init drive bootable and restrict BIOS to boot from disk only

```shell
qm set 8000 --boot c --bootdisk scsi0
```

Add serial console

```shell
qm set 8000 --serial0 socket --vga serial0
```

### Configure HW and Cloud-init

Set username, SSH pub key etc. Convert to template when done.

Create template.

```shell
qm template 8000
```

Clone template.

```
qm clone 8000 135 --name ubuntu-clone  --full
```
