resource "libvirt_network" "vlan_network" {
  autostart = true
  name      = "example"
  mode      = "bridge"
  bridge    = "br0"
}
#
# resource "libvirt_pool" "kvm_pool" {
#   name = "example"
#   type = "dir"
#   path = pathexpand("~/.kvm/example")
# }
#
resource "libvirt_volume" "base_image" {
  name   = "base_image"
  # pool   = "example"
  source = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
  format = "qcow2"
}
