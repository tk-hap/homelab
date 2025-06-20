module "talos" {
  source = "./modules/talos"

  default_image_version = "v1.10.1"

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
      image_version = "v1.10.1"
    }
    "control-02" = {
      ip           = "192.168.0.206"
      cpu          = 2
      ram          = 12000
      machine_type = "controlplane"
      image_version = "v1.10.1"
    }
    "control-03" = {
      ip           = "192.168.0.207"
      cpu          = 2
      ram          = 12000
      machine_type = "controlplane"
      image_version = "v1.10.1"
    }
  }
}