variable "libvirt_uri" {
  description = "uri for libvirt namespace"
  type        = string
  # default     = "qemu+ssh://hanapedia@ubuntuhome/system"
}

variable "namespace" {
  description = "name for libvirt resources"
  type        = string
  # default     = "k8s"
}

variable "version" {
  description = "version for libvirt resources"
  type        = string
  # default     = "k8s"
}

variable "domain" {
  description = "domain name for local dns"
  type        = string
  # default = "k8s.local"
}

variable "bridge" {
  description = "bridge name connected to lan"
  type        = string
  # default = "k8s.local"
}
