variable "nodes" {
  type = map(object({
    ip           = string
    cpu          = number
    ram          = number
    machine_type = string
  }))
  description = "Nodes configuration"
}

variable "cluster" {
  type = object({
    name          = string
    endpoint      = string
    gateway       = string
    talos_version = string
  })
  description = "Cluster configuration"
}

variable "image_version" {
  type        = string
  description = "Talos image version"
  default     = "v1.9.5"
}