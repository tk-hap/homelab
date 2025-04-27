resource "proxmox_virtual_environment_download_file" "talos_linux_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "proxmox"
  url          = "https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/${var.image_version}/nocloud-amd64.iso"
}