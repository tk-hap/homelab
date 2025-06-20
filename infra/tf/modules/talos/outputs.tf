output "client_configuration" {
  value     = data.talos_client_configuration.this
  sensitive = true
}

output "kube_config" {
  value     = data.talos_cluster_kubeconfig.this
  sensitive = true
}