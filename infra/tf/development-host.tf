data "local_file" "ssh_public_key" {
  filename = "./id_rsa.pub"
}

resource "proxmox_virtual_environment_vm" "development_ubuntu_vm" {
  name      = "development-ubuntu"
  node_name = "proxmox"

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.0.15/24"
        gateway = "192.168.0.1"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config_development.id
  }

  cpu {
    cores        = 2
    architecture = "x86_64"
  }

  memory {
    dedicated = 16384
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config_development" {

  content_type = "snippets"
  datastore_id = "local"
  node_name    = "proxmox"

  source_raw {
    data = <<-EOF
        #cloud-config
        users:
          - default
          - name: ubuntu
            groups:
              - sudo
            shell: /bin/bash
            ssh_authorized_keys:
              - ${trimspace(data.local_file.ssh_public_key.content)}
            sudo: ALL=(ALL) NOPASSWD:ALL
        runcmd:
          - apt update
          - apt install -y ansible-core
          - ansible-pull -U https://github.com/tk-hap/homelab infra/ansible/development-host.yml
          - echo "done" > /tmp/cloud-config.done
        EOF

    file_name = "cloud-config-development.yaml"
  }
}
