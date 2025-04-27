module "talos" {
  source = "./modules/talos"

  image_version = "v1.9.5"

  cluster = {
    name          = "homelab-01"
    endpoint      = "192.168.0.205"
    gateway       = "192.168.0.1"
    talos_version = "v1.9"
  }

  nodes = {
    "control-01" = {
      ip           = "192.168.0.205"
      cpu          = 2
      ram          = 12000
      machine_type = "controlplane"
    }
    "control-02" = {
      ip           = "192.168.0.206"
      cpu          = 2
      ram          = 12000
      machine_type = "controlplane"
    }
    "control-03" = {
      ip           = "192.168.0.207"
      cpu          = 2
      ram          = 12000
      machine_type = "controlplane"
    }
  }
}