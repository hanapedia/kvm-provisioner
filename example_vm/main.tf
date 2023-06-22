resource "libvirt_volume" "ubuntu_qcow2" {
  name             = "vm1"
  # pool             = "example"
  base_volume_name = "base_image"
  size             = 10 * 1073741824
  format           = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name = "vm1_commoninit.iso"
  # pool = "example"
  user_data = templatefile("./templates/cloud_init.tftpl",
    {
      hostname = "vm1"
      fqdn     = "vm1.cluster.io"
    }
  )
}


resource "libvirt_domain" "ubuntu_domain" {
  name      = "vm1"
  memory    = 8 * 1024
  vcpu      = 4
  autostart = true

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name   = "example"
    wait_for_lease = true
    hostname       = "vm1"
    #   addresses      = var.network_interface_address
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  disk {
    volume_id = libvirt_volume.ubuntu_qcow2.id
  }
}
