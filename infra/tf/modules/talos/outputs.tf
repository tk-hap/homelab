output "client_configuration" {
  value     = data.talos_client_configuration.this
  sensitive = true
  description = "Talosctl client configuration for kubectl access"
}

output "kube_config" {
  value     = data.talos_cluster_kubeconfig.this
  sensitive = true
  description = "Kubeconfig for accessing the Talos cluster"
}