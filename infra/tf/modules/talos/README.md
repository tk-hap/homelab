## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0.60.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >=0.8.0-alpha.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >=0.60.0 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | >=0.8.0-alpha.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.talos_linux_image](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_vm.talos_node](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_secrets) | resource |
| [http_http.talos_linux_image_id](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [talos_client_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/client_configuration) | data source |
| [talos_cluster_health.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/cluster_health) | data source |
| [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/cluster_kubeconfig) | data source |
| [talos_machine_configuration.controlplane](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.worker](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Cluster configuration | <pre>object({<br/>    name          = string<br/>    endpoint      = string<br/>    gateway       = string<br/>    talos_version = string<br/>  })</pre> | n/a | yes |
| <a name="input_default_image_version"></a> [default\_image\_version](#input\_default\_image\_version) | Default Talos image version for nodes not specified in nodes map | `string` | `"v1.9.5"` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | Nodes configuration | <pre>map(object({<br/>    ip           = string<br/>    cpu          = number<br/>    ram          = number<br/>    machine_type = string<br/>    image_version = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_configuration"></a> [client\_configuration](#output\_client\_configuration) | Talosctl client configuration for kubectl access |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubeconfig for accessing the Talos cluster |
