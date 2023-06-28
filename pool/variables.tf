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
