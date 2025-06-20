variable "nodes" {
  type = map(object({
    ip           = string
    cpu          = number
    ram          = number
    machine_type = string
    image_version = optional(string)
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

variable "default_image_version" {
  description = "Default Talos image version for nodes not specified in nodes map"
  type        = string
  default     = "v1.9.5"
}