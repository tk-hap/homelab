# Homelab Repository

This repository contains infrastructure and application configurations for my personal homelab environment. It uses Terraform for provisioning virtual machines and clusters on Proxmox, as well as Argo CD for managing Kubernetes applications.

## Repository Structure

• [apps/](apps/) – Contains Kubernetes application manifests managed by Argo CD.  
  – [cert-manager](apps/cert-manager/application.yaml): Installs a CA issuer ([ca.yaml](apps/cert-manager/resources/ca.yaml)) for certificate management.  
  – [harbor](apps/harbor/application.yaml): Deploys the Harbor registry with a custom TLS certificate ([harbor-certificate.yaml](apps/harbor/resources/harbor-certificate.yaml)).  
  – [knative](apps/knative/knative-serving-controller.yaml): Deploys Knative Serving controller.  
  – [longhorn](apps/longhorn/application.yaml): Installs the Longhorn block storage system ([namespace.yaml](apps/longhorn/resources/namespace.yaml)).  

• [infra/tf/](infra/tf/) – Contains Terraform configurations for creating and configuring a Talos cluster on Proxmox.  
  – [main.tf](infra/tf/main.tf): Declares the Talos module ([modules/talos](infra/tf/modules/talos/)) and sets up node definitions.  
  – [variables.tf](infra/tf/variables.tf), [providers.tf](infra/tf/providers.tf), [outputs.tf](infra/tf/outputs.tf): Manage Terraform inputs, providers, and outputs.  
  – [modules/talos](infra/tf/modules/talos/): Module to provision VMs and bootstrap a Talos Kubernetes cluster.  

• [infra/ansible/](infra/ansible/) – Simple Ansible playbook ([development-host.yml](infra/ansible/development-host.yml)) for local development setup.  

## Usage

1. Install Terraform, Proxmox, and other prerequisites.  
2. Initialize and apply the Terraform configuration in [infra/tf/](infra/tf/):  
   ```sh
   terraform init
   terraform apply
   ```

## Notes

• Certificates and CA resources are managed by cert-manager to secure internal services.

• Harbor is exposed over TLS for artifact management.

• Longhorn provides block storage to persistent workloads.

For cluster administration, reviewed outputs include the generated kubeconfig in infra/tf/outputs.tf and the secrets in infra/tf/modules/talos/outputs.tf.