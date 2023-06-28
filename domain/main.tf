resource "libvirt_volume" "ubuntu_base_img" {
  name   = "ubuntu_base_img"
  pool   = var.namespace
  source = var.ubuntu_22_img_url
  format = "qcow2"
}

module "node" {
  source   = "./modules/domain"
  for_each = local.node_spec_map

  name     = each.key
  namespace   = var.namespace
  base_img_id = libvirt_volume.ubuntu_base_img.id
  node_group  = each.value.node_group
}
