resource "libvirt_network" "vlan_network" {
  autostart = true
  name      = "example"
  mode      = "bridge"
  bridge    = "br0"

  addresses = ["192.168.100.0/24"]
}

resource "libvirt_network" "vnet_network" {
  autostart = true
  name      = "vnet"
  mode      = "nat"

  addresses = ["192.168.200.0/24"]

  dns {
    enabled = true
  }
}
