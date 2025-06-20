variable "proxmox" {
  type = object({
    host      = string
    api_token = string
    insecure  = bool
  })
  description = "Proxmox provider configuration"
}
