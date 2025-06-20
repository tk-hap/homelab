resource "proxmox_virtual_environment_vm" "talos_node" {
  for_each  = var.nodes
  name      = "node-${each.key}"
  node_name = "proxmox"

  cpu {
    cores = each.value.cpu
    type  = "host"
  }

  memory {
    dedicated = each.value.ram
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    ssd          = true
    size         = 50
  }

  cdrom {
    file_id = proxmox_virtual_environment_download_file.talos_linux_image[
      coalesce(each.value.image_version, var.default_image_version)
    ].id
    interface    = "ide0"
  }

  boot_order = ["scsi0", "ide0"]

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.cluster.gateway
      }

    }
  }

  network_device {
    bridge = "vmbr0"
  }

  agent {
    enabled = true
  }
}