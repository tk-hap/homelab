variable "proxmox_ve_pass" {
  type        = string
  default     = "SECURE_STRING"
  description = "The password for proxmox ve"
}

variable "proxmox_ve_host" {
  type        = string
  default     = "proxmox"
  description = "Name of proxmox node"
}
