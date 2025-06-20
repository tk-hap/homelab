locals {
  image_id = jsondecode(data.http.talos_linux_image_id.response_body)
  
  # Collect all image versions from nodes, using default if not specified
  all_image_versions = toset(distinct([
    for node_key, node in var.nodes : 
    coalesce(node.image_version, var.default_image_version)
  ]))
}

data "http" "talos_linux_image_id" {
  url = "https://factory.talos.dev/schematics"
  method = "POST"
  request_headers = {
    "Content-Type" = "application/yaml"
  }
  request_body = file("${path.module}/files/image-schematic.yaml")
}

# Download images for each unique version used by nodes
resource "proxmox_virtual_environment_download_file" "talos_linux_image" {
  for_each = local.all_image_versions

  file_name   = "talos-${each.value}-nocloud-amd64.iso"
  content_type = "iso"
  datastore_id = "local"
  node_name    = "proxmox"
  url          = "https://factory.talos.dev/image/${local.image_id.id}/${each.value}/nocloud-amd64.iso"

  lifecycle {
    create_before_destroy = true
  }
}