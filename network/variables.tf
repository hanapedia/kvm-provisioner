variable "libvirt_uri" {
  description = "uri for libvirt namespace"
  type        = string
  default     = "qemu:///system"
}

variable "namespace" {
  description = "base name for the related resources"
  type        = string
  default     = "lab"
}

variable "bridge" {
  description = "bridge name connected to lan"
  type        = string
  default     = "br0"
}

variable "vnet" {
  description = "vars for vnet"
  type = object({
    gateway = string
    cidr    = number
  })
  default = {
    gateway = "192.168.101.1"
    cidr = 24
  }
}
