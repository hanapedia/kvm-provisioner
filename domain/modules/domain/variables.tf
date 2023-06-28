variable "name" {
  description = "name for the vm instance"
  type        = string
  default     = "small.lab1.vm1"
}

variable "namespace" {
  description = "namespace for the virtual resources"
  type        = string
  default     = "lab"
}

variable "base_img_id" {
  description = "ubuntu 22.04 base image id"
  type        = string
}

variable "node_group" {
  description = "node group"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["small", "medium", "large"], var.node_group)
    error_message = "Must be either small, medium, or large"
  }
}

locals {
  node_group_specs = {
    "default" = {
      cpu    = 4
      memory = 8
      disk   = 20
    }
    "small" = {
      cpu    = 2
      memory = 4
      disk   = 10
    }
    "medium" = {
      cpu    = 4
      memory = 8
      disk   = 20
    }
    "large" = {
      cpu    = 8
      memory = 16
      disk   = 40
    }
  }
  memory_multiplyer = 1024
  disk_multiplyer   = 1073741824
}
