terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.8.0-alpha.0"
    }

  }
}

provider "proxmox" {
  endpoint  = var.proxmox.host
  api_token = var.proxmox.api_token
  insecure  = var.proxmox.insecure
  tmp_dir   = "/var/tmp"

  ssh {
    agent = true
  }
}
