# Homelab Repository

This repository contains infrastructure and application configurations for my personal homelab environment. It uses Terraform for provisioning virtual machines and clusters on Proxmox, as well as Argo CD for managing Kubernetes applications.

## Repository Structure
```
homelab/
├── apps/                           # Kubernetes applications managed by Argo CD
├── infra/
│   ├── tf/                         # Terraform infrastructure configuration
│   │   └── modules/                # Internal terraform modules
│   └── ansible/                    # Ansible playbooks
└── README.md                       # You are here
```

## Technology Stack

- **Infrastructure**: Proxmox VE hypervisor
- **Kubernetes Distribution**: Vanilla Kubernetes on Talos Linux
- **Infrastructure as Code**: Terraform
- **GitOps**: Argo CD
- **Container Registry**: Harbor
- **Storage**: Longhorn distributed block storage
- **Certificate Management**: cert-manager with self-signed CA

## Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd homelab
   ```

2. **Configure Proxmox credentials**:
   ```bash
   cd infra/tf
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your Proxmox details
   ```

3. **Deploy infrastructure**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. **Access the cluster**:
   ```bash
   # Get kubeconfig from Terraform output
   terraform output -raw kube_config > ~/.kube/config
   kubectl get nodes