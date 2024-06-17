terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.59.0"
    }

  }
}

provider "proxmox" {
  endpoint = "https://192.168.0.254:8006"
  username = "root@pam"
  # use PROXMOX_VE_PASSWORD env var 'password = ""'
  insecure = true
  tmp_dir  = "/var/tmp"

  ssh {
    agent = true
  }
}
