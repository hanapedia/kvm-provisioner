resource "libvirt_pool" "kvm_pool" {
  name = var.namespace
  type = "dir"
  path = pathexpand("~/.kvm/${var.namespace}")
}
