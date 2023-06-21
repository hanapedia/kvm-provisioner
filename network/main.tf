resource "libvirt_network" "vlan_network" {
  autostart = true
  name      = "${var.namespace}-${var.version}"
  mode      = "bridge"
  domain    = var.domain
  bridge    = var.bridge
}

resource "libvirt_pool" "kvm_pool" {
  name = "${var.namespace}-${var.version}"
  type = "dir"
  path = pathexpand("~/.kvm/${var.namespace}-${var.version}")
}
