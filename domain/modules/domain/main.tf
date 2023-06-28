resource "libvirt_volume" "base_qcow2" {
  name           = var.name
  pool           = var.namespace
  base_volume_id = var.base_img_id
  size           = try(local.node_group_specs[var.node_group].disk, local.node_group_specs["default"].disk) * local.disk_multiplyer
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name = "${var.name}_cloudinit.iso"
  pool = var.namespace
  user_data = templatefile("${path.module}/templates/cloudinit.tftpl",
    {
      hostname = var.name
      fqdn     = var.name
    }
  )
}

resource "libvirt_domain" "vm_domain" {
  name      = var.name
  memory    = try(local.node_group_specs[var.node_group].memory, local.node_group_specs["default"].memory) * local.memory_multiplyer
  vcpu      = try(local.node_group_specs[var.node_group].cpu, local.node_group_specs["default"].cpu)
  autostart = true

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  network_interface {
    network_name   = "${var.namespace}-nat"
    wait_for_lease = true
  }

  network_interface {
    network_name = "${var.namespace}-bridge"
  }

  disk {
    volume_id = libvirt_volume.base_qcow2.id
  }
}
