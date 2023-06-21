resource "libvirt_network" "vlan_network" {
  autostart = true
  name      = "example"
  mode      = "bridge"
  domain    = "cluster.io"
  bridge    = "br0"
}

resource "libvirt_pool" "kvm_pool" {
  name = "example"
  type = "dir"
  path = pathexpand("~/.kvm/example")
}

resource "libvirt_volume" "base_image" {
  name   = "base_image"
  pool   = "example"
  source = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "ubuntu_qcow2" {
  name           = "vm1"
  pool           = "example"
  base_volume_id = libvirt_volume.base_image.id 
  size           = 10 * 1073741824
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name = "vm1_commoninit.iso"
  pool = "example"
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
    hostname = "vm1"
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
