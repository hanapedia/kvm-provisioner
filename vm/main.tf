resource "libvirt_volume" "ubuntu_base_img" {
  name   = "ubuntu_base_img"
  pool   = var.versioned_namespace
  source = var.ubuntu_22_img_url
  format = "qcow2"
}

module "node" {
  count  = var.num_node
  source = "./modules/vm_instance"

  vm_name      = "${var.cluster_name}-node${count.index + 1}"
  cluster_name = var.cluster_name
  namespace    = var.versioned_namespace
  base_img_id  = libvirt_volume.ubuntu_base_img.id
  domain       = var.domain
  ssh_keys     = var.ssh_keys
  disk_size    = var.disk_size_n
  memory       = var.memory_n
  cpu          = var.cpu_n
}
