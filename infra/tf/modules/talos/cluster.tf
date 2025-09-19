locals {
  # Create maps instead of tuples for control planes and workers
  nodes = {
    controlplanes = {
      for name, node in var.nodes : name => node
      if node.machine_type == "controlplane"
    }
    workers = {
      for name, node in var.nodes : name => node
      if node.machine_type == "worker"
    }
  }
  # Create lists of IPs for when we need just the IPs
  controlplane_ips = [for node in local.nodes.controlplanes : node.ip]
  worker_ips       = [for node in local.nodes.workers : node.ip]
}

resource "talos_machine_secrets" "this" {}

data "talos_machine_configuration" "controlplane" {
  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint}:6443"
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_machine_configuration" "worker" {
  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint}:6443"
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster.name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = local.controlplane_ips
}

resource "talos_machine_configuration_apply" "controlplane" {
  depends_on                  = [proxmox_virtual_environment_vm.talos_node]
  for_each                    = local.nodes.controlplanes
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.value.ip
  config_patches = [
    file("${path.module}/files/machine-config/cp-scheduling.yaml"),
    file("${path.module}/files/machine-config/longhorn.yaml"),
    file("${path.module}/files/machine-config/custom-ca.yaml"),
    file("${path.module}/files/machine-config/cni.yaml"),
  ]
}

resource "talos_machine_configuration_apply" "worker" {
  depends_on                  = [proxmox_virtual_environment_vm.talos_node]
  for_each                    = local.nodes.workers
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = each.value.ip
  config_patches = [
    file("${path.module}/files/machine-config/longhorn.yaml"),
    file("${path.module}/files/machine-config/custom-ca.yaml"),
    file("${path.module}/files/machine-config/cni.yaml"),
  ]
}

resource "talos_machine_bootstrap" "this" {
  depends_on = [talos_machine_configuration_apply.controlplane]

  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.controlplane_ips[0]
}

data "talos_cluster_health" "this" {
  depends_on = [
    talos_machine_configuration_apply.controlplane,
    talos_machine_bootstrap.this
    ]

  client_configuration = talos_machine_secrets.this.client_configuration
  control_plane_nodes  = local.controlplane_ips
  endpoints            = data.talos_client_configuration.this.endpoints
  timeouts = {
    read = "5m"
  }
}

data "talos_cluster_kubeconfig" "this" {
  depends_on = [
    talos_machine_bootstrap.this,
  data.talos_cluster_health.this
  ]

  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.controlplane_ips[0]
  endpoint             = var.cluster.endpoint
  timeouts = {
    read = "5m"
  }
}