resource "proxmox_virtual_environment_vm" "talos_node" {
  name      = "talos-node-01"
  node_name = "proxmox"

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.0.100/24"
        gateway = "192.168.0.1"
      }
    }

  }

  cpu {
    architecture = "x86_64"
    cores        = 2
  }

  memory {
    dedicated = 12000
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos_linux_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}

