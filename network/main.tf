// virtual network to expose vms to vlan
resource "libvirt_network" "vlan_network" {
  autostart = true
  name      = "${var.namespace}-bridge"
  mode      = "bridge"
  bridge    = var.bridge
}

// virtual network for internet accessiblitiy via host
resource "libvirt_network" "vnet_network" {
  autostart = true
  name      = "${var.namespace}-nat"
  mode      = "nat"

  addresses = ["${var.vnet.gateway}/${var.vnet.cidr}"]

  dns {
    enabled = true
  }
}
