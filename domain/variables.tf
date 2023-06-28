variable "libvirt_uri" {
  description = "uri for libvirt namespace"
  type        = string
  default     = "qemu:///system"
}

variable "namespace" {
  description = "libvirt network and pool for newly defined vms"
  type        = string
  default     = "lab"
}

variable "ubuntu_22_img_url" {
  description = "ubuntu 22.04 image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

variable "node_configs" {
  description = "list of node configs"
  type = list(object({
    name       = string
    node_group = string
  }))
  default = [{
    "small.lab2.vm1"  = "small"
    "medium.lab2.vm2" = "medium"
    "large.lab2.vm3"  = "large"
  }]
}

local {
  node_spec_map = { for config in var.node_configs : config.name => config }
}
