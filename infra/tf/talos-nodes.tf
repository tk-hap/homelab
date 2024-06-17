resource "proxmox_virtual_environment_vm" "talos_node" {
  count     = 3
  name      = "talos-node-${count.index}"
  node_name = "proxmox"

  cpu {
    cores        = 2
    architecture = "x86_64"
    type         = "host"
  }

  memory {
    dedicated = 12000
  }

  disk {
    datastore_id = "local"
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  cdrom {
    enabled   = true
    file_id   = proxmox_virtual_environment_download_file.talos_linux_image.id
    interface = "ide2"
  }

  network_device {
    bridge = "vmbr0"
  }

  agent {
    enabled = true
  }
}

output "nodes_ipv4" {
  value = [proxmox_virtual_environment_vm.talos_node.*.ipv4_addresses]
}
